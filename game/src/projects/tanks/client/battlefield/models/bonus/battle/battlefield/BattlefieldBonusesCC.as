package projects.tanks.client.battlefield.models.bonus.battle.battlefield {
  import projects.tanks.client.battlefield.models.bonus.battle.BonusSpawnData;

  public class BattlefieldBonusesCC {
    private var _bonusFallSpeed:Number;
    private var _bonuses:Vector.<BonusSpawnData>;

    public function BattlefieldBonusesCC(param1:Number = 0, param2:Vector.<BonusSpawnData> = null) {
      super();
      this._bonusFallSpeed = param1;
      this._bonuses = param2;
    }

    public function get bonusFallSpeed() : Number {
      return this._bonusFallSpeed;
    }

    public function set bonusFallSpeed(param1:Number) : void {
      this._bonusFallSpeed = param1;
    }

    public function get bonuses() : Vector.<BonusSpawnData> {
      return this._bonuses;
    }

    public function set bonuses(param1:Vector.<BonusSpawnData>) : void {
      this._bonuses = param1;
    }

    public function toString() : String {
      var local1:String = "BattlefieldBonusesCC [";
      local1 += "bonusFallSpeed = " + this.bonusFallSpeed + " ";
      local1 += "bonuses = " + this.bonuses + " ";
      return local1 + "]";
    }
  }
}
