package utils.graphics {
  import flash.display.Shape;

  public class SectorMask extends Shape {
    private static const MIN_PROGRESS:Number = 0;
    private static const MAX_PROGRESS:Number = 1;

    private var _pen:Pen;
    private var _radius:int;
    private var _size:int;
    private var _startProgress:Number;
    private var _endProgress:Number;
    private var _isReverse:Boolean;

    public function SectorMask(param1:Number, param2:Boolean = false) {
      super();
      this._size = param1;
      this._isReverse = param2;
      this.init();
    }

    private static function clamp(param1:Number) : Number {
      return Math.max(MIN_PROGRESS,Math.min(MAX_PROGRESS,param1));
    }

    private function init() : void {
      this._radius = Math.ceil(Math.sqrt(this._size * this._size + this._size * this._size) / 2);
      this._pen = new Pen(this.graphics);
    }

    public function setProgress(param1:Number, param2:Number) : void {
      if(this._startProgress == param1 && this._endProgress == param2) {
        return;
      }
      this._startProgress = param1;
      this._endProgress = param2;
      var local3:Number = 360 * clamp(param1);
      var local4:Number = 360 * clamp(param2);
      var local5:Number = local4 - local3;
      var local6:Number = this._isReverse ? -90 : local3 - 90;
      this._pen.clear();
      this._pen.beginFill(16711680);
      this._pen.drawArc(this._size / 2,this._size / 2,this._radius,local5,local6,true);
      this._pen.endFill();
    }
  }
}
