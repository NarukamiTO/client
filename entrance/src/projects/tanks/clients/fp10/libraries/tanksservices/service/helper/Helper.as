package projects.tanks.clients.fp10.libraries.tanksservices.service.helper {
  import flash.display.Sprite;
  import flash.geom.Point;

  public class Helper extends Sprite {
    public var id:int;
    public var groupKey:String;
    public var timer:HelperTimer;
    public var showDuration:int = 5000;
    public var showNum:int = 0;

    protected var _showLimit:int = -1;
    protected var _size:Point;
    protected var _targetPoint:Point;

    public function Helper() {
      super();
      this._targetPoint = new Point();
    }

    public function draw(param1:Point) : void {
    }

    public function align(param1:int, param2:int) : void {
    }

    public function get size() : Point {
      return this._size;
    }

    public function get showLimit() : int {
      return this._showLimit;
    }

    public function get targetPoint() : Point {
      return this._targetPoint;
    }

    public function set targetPoint(param1:Point) : void {
      this._targetPoint.x = param1.x;
      this._targetPoint.y = param1.y;
    }
  }
}
