package projects.tanks.client.battlefield.models.battle.pointbased.flag {
  public class ClientFlagFlyingData {
    private var _currentTime:int;
    private var _falling:Boolean;
    private var _points:Vector.<FlagFlyPoint>;

    public function ClientFlagFlyingData(param1:int = 0, param2:Boolean = false, param3:Vector.<FlagFlyPoint> = null) {
      super();
      this._currentTime = param1;
      this._falling = param2;
      this._points = param3;
    }

    public function get currentTime() : int {
      return this._currentTime;
    }

    public function set currentTime(param1:int) : void {
      this._currentTime = param1;
    }

    public function get falling() : Boolean {
      return this._falling;
    }

    public function set falling(param1:Boolean) : void {
      this._falling = param1;
    }

    public function get points() : Vector.<FlagFlyPoint> {
      return this._points;
    }

    public function set points(param1:Vector.<FlagFlyPoint>) : void {
      this._points = param1;
    }

    public function toString() : String {
      var local1:String = "ClientFlagFlyingData [";
      local1 += "currentTime = " + this.currentTime + " ";
      local1 += "falling = " + this.falling + " ";
      local1 += "points = " + this.points + " ";
      return local1 + "]";
    }
  }
}
