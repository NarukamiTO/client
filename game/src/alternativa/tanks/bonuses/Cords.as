package alternativa.tanks.bonuses {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;

  public class Cords extends BonusObject3DBase {
    private static const meshMatrix:Matrix4 = new Matrix4();

    private var topVertices:Vector.<Vertex>;
    private var topLocalPoints:Vector.<Vector3>;
    private var boxVertex:Vertex;
    private var boxLocalPoint:Vector3;
    private var numStraps:int;
    private var bonusMesh:BonusObject3DBase;
    private var parachute:Parachute;
    private var mesh:Mesh;

    public function Cords(param1:Number, param2:Number, param3:int, param4:Material) {
      super();
      this.numStraps = param3;
      this.mesh = new Mesh();
      object = this.mesh;
      this.topVertices = new Vector.<Vertex>(2 * param3);
      this.topLocalPoints = new Vector.<Vector3>(param3);
      this.createGeometry(param1,param2);
      this.mesh.setMaterialToAllFaces(param4);
      this.mesh.shadowMapAlphaThreshold = 2;
      this.mesh.depthMapAlphaThreshold = 2;
    }

    public function init(param1:BonusObject3DBase, param2:Parachute) : void {
      this.bonusMesh = param1;
      this.parachute = param2;
      this.mesh.scaleX = 1;
      this.mesh.scaleY = 1;
      this.mesh.scaleZ = 1;
      setAlpha(1);
      setAlphaMultiplier(1);
    }

    public function recycle() : void {
      removeFromScene();
      this.bonusMesh = null;
      this.parachute = null;
      BonusCache.putCords(this);
    }

    public function updateVertices() : void {
      var local1:Vector3 = null;
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Vertex = null;
      this.parachute.readTransform(meshMatrix);
      var local2:int = 0;
      while(local2 < this.numStraps) {
        local1 = this.topLocalPoints[local2];
        local3 = local1.x * meshMatrix.m00 + local1.y * meshMatrix.m01 + local1.z * meshMatrix.m02 + meshMatrix.m03;
        local4 = local1.x * meshMatrix.m10 + local1.y * meshMatrix.m11 + local1.z * meshMatrix.m12 + meshMatrix.m13;
        local5 = local1.x * meshMatrix.m20 + local1.y * meshMatrix.m21 + local1.z * meshMatrix.m22 + meshMatrix.m23;
        local6 = this.topVertices[2 * local2];
        local6.x = local3;
        local6.y = local4;
        local6.z = local5;
        local6 = this.topVertices[2 * local2 + 1];
        local6.x = local3;
        local6.y = local4;
        local6.z = local5;
        local2++;
      }
      this.bonusMesh.readTransform(meshMatrix);
      local1 = this.boxLocalPoint;
      this.boxVertex.x = local1.x * meshMatrix.m00 + local1.y * meshMatrix.m01 + local1.z * meshMatrix.m02 + meshMatrix.m03;
      this.boxVertex.y = local1.x * meshMatrix.m10 + local1.y * meshMatrix.m11 + local1.z * meshMatrix.m12 + meshMatrix.m13;
      this.boxVertex.z = local1.x * meshMatrix.m20 + local1.y * meshMatrix.m21 + local1.z * meshMatrix.m22 + meshMatrix.m23;
      this.mesh.calculateBounds();
      this.mesh.calculateFacesNormals();
    }

    private function createGeometry(param1:Number, param2:Number) : void {
      var local6:Number = NaN;
      var local7:Vector3 = null;
      var local8:int = 0;
      var local9:int = 0;
      this.boxLocalPoint = new Vector3(0,0,param2);
      this.boxVertex = this.createVertex(0,0,param2,0,1);
      var local3:Number = 2 * Math.PI / this.numStraps;
      var local4:int = 0;
      while(local4 < this.numStraps) {
        local6 = local4 * local3;
        local7 = new Vector3(param1 * Math.cos(local6),param1 * Math.sin(local6),0);
        this.topLocalPoints[local4] = local7;
        this.topVertices[2 * local4] = this.createVertex(local7.x,local7.y,local7.z,0,0);
        this.topVertices[2 * local4 + 1] = this.createVertex(local7.x,local7.y,local7.z,1,1);
        local4++;
      }
      var local5:int = 0;
      while(local5 < this.numStraps) {
        local8 = 2 * local5;
        local9 = local8 + 3;
        if(local9 >= 2 * this.numStraps) {
          local9 -= 2 * this.numStraps;
        }
        this.createTriFace(this.boxVertex,this.topVertices[local8],this.topVertices[local9]);
        this.createTriFace(this.boxVertex,this.topVertices[local9],this.topVertices[local8]);
        local5++;
      }
    }

    private function createVertex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Vertex {
      var local6:Vertex = new Vertex();
      local6.next = this.mesh.vertexList;
      this.mesh.vertexList = local6;
      local6.x = param1;
      local6.y = param2;
      local6.z = param3;
      local6.u = param4;
      local6.v = param5;
      return local6;
    }

    private function createTriFace(param1:Vertex, param2:Vertex, param3:Vertex) : Face {
      var local4:Face = new Face();
      local4.next = this.mesh.faceList;
      this.mesh.faceList = local4;
      local4.wrapper = new Wrapper();
      local4.wrapper.vertex = param1;
      local4.wrapper.next = new Wrapper();
      local4.wrapper.next.vertex = param2;
      local4.wrapper.next.next = new Wrapper();
      local4.wrapper.next.next.vertex = param3;
      return local4;
    }
  }
}
