package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;

  use namespace alternativa3d;

  public class Vertex {
    alternativa3d static var collector:Vertex;

    public var x:Number = 0;
    public var y:Number = 0;
    public var z:Number = 0;
    public var u:Number = 0;
    public var v:Number = 0;
    public var normalX:Number;
    public var normalY:Number;
    public var normalZ:Number;

    alternativa3d var cameraX:Number;
    alternativa3d var cameraY:Number;
    alternativa3d var cameraZ:Number;
    alternativa3d var offset:Number = 1;
    alternativa3d var transformId:int = 0;
    alternativa3d var drawId:int = 0;
    alternativa3d var index:int;
    alternativa3d var next:Vertex;
    alternativa3d var value:Vertex;

    public var id:Object;

    public function Vertex() {
      super();
    }

    alternativa3d static function createList(param1:int) : Vertex {
      var local3:Vertex = null;
      var local2:Vertex = alternativa3d::collector;
      if(local2 != null) {
        local3 = local2;
        while(param1 > 1) {
          local3.alternativa3d::transformId = 0;
          local3.alternativa3d::drawId = 0;
          if(local3.alternativa3d::next == null) {
            while(param1 > 1) {
              local3.alternativa3d::next = new Vertex();
              local3 = local3.alternativa3d::next;
              param1--;
            }
            break;
          }
          local3 = local3.alternativa3d::next;
          param1--;
        }
        alternativa3d::collector = local3.alternativa3d::next;
        local3.alternativa3d::transformId = 0;
        local3.alternativa3d::drawId = 0;
        local3.alternativa3d::next = null;
      } else {
        local2 = new Vertex();
        local3 = local2;
        while(param1 > 1) {
          local3.alternativa3d::next = new Vertex();
          local3 = local3.alternativa3d::next;
          param1--;
        }
      }
      return local2;
    }

    alternativa3d function create() : Vertex {
      var local1:Vertex = null;
      if(alternativa3d::collector != null) {
        local1 = alternativa3d::collector;
        alternativa3d::collector = local1.alternativa3d::next;
        local1.alternativa3d::next = null;
        local1.alternativa3d::transformId = 0;
        local1.alternativa3d::drawId = 0;
        return local1;
      }
      return new Vertex();
    }

    public function toString() : String {
      return "[Vertex " + this.id + " " + this.x.toFixed(2) + ", " + this.y.toFixed(2) + ", " + this.z.toFixed(2) + ", " + this.u.toFixed(3) + ", " + this.v.toFixed(3) + "]";
    }
  }
}
