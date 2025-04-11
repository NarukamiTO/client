package projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class TargetHit {
    private var _direction:Vector3d;
    private var _localHitPoint:Vector3d;
    private var _numberHits:int;
    private var _target:IGameObject;

    public function TargetHit(param1:Vector3d = null, param2:Vector3d = null, param3:int = 0, param4:IGameObject = null) {
      super();
      this._direction = param1;
      this._localHitPoint = param2;
      this._numberHits = param3;
      this._target = param4;
    }

    public function get direction() : Vector3d {
      return this._direction;
    }

    public function set direction(param1:Vector3d) : void {
      this._direction = param1;
    }

    public function get localHitPoint() : Vector3d {
      return this._localHitPoint;
    }

    public function set localHitPoint(param1:Vector3d) : void {
      this._localHitPoint = param1;
    }

    public function get numberHits() : int {
      return this._numberHits;
    }

    public function set numberHits(param1:int) : void {
      this._numberHits = param1;
    }

    public function get target() : IGameObject {
      return this._target;
    }

    public function set target(param1:IGameObject) : void {
      this._target = param1;
    }

    public function toString() : String {
      var local1:String = "TargetHit [";
      local1 += "direction = " + this.direction + " ";
      local1 += "localHitPoint = " + this.localHitPoint + " ";
      local1 += "numberHits = " + this.numberHits + " ";
      local1 += "target = " + this.target + " ";
      return local1 + "]";
    }
  }
}
