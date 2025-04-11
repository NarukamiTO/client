package projects.tanks.client.battlefield.models.user.configuration {
  import alternativa.types.Long;

  public class TankConfigurationCC {
    private var _coloringId:Long;
    private var _droneId:Long;
    private var _hullId:Long;
    private var _weaponId:Long;

    public function TankConfigurationCC(param1:Long = null, param2:Long = null, param3:Long = null, param4:Long = null) {
      super();
      this._coloringId = param1;
      this._droneId = param2;
      this._hullId = param3;
      this._weaponId = param4;
    }

    public function get coloringId() : Long {
      return this._coloringId;
    }

    public function set coloringId(param1:Long) : void {
      this._coloringId = param1;
    }

    public function get droneId() : Long {
      return this._droneId;
    }

    public function set droneId(param1:Long) : void {
      this._droneId = param1;
    }

    public function get hullId() : Long {
      return this._hullId;
    }

    public function set hullId(param1:Long) : void {
      this._hullId = param1;
    }

    public function get weaponId() : Long {
      return this._weaponId;
    }

    public function set weaponId(param1:Long) : void {
      this._weaponId = param1;
    }

    public function toString() : String {
      var local1:String = "TankConfigurationCC [";
      local1 += "coloringId = " + this.coloringId + " ";
      local1 += "droneId = " + this.droneId + " ";
      local1 += "hullId = " + this.hullId + " ";
      local1 += "weaponId = " + this.weaponId + " ";
      return local1 + "]";
    }
  }
}
