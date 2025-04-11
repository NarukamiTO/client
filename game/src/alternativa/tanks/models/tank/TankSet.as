package alternativa.tanks.models.tank {
  import platform.client.fp10.core.type.IGameObject;

  public class TankSet {
    private var _hull:IGameObject;
    private var _turret:IGameObject;
    private var _drone:IGameObject;
    private var _maxHealth:int;

    public function TankSet(param1:IGameObject, param2:IGameObject, param3:IGameObject, param4:int) {
      super();
      this._hull = param1;
      this._turret = param2;
      this._maxHealth = param4;
      this._drone = param3;
    }

    public function get hull() : IGameObject {
      return this._hull;
    }

    public function get turret() : IGameObject {
      return this._turret;
    }

    public function get drone() : IGameObject {
      return this._drone;
    }

    public function get maxHealth() : int {
      return this._maxHealth;
    }

    public function eq(param1:TankSet) : Boolean {
      return this._hull == param1._hull && this._turret == param1._turret && this._drone == param1._drone;
    }

    public function eqParts(param1:IGameObject, param2:IGameObject, param3:IGameObject) : Boolean {
      return this._hull == param1 && this._turret == param2 && this._drone == param3;
    }

    public function toString() : String {
      return "TankSet{_hull=" + String(this._hull) + ",_turret=" + String(this._turret) + ",_drone=" + String(this._drone) + ",_maxHealth=" + String(this._maxHealth) + "}";
    }
  }
}
