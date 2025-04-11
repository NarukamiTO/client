package projects.tanks.client.battlefield.models.battle.battlefield.meteors {
  import projects.tanks.client.battlefield.types.Vector3d;

  public class MeteorDescriptor {
    private var _groundPosition:Vector3d;
    private var _lifeTimeMs:int;
    private var _timeToFlyMs:int;
    private var _upperPosition:Vector3d;

    public function MeteorDescriptor(param1:Vector3d = null, param2:int = 0, param3:int = 0, param4:Vector3d = null) {
      super();
      this._groundPosition = param1;
      this._lifeTimeMs = param2;
      this._timeToFlyMs = param3;
      this._upperPosition = param4;
    }

    public function get groundPosition() : Vector3d {
      return this._groundPosition;
    }

    public function set groundPosition(param1:Vector3d) : void {
      this._groundPosition = param1;
    }

    public function get lifeTimeMs() : int {
      return this._lifeTimeMs;
    }

    public function set lifeTimeMs(param1:int) : void {
      this._lifeTimeMs = param1;
    }

    public function get timeToFlyMs() : int {
      return this._timeToFlyMs;
    }

    public function set timeToFlyMs(param1:int) : void {
      this._timeToFlyMs = param1;
    }

    public function get upperPosition() : Vector3d {
      return this._upperPosition;
    }

    public function set upperPosition(param1:Vector3d) : void {
      this._upperPosition = param1;
    }

    public function toString() : String {
      var local1:String = "MeteorDescriptor [";
      local1 += "groundPosition = " + this.groundPosition + " ";
      local1 += "lifeTimeMs = " + this.lifeTimeMs + " ";
      local1 += "timeToFlyMs = " + this.timeToFlyMs + " ";
      local1 += "upperPosition = " + this.upperPosition + " ";
      return local1 + "]";
    }
  }
}
