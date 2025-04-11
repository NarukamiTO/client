package alternativa.tanks.models.controlpoints.hud {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.utils.MathUtils;
  import flash.geom.Point;
  import flash.geom.Vector3D;

  public class ProgressPlane extends Mesh {
    private static const MAX_PROGRESS:Number = 100;

    private var progress:Number = 0;
    private var emptyMaterial:Material;
    private var blueFillingMaterial:Material;
    private var blueFullMaterial:Material;
    private var redFillingMaterial:Material;
    private var redFullMaterial:Material;
    private var _faces:Vector.<Face>;
    private var uvs:Vector.<Point> = new Vector.<Point>();
    private var verts:Vector.<Vector3D> = new Vector.<Vector3D>();

    public function ProgressPlane(param1:Number, param2:Number, param3:Material, param4:Material, param5:Material, param6:Material, param7:Material) {
      super();
      this.emptyMaterial = param3;
      this.blueFillingMaterial = param4;
      this.blueFullMaterial = param5;
      this.redFillingMaterial = param6;
      this.redFullMaterial = param7;
      useShadowMap = false;
      useLight = false;
      shadowMapAlphaThreshold = 2;
      depthMapAlphaThreshold = 2;
      this.createGeometry(param1,param2);
    }

    private function createGeometry(param1:Number, param2:Number) : void {
      var local3:Vertex = null;
      var local4:Vertex = null;
      var local5:Vertex = null;
      var local6:Number = param1 * 0.5;
      var local7:Number = param2 * 0.5;
      this.verts[0] = new Vector3D(0,local7,0);
      this.verts[1] = new Vector3D(-local6,0,0);
      this.verts[2] = new Vector3D(0,-local7,0);
      this.verts[3] = new Vector3D(local6,0,0);
      this.uvs[0] = new Point(0.5,-0.5);
      this.uvs[1] = new Point(-0.5,0.5);
      this.uvs[2] = new Point(0.5,1.5);
      this.uvs[3] = new Point(1.5,0.5);
      this._faces = new Vector.<Face>();
      local3 = this.createVertex(-local6,0,0,-0.5,0.5);
      local4 = this.createVertex(0,0,0,0.5,0.5);
      local5 = this.createVertex(0,local7,0,0.5,-0.5);
      this._faces[0] = this.createFace(local3,local4,local5,this.emptyMaterial);
      local3 = this.createVertex(0,-local7,0,0.5,1.5);
      local4 = this.createVertex(0,0,0,0.5,0.5);
      local5 = this.createVertex(-local6,0,0,-0.5,0.5);
      this._faces[1] = this.createFace(local3,local4,local5,this.emptyMaterial);
      local3 = this.createVertex(local6,0,0,1.5,0.5);
      local4 = this.createVertex(0,0,0,0.5,0.5);
      local5 = this.createVertex(0,-local7,0,0.5,1.5);
      this._faces[2] = this.createFace(local3,local4,local5,this.emptyMaterial);
      local3 = this.createVertex(0,local7,0,0.5,-0.5);
      local4 = this.createVertex(0,0,0,0.5,0.5);
      local5 = this.createVertex(local6,0,0,1.5,0.5);
      this._faces[3] = this.createFace(local3,local4,local5,this.emptyMaterial);
      local3 = this.createVertex(0,0,0,0,0);
      local4 = this.createVertex(0,0,0,0.5,0.5);
      local5 = this.createVertex(0,0,0,0,0);
      this._faces[4] = this.createFace(local3,local4,local5,this.emptyMaterial);
    }

    private function createVertex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Vertex {
      var local6:Vertex = new Vertex();
      local6.x = param1;
      local6.y = param2;
      local6.z = param3;
      local6.u = param4;
      local6.v = param5;
      local6.next = vertexList;
      vertexList = local6;
      return local6;
    }

    private function createFace(param1:Vertex, param2:Vertex, param3:Vertex, param4:Material) : Face {
      var local5:Face = null;
      local5 = new Face();
      local5.material = param4;
      local5.wrapper = new Wrapper();
      local5.wrapper.vertex = param1;
      local5.wrapper.next = new Wrapper();
      local5.wrapper.next.vertex = param2;
      local5.wrapper.next.next = new Wrapper();
      local5.wrapper.next.next.vertex = param3;
      local5.normalX = 0;
      local5.normalY = 0;
      local5.normalZ = 1;
      local5.offset = 0;
      local5.next = faceList;
      faceList = local5;
      return local5;
    }

    public function updateRotation(param1:Camera3D) : void {
      rotationX = param1.rotationX - Math.PI;
      rotationY = 0;
      rotationZ = param1.rotationZ;
    }

    public function setProgress(param1:Number) : void {
      var local2:Number = MathUtils.clamp(param1,-MAX_PROGRESS,MAX_PROGRESS);
      if(this.progress != local2) {
        this.progress = local2;
        this.update();
      }
    }

    private function update() : void {
      var local5:Face = null;
      var local6:Vertex = null;
      var local7:Vertex = null;
      var local8:Vector3D = null;
      var local9:Vector3D = null;
      var local10:Point = null;
      var local11:Point = null;
      var local12:Face = null;
      var local16:int = 0;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local1:Number = this.progress / MAX_PROGRESS;
      var local2:Number = Math.abs(local1);
      var local3:int = 4 * local2;
      var local4:int = (local3 + 1) % 4;
      var local13:Material = local1 < 0 ? this.redFillingMaterial : this.blueFillingMaterial;
      var local14:Material = local1 < 0 ? this.redFullMaterial : this.blueFullMaterial;
      var local15:int = 0;
      while(local15 < 4) {
        local5 = this._faces[local15];
        if(local15 < local3) {
          local5.material = local2 == 1 ? local14 : local13;
        } else if(local15 > local3) {
          local5.material = this.emptyMaterial;
        }
        local6 = local5.wrapper.vertex;
        local16 = (local15 + 1) % 4;
        local9 = this.verts[local16];
        local11 = this.uvs[local16];
        local6.x = local9.x;
        local6.y = local9.y;
        local6.u = local11.x;
        local6.v = local11.y;
        local15++;
      }
      local12 = this._faces[4];
      if(local2 == 1) {
        local7 = local12.wrapper.next.next.vertex;
        local7.x = 0;
        local7.y = 0;
        local7.u = 0;
        local7.v = 0;
        local7 = local12.wrapper.vertex;
        local7.x = 0;
        local7.y = 0;
        local7.u = 0;
        local7.v = 0;
      } else {
        local5 = this._faces[local3];
        local5.material = local13;
        local8 = this.verts[0];
        local10 = this.uvs[0];
        local9 = this.verts[local4];
        local11 = this.uvs[local4];
        local6 = local5.wrapper.vertex;
        local17 = 2 * local2 * Math.PI;
        local18 = Math.cos(local17);
        local19 = Math.sin(local17);
        local6.x = local8.x * local18 - local8.y * local19;
        local6.y = local8.x * local19 + local8.y * local18;
        local19 = -local19;
        local6.u = 0.5 + (local10.x - 0.5) * local18 - (local10.y - 0.5) * local19;
        local6.v = 0.5 + (local10.x - 0.5) * local19 + (local10.y - 0.5) * local18;
        local7 = local12.wrapper.vertex;
        local7.x = local9.x;
        local7.y = local9.y;
        local7.u = local11.x;
        local7.v = local11.y;
        local7 = local12.wrapper.next.next.vertex;
        local7.x = local6.x;
        local7.y = local6.y;
        local7.u = local6.u;
        local7.v = local6.v;
      }
    }
  }
}
