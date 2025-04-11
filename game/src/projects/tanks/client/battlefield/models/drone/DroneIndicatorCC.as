package projects.tanks.client.battlefield.models.drone {
  public class DroneIndicatorCC {
    private var _batteryAmount:int;
    private var _canOverheal:Boolean;
    private var _droneReady:Boolean;
    private var _timeToReloadMs:int;

    public function DroneIndicatorCC(param1:int = 0, param2:Boolean = false, param3:Boolean = false, param4:int = 0) {
      super();
      this._batteryAmount = param1;
      this._canOverheal = param2;
      this._droneReady = param3;
      this._timeToReloadMs = param4;
    }

    public function get batteryAmount() : int {
      return this._batteryAmount;
    }

    public function set batteryAmount(param1:int) : void {
      this._batteryAmount = param1;
    }

    public function get canOverheal() : Boolean {
      return this._canOverheal;
    }

    public function set canOverheal(param1:Boolean) : void {
      this._canOverheal = param1;
    }

    public function get droneReady() : Boolean {
      return this._droneReady;
    }

    public function set droneReady(param1:Boolean) : void {
      this._droneReady = param1;
    }

    public function get timeToReloadMs() : int {
      return this._timeToReloadMs;
    }

    public function set timeToReloadMs(param1:int) : void {
      this._timeToReloadMs = param1;
    }

    public function toString() : String {
      var local1:String = "DroneIndicatorCC [";
      local1 += "batteryAmount = " + this.batteryAmount + " ";
      local1 += "canOverheal = " + this.canOverheal + " ";
      local1 += "droneReady = " + this.droneReady + " ";
      local1 += "timeToReloadMs = " + this.timeToReloadMs + " ";
      return local1 + "]";
    }
  }
}
