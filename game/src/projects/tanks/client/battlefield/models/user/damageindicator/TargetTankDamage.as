package projects.tanks.client.battlefield.models.user.damageindicator {
  import platform.client.fp10.core.type.IGameObject;

  public class TargetTankDamage {
    private var _damageAmount:Number;
    private var _damageIndicatorType:DamageIndicatorType;
    private var _target:IGameObject;

    public function TargetTankDamage(param1:Number = 0, param2:DamageIndicatorType = null, param3:IGameObject = null) {
      super();
      this._damageAmount = param1;
      this._damageIndicatorType = param2;
      this._target = param3;
    }

    public function get damageAmount() : Number {
      return this._damageAmount;
    }

    public function set damageAmount(param1:Number) : void {
      this._damageAmount = param1;
    }

    public function get damageIndicatorType() : DamageIndicatorType {
      return this._damageIndicatorType;
    }

    public function set damageIndicatorType(param1:DamageIndicatorType) : void {
      this._damageIndicatorType = param1;
    }

    public function get target() : IGameObject {
      return this._target;
    }

    public function set target(param1:IGameObject) : void {
      this._target = param1;
    }

    public function toString() : String {
      var local1:String = "TargetTankDamage [";
      local1 += "damageAmount = " + this.damageAmount + " ";
      local1 += "damageIndicatorType = " + this.damageIndicatorType + " ";
      local1 += "target = " + this.target + " ";
      return local1 + "]";
    }
  }
}
