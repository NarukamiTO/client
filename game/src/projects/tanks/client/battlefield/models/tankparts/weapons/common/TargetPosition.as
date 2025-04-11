package projects.tanks.client.battlefield.models.tankparts.weapons.common {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class TargetPosition {
    private var _orientation:Vector3d;
    private var _position:Vector3d;
    private var _target:IGameObject;
    private var _turretAngle:Number;

    public function TargetPosition(param1:Vector3d = null, param2:Vector3d = null, param3:IGameObject = null, param4:Number = 0) {
      super();
      this._orientation = param1;
      this._position = param2;
      this._target = param3;
      this._turretAngle = param4;
    }

    public function get orientation() : Vector3d {
      return this._orientation;
    }

    public function set orientation(param1:Vector3d) : void {
      this._orientation = param1;
    }

    public function get position() : Vector3d {
      return this._position;
    }

    public function set position(param1:Vector3d) : void {
      this._position = param1;
    }

    public function get target() : IGameObject {
      return this._target;
    }

    public function set target(param1:IGameObject) : void {
      this._target = param1;
    }

    public function get turretAngle() : Number {
      return this._turretAngle;
    }

    public function set turretAngle(param1:Number) : void {
      this._turretAngle = param1;
    }

    public function toString() : String {
      var local1:String = "TargetPosition [";
      local1 += "orientation = " + this.orientation + " ";
      local1 += "position = " + this.position + " ";
      local1 += "target = " + this.target + " ";
      local1 += "turretAngle = " + this.turretAngle + " ";
      return local1 + "]";
    }
  }
}
