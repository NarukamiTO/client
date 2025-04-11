package projects.tanks.client.battlefield.models.battle.battlefield.types {
  public class HitTraceData {
    private var _armorPreEffectDamage:Number;
    private var _colorResistDamage:Number;
    private var _hullResistDamage:Number;
    private var _killerTurretName:String;
    private var _origDamage:Number;
    private var _postHealth:Number;
    private var _targetHealth:Number;
    private var _targetHullName:String;
    private var _weaponEffectsDamage:Number;

    public function HitTraceData(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:String = null, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:String = null, param9:Number = 0) {
      super();
      this._armorPreEffectDamage = param1;
      this._colorResistDamage = param2;
      this._hullResistDamage = param3;
      this._killerTurretName = param4;
      this._origDamage = param5;
      this._postHealth = param6;
      this._targetHealth = param7;
      this._targetHullName = param8;
      this._weaponEffectsDamage = param9;
    }

    public function get armorPreEffectDamage() : Number {
      return this._armorPreEffectDamage;
    }

    public function set armorPreEffectDamage(param1:Number) : void {
      this._armorPreEffectDamage = param1;
    }

    public function get colorResistDamage() : Number {
      return this._colorResistDamage;
    }

    public function set colorResistDamage(param1:Number) : void {
      this._colorResistDamage = param1;
    }

    public function get hullResistDamage() : Number {
      return this._hullResistDamage;
    }

    public function set hullResistDamage(param1:Number) : void {
      this._hullResistDamage = param1;
    }

    public function get killerTurretName() : String {
      return this._killerTurretName;
    }

    public function set killerTurretName(param1:String) : void {
      this._killerTurretName = param1;
    }

    public function get origDamage() : Number {
      return this._origDamage;
    }

    public function set origDamage(param1:Number) : void {
      this._origDamage = param1;
    }

    public function get postHealth() : Number {
      return this._postHealth;
    }

    public function set postHealth(param1:Number) : void {
      this._postHealth = param1;
    }

    public function get targetHealth() : Number {
      return this._targetHealth;
    }

    public function set targetHealth(param1:Number) : void {
      this._targetHealth = param1;
    }

    public function get targetHullName() : String {
      return this._targetHullName;
    }

    public function set targetHullName(param1:String) : void {
      this._targetHullName = param1;
    }

    public function get weaponEffectsDamage() : Number {
      return this._weaponEffectsDamage;
    }

    public function set weaponEffectsDamage(param1:Number) : void {
      this._weaponEffectsDamage = param1;
    }

    public function toString() : String {
      var local1:String = "HitTraceData [";
      local1 += "armorPreEffectDamage = " + this.armorPreEffectDamage + " ";
      local1 += "colorResistDamage = " + this.colorResistDamage + " ";
      local1 += "hullResistDamage = " + this.hullResistDamage + " ";
      local1 += "killerTurretName = " + this.killerTurretName + " ";
      local1 += "origDamage = " + this.origDamage + " ";
      local1 += "postHealth = " + this.postHealth + " ";
      local1 += "targetHealth = " + this.targetHealth + " ";
      local1 += "targetHullName = " + this.targetHullName + " ";
      local1 += "weaponEffectsDamage = " + this.weaponEffectsDamage + " ";
      return local1 + "]";
    }
  }
}
