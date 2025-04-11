package alternativa.engine3d.objects {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Canvas;
  import alternativa.engine3d.core.Clipping;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.core.VG;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import flash.geom.Matrix;
  import flash.geom.Point;

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

    override alternativa3d function draw(param1:Camera3D, param2:Canvas) : void {
      alternativa3d::culling &= ~3;
      super.alternativa3d::draw(param1,param2);
    }

    override alternativa3d function getVG(param1:Camera3D) : VG {
      alternativa3d::culling &= ~3;
      return super.alternativa3d::getVG(param1);
    }
  }
}
