package alternativa.engine3d.objects {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.VG;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.gfx.core.IndexBufferResource;
  import alternativa.gfx.core.VertexBufferResource;

  use namespace alternativa3d;

  public class Decal extends Mesh {
    public var attenuation:Number = 1000000;

    public function Decal() {
      super();
      shadowMapAlphaThreshold = 100;
    }

    public function createGeometry(param1:Mesh, param2:Boolean = false) : void {
      if(!param2) {
        param1 = param1.clone() as Mesh;
      }
      alternativa3d::faceList = param1.alternativa3d::faceList;
      alternativa3d::vertexList = param1.alternativa3d::vertexList;
      param1.alternativa3d::faceList = null;
      param1.alternativa3d::vertexList = null;
      var local3:Vertex = alternativa3d::vertexList;
      while(local3 != null) {
        local3.alternativa3d::transformId = 0;
        local3.id = null;
        local3 = local3.alternativa3d::next;
      }
      var local4:Face = alternativa3d::faceList;
      while(local4 != null) {
        local4.id = null;
        local4 = local4.alternativa3d::next;
      }
      calculateBounds();
    }

    override public function clone() : Object3D {
      var local1:Decal = new Decal();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      super.clonePropertiesFrom(param1);
      var local2:Decal = param1 as Decal;
      this.attenuation = local2.attenuation;
    }

    override alternativa3d function draw(param1:Camera3D) : void {
      var local3:Face = null;
      var local4:Vertex = null;
      if(alternativa3d::faceList == null) {
        return;
      }
      if(clipping == 0) {
        if(Boolean(alternativa3d::culling & 1)) {
          return;
        }
        alternativa3d::culling = 0;
      }
      this.alternativa3d::prepareResources();
      alternativa3d::useDepth = true;
      if(alternativa3d::faceList.material != null) {
        param1.alternativa3d::addDecal(this);
        alternativa3d::transformConst[0] = alternativa3d::ma;
        alternativa3d::transformConst[1] = alternativa3d::mb;
        alternativa3d::transformConst[2] = alternativa3d::mc;
        alternativa3d::transformConst[3] = alternativa3d::md;
        alternativa3d::transformConst[4] = alternativa3d::me;
        alternativa3d::transformConst[5] = alternativa3d::mf;
        alternativa3d::transformConst[6] = alternativa3d::mg;
        alternativa3d::transformConst[7] = alternativa3d::mh;
        alternativa3d::transformConst[8] = alternativa3d::mi;
        alternativa3d::transformConst[9] = alternativa3d::mj;
        alternativa3d::transformConst[10] = alternativa3d::mk;
        alternativa3d::transformConst[11] = alternativa3d::ml;
      }
      var local2:int = param1.debug ? int(param1.alternativa3d::checkInDebug(this)) : 0;
      if(Boolean(local2 & Debug.BOUNDS)) {
        Debug.alternativa3d::drawBounds(param1,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
      }
      if(Boolean(local2 & Debug.EDGES)) {
        if(alternativa3d::transformId > 500000000) {
          alternativa3d::transformId = 0;
          local4 = alternativa3d::vertexList;
          while(local4 != null) {
            local4.alternativa3d::transformId = 0;
            local4 = local4.alternativa3d::next;
          }
        }
        ++alternativa3d::transformId;
        alternativa3d::calculateInverseMatrix();
        local3 = alternativa3d::prepareFaces(param1,alternativa3d::faceList);
        if(local3 == null) {
          return;
        }
        Debug.alternativa3d::drawEdges(param1,local3,16777215);
      }
    }

    override alternativa3d function getVG(param1:Camera3D) : VG {
      this.alternativa3d::draw(param1);
      return null;
    }

    override alternativa3d function prepareResources() : void {
      var local1:Vector.<Number> = null;
      var local2:int = 0;
      var local3:int = 0;
      var local4:Vertex = null;
      var local5:Vector.<uint> = null;
      var local6:int = 0;
      var local7:Face = null;
      var local8:Wrapper = null;
      var local9:uint = 0;
      var local10:uint = 0;
      var local11:uint = 0;
      if(alternativa3d::vertexBuffer == null) {
        local1 = new Vector.<Number>();
        local2 = 0;
        local3 = 0;
        local4 = alternativa3d::vertexList;
        while(local4 != null) {
          local1[local2] = local4.x;
          local2++;
          local1[local2] = local4.y;
          local2++;
          local1[local2] = local4.z;
          local2++;
          local1[local2] = local4.u;
          local2++;
          local1[local2] = local4.v;
          local2++;
          local1[local2] = local4.normalX;
          local2++;
          local1[local2] = local4.normalY;
          local2++;
          local1[local2] = local4.normalZ;
          local2++;
          local4.alternativa3d::index = local3;
          local3++;
          local4 = local4.alternativa3d::next;
        }
        alternativa3d::vertexBuffer = new VertexBufferResource(local1,8);
        local5 = new Vector.<uint>();
        local6 = 0;
        alternativa3d::numTriangles = 0;
        local7 = alternativa3d::faceList;
        while(local7 != null) {
          local8 = local7.alternativa3d::wrapper;
          local9 = uint(local8.alternativa3d::vertex.alternativa3d::index);
          local8 = local8.alternativa3d::next;
          local10 = uint(local8.alternativa3d::vertex.alternativa3d::index);
          local8 = local8.alternativa3d::next;
          while(local8 != null) {
            local11 = uint(local8.alternativa3d::vertex.alternativa3d::index);
            local5[local6] = local9;
            local6++;
            local5[local6] = local10;
            local6++;
            local5[local6] = local11;
            local6++;
            local10 = local11;
            ++alternativa3d::numTriangles;
            local8 = local8.alternativa3d::next;
          }
          local7 = local7.alternativa3d::next;
        }
        alternativa3d::indexBuffer = new IndexBufferResource(local5);
      }
    }
  }
}
