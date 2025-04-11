package projects.tanks.client.battlefield.models.user.device {
  import alternativa.types.Long;

  public class TankDeviceCC {
    private var _deviceId:Long;

    public function TankDeviceCC(param1:Long = null) {
      super();
      this._deviceId = param1;
    }

    public function get deviceId() : Long {
      return this._deviceId;
    }

    public function set deviceId(param1:Long) : void {
      this._deviceId = param1;
    }

    public function toString() : String {
      var local1:String = "TankDeviceCC [";
      local1 += "deviceId = " + this.deviceId + " ";
      return local1 + "]";
    }
  }
}
