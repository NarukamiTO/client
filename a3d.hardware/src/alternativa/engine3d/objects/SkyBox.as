package alternativa.engine3d.objects {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Clipping;
  import alternativa.engine3d.core.Debug;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.core.VG;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import alternativa.gfx.core.IndexBufferResource;
  import alternativa.gfx.core.VertexBufferResource;
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class SkyBox extends Mesh {
    public static const LEFT:String = "left";
    public static const RIGHT:String = "right";
    public static const BACK:String = "back";
    public static const FRONT:String = "front";
    public static const BOTTOM:String = "bottom";
    public static const TOP:String = "top";

    private var leftFace:Face;
    private var rightFace:Face;
    private var backFace:Face;
    private var frontFace:Face;
    private var bottomFace:Face;
    private var topFace:Face;

    public var autoSize:Boolean = true;

    alternativa3d var reduceConst:Vector.<Number> = Vector.<Number>([0,0,0,1]);

    public function SkyBox(param1:Number, param2:Material = null, param3:Material = null, param4:Material = null, param5:Material = null, param6:Material = null, param7:Material = null, param8:Number = 0) {
      super();
      param1 *= 0.5;
      var local9:Vertex = this.createVertex(-param1,-param1,param1,param8,param8);
      var local10:Vertex = this.createVertex(-param1,-param1,-param1,param8,1 - param8);
      var local11:Vertex = this.createVertex(-param1,param1,-param1,1 - param8,1 - param8);
      var local12:Vertex = this.createVertex(-param1,param1,param1,1 - param8,param8);
      this.leftFace = this.createQuad(local9,local10,local11,local12,param2);
      local9 = this.createVertex(param1,param1,param1,param8,param8);
      local10 = this.createVertex(param1,param1,-param1,param8,1 - param8);
      local11 = this.createVertex(param1,-param1,-param1,1 - param8,1 - param8);
      local12 = this.createVertex(param1,-param1,param1,1 - param8,param8);
      this.rightFace = this.createQuad(local9,local10,local11,local12,param3);
      local9 = this.createVertex(param1,-param1,param1,param8,param8);
      local10 = this.createVertex(param1,-param1,-param1,param8,1 - param8);
      local11 = this.createVertex(-param1,-param1,-param1,1 - param8,1 - param8);
      local12 = this.createVertex(-param1,-param1,param1,1 - param8,param8);
      this.backFace = this.createQuad(local9,local10,local11,local12,param4);
      local9 = this.createVertex(-param1,param1,param1,param8,param8);
      local10 = this.createVertex(-param1,param1,-param1,param8,1 - param8);
      local11 = this.createVertex(param1,param1,-param1,1 - param8,1 - param8);
      local12 = this.createVertex(param1,param1,param1,1 - param8,param8);
      this.frontFace = this.createQuad(local9,local10,local11,local12,param5);
      local9 = this.createVertex(-param1,param1,-param1,param8,param8);
      local10 = this.createVertex(-param1,-param1,-param1,param8,1 - param8);
      local11 = this.createVertex(param1,-param1,-param1,1 - param8,1 - param8);
      local12 = this.createVertex(param1,param1,-param1,1 - param8,param8);
      this.bottomFace = this.createQuad(local9,local10,local11,local12,param6);
      local9 = this.createVertex(-param1,-param1,param1,param8,param8);
      local10 = this.createVertex(-param1,param1,param1,param8,1 - param8);
      local11 = this.createVertex(param1,param1,param1,1 - param8,1 - param8);
      local12 = this.createVertex(param1,-param1,param1,1 - param8,param8);
      this.topFace = this.createQuad(local9,local10,local11,local12,param7);
      calculateBounds();
      calculateFacesNormals(true);
      clipping = Clipping.FACE_CLIPPING;
      sorting = Sorting.NONE;
      shadowMapAlphaThreshold = 100;
    }

    public function getSide(param1:String) : Face {
      switch(param1) {
        case LEFT:
          return this.leftFace;
        case RIGHT:
          return this.rightFace;
        case BACK:
          return this.backFace;
        case FRONT:
          return this.frontFace;
        case BOTTOM:
          return this.bottomFace;
        case TOP:
          return this.topFace;
        default:
          return null;
      }
    }

    public function transformUV(param1:String, param2:Matrix) : void {
      var local4:Wrapper = null;
      var local5:Vertex = null;
      var local6:Point = null;
      var local3:Face = this.getSide(param1);
      if(local3 != null) {
        local4 = local3.alternativa3d::wrapper;
        while(local4 != null) {
          local5 = local4.alternativa3d::vertex;
          local6 = param2.transformPoint(new Point(local5.u,local5.v));
          local5.u = local6.x;
          local5.v = local6.y;
          local4 = local4.alternativa3d::next;
        }
      }
    }

    override public function clone() : Object3D {
      var local1:SkyBox = new SkyBox(0);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      super.clonePropertiesFrom(param1);
      var local2:SkyBox = param1 as SkyBox;
      this.autoSize = local2.autoSize;
      var local3:Face = local2.alternativa3d::faceList;
      var local4:Face = alternativa3d::faceList;
      while(local3 != null) {
        if(local3 == local2.leftFace) {
          this.leftFace = local4;
        } else if(local3 == local2.rightFace) {
          this.rightFace = local4;
        } else if(local3 == local2.backFace) {
          this.backFace = local4;
        } else if(local3 == local2.frontFace) {
          this.frontFace = local4;
        } else if(local3 == local2.bottomFace) {
          this.bottomFace = local4;
        } else if(local3 == local2.topFace) {
          this.topFace = local4;
        }
        local3 = local3.alternativa3d::next;
        local4 = local4.alternativa3d::next;
      }
    }

    private function createVertex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Vertex {
      var local6:Vertex = new Vertex();
      local6.alternativa3d::next = alternativa3d::vertexList;
      alternativa3d::vertexList = local6;
      local6.x = param1;
      local6.y = param2;
      local6.z = param3;
      local6.u = param4;
      local6.v = param5;
      return local6;
    }

    private function createQuad(param1:Vertex, param2:Vertex, param3:Vertex, param4:Vertex, param5:Material) : Face {
      var local6:Face = new Face();
      local6.material = param5;
      local6.alternativa3d::next = alternativa3d::faceList;
      alternativa3d::faceList = local6;
      local6.alternativa3d::wrapper = new Wrapper();
      local6.alternativa3d::wrapper.alternativa3d::vertex = param1;
      local6.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
      local6.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = param2;
      local6.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
      local6.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = param3;
      local6.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next = new Wrapper();
      local6.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = param4;
      return local6;
    }

    override alternativa3d function draw(param1:Camera3D) : void {
      if(alternativa3d::faceList == null) {
        return;
      }
      if(this.autoSize) {
        this.calculateTransform(param1);
      }
      if(clipping == 0) {
        if(Boolean(alternativa3d::culling & 1)) {
          return;
        }
        alternativa3d::culling = 0;
      }
      this.alternativa3d::prepareResources();
      this.alternativa3d::addOpaque(param1);
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
      var local2:int = param1.debug ? int(param1.alternativa3d::checkInDebug(this)) : 0;
      if(Boolean(local2 & Debug.BOUNDS)) {
        Debug.alternativa3d::drawBounds(param1,this,boundMinX,boundMinY,boundMinZ,boundMaxX,boundMaxY,boundMaxZ);
      }
    }

    override alternativa3d function prepareResources() : void {
      var local1:Vector.<Number> = null;
      var local2:int = 0;
      var local3:int = 0;
      var local4:Vertex = null;
      var local5:int = 0;
      var local6:int = 0;
      var local7:int = 0;
      var local8:Face = null;
      var local9:Array = null;
      var local10:Wrapper = null;
      var local11:Dictionary = null;
      var local12:Vector.<uint> = null;
      var local13:int = 0;
      var local14:* = undefined;
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
        if(local3 > 0) {
          alternativa3d::vertexBuffer = new VertexBufferResource(local1,8);
        }
        local11 = new Dictionary();
        local8 = alternativa3d::faceList;
        while(local8 != null) {
          if(local8.material != null) {
            local9 = local11[local8.material];
            if(local9 == null) {
              local9 = new Array();
              local11[local8.material] = local9;
            }
            local9.push(local8);
          }
          local8 = local8.alternativa3d::next;
        }
        local12 = new Vector.<uint>();
        local13 = 0;
        for(local14 in local11) {
          local9 = local11[local14];
          opaqueMaterials[opaqueLength] = local14;
          opaqueBegins[opaqueLength] = alternativa3d::numTriangles * 3;
          for each(local8 in local9) {
            local10 = local8.alternativa3d::wrapper;
            local5 = int(local10.alternativa3d::vertex.alternativa3d::index);
            local10 = local10.alternativa3d::next;
            local6 = int(local10.alternativa3d::vertex.alternativa3d::index);
            local10 = local10.alternativa3d::next;
            while(local10 != null) {
              local7 = int(local10.alternativa3d::vertex.alternativa3d::index);
              local12[local13] = local5;
              local13++;
              local12[local13] = local6;
              local13++;
              local12[local13] = local7;
              local13++;
              local6 = local7;
              ++alternativa3d::numTriangles;
              local10 = local10.alternativa3d::next;
            }
          }
          opaqueNums[opaqueLength] = alternativa3d::numTriangles - opaqueBegins[opaqueLength] / 3;
          ++opaqueLength;
        }
        if(local13 > 0) {
          alternativa3d::indexBuffer = new IndexBufferResource(local12);
        }
      }
    }

    override alternativa3d function addOpaque(param1:Camera3D) : void {
      var local2:int = 0;
      while(local2 < opaqueLength) {
        param1.alternativa3d::addSky(opaqueMaterials[local2],alternativa3d::vertexBuffer,alternativa3d::indexBuffer,opaqueBegins[local2],opaqueNums[local2],this);
        local2++;
      }
    }

    override alternativa3d function getVG(param1:Camera3D) : VG {
      this.alternativa3d::draw(param1);
      return null;
    }

    override alternativa3d function cullingInCamera(param1:Camera3D, param2:int) : int {
      return super.alternativa3d::cullingInCamera(param1,param2 = param2 & ~3);
    }

    private function calculateTransform(param1:Camera3D) : void {
      var local2:Number = alternativa3d::mi * boundMinX + alternativa3d::mj * boundMinY + alternativa3d::mk * boundMinZ + alternativa3d::ml;
      var local3:Number = local2;
      local2 = alternativa3d::mi * boundMaxX + alternativa3d::mj * boundMinY + alternativa3d::mk * boundMinZ + alternativa3d::ml;
      if(local2 > local3) {
        local3 = local2;
      }
      local2 = alternativa3d::mi * boundMaxX + alternativa3d::mj * boundMaxY + alternativa3d::mk * boundMinZ + alternativa3d::ml;
      if(local2 > local3) {
        local3 = local2;
      }
      local2 = alternativa3d::mi * boundMinX + alternativa3d::mj * boundMaxY + alternativa3d::mk * boundMinZ + alternativa3d::ml;
      if(local2 > local3) {
        local3 = local2;
      }
      local2 = alternativa3d::mi * boundMinX + alternativa3d::mj * boundMinY + alternativa3d::mk * boundMaxZ + alternativa3d::ml;
      if(local2 > local3) {
        local3 = local2;
      }
      local2 = alternativa3d::mi * boundMaxX + alternativa3d::mj * boundMinY + alternativa3d::mk * boundMaxZ + alternativa3d::ml;
      if(local2 > local3) {
        local3 = local2;
      }
      local2 = alternativa3d::mi * boundMaxX + alternativa3d::mj * boundMaxY + alternativa3d::mk * boundMaxZ + alternativa3d::ml;
      if(local2 > local3) {
        local3 = local2;
      }
      local2 = alternativa3d::mi * boundMinX + alternativa3d::mj * boundMaxY + alternativa3d::mk * boundMaxZ + alternativa3d::ml;
      if(local2 > local3) {
        local3 = local2;
      }
      var local4:Number = 1;
      if(local3 > param1.farClipping) {
        local4 = param1.farClipping / local3;
      }
      this.alternativa3d::reduceConst[0] = local4;
      this.alternativa3d::reduceConst[1] = local4;
      this.alternativa3d::reduceConst[2] = local4;
    }
  }
}
