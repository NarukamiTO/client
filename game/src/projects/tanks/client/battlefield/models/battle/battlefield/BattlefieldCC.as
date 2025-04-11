package projects.tanks.client.battlefield.models.battle.battlefield {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.battle.battlefield.types.BattlefieldSounds;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;
  import projects.tanks.client.battleservice.Range;

  public class BattlefieldCC {
    private var _active:Boolean;
    private var _battleId:Long;
    private var _battlefieldSounds:BattlefieldSounds;
    private var _colorTransformMultiplier:Number;
    private var _idleKickPeriodMsec:int;
    private var _map:IGameObject;
    private var _mineExplosionLighting:LightingSFXEntity;
    private var _proBattle:Boolean;
    private var _range:Range;
    private var _reArmorEnabled:Boolean;
    private var _respawnDuration:int;
    private var _shadowMapCorrectionFactor:Number;
    private var _showAddressLink:Boolean;
    private var _spectator:Boolean;
    private var _withoutBonuses:Boolean;
    private var _withoutDrones:Boolean;
    private var _withoutSupplies:Boolean;

    public function BattlefieldCC(param1:Boolean = false, param2:Long = null, param3:BattlefieldSounds = null, param4:Number = 0, param5:int = 0, param6:IGameObject = null, param7:LightingSFXEntity = null, param8:Boolean = false, param9:Range = null, param10:Boolean = false, param11:int = 0, param12:Number = 0, param13:Boolean = false, param14:Boolean = false, param15:Boolean = false, param16:Boolean = false, param17:Boolean = false) {
      super();
      this._active = param1;
      this._battleId = param2;
      this._battlefieldSounds = param3;
      this._colorTransformMultiplier = param4;
      this._idleKickPeriodMsec = param5;
      this._map = param6;
      this._mineExplosionLighting = param7;
      this._proBattle = param8;
      this._range = param9;
      this._reArmorEnabled = param10;
      this._respawnDuration = param11;
      this._shadowMapCorrectionFactor = param12;
      this._showAddressLink = param13;
      this._spectator = param14;
      this._withoutBonuses = param15;
      this._withoutDrones = param16;
      this._withoutSupplies = param17;
    }

    public function get active() : Boolean {
      return this._active;
    }

    public function set active(param1:Boolean) : void {
      this._active = param1;
    }

    public function get battleId() : Long {
      return this._battleId;
    }

    public function set battleId(param1:Long) : void {
      this._battleId = param1;
    }

    public function get battlefieldSounds() : BattlefieldSounds {
      return this._battlefieldSounds;
    }

    public function set battlefieldSounds(param1:BattlefieldSounds) : void {
      this._battlefieldSounds = param1;
    }

    public function get colorTransformMultiplier() : Number {
      return this._colorTransformMultiplier;
    }

    public function set colorTransformMultiplier(param1:Number) : void {
      this._colorTransformMultiplier = param1;
    }

    public function get idleKickPeriodMsec() : int {
      return this._idleKickPeriodMsec;
    }

    public function set idleKickPeriodMsec(param1:int) : void {
      this._idleKickPeriodMsec = param1;
    }

    public function get map() : IGameObject {
      return this._map;
    }

    public function set map(param1:IGameObject) : void {
      this._map = param1;
    }

    public function get mineExplosionLighting() : LightingSFXEntity {
      return this._mineExplosionLighting;
    }

    public function set mineExplosionLighting(param1:LightingSFXEntity) : void {
      this._mineExplosionLighting = param1;
    }

    public function get proBattle() : Boolean {
      return this._proBattle;
    }

    public function set proBattle(param1:Boolean) : void {
      this._proBattle = param1;
    }

    public function get range() : Range {
      return this._range;
    }

    public function set range(param1:Range) : void {
      this._range = param1;
    }

    public function get reArmorEnabled() : Boolean {
      return this._reArmorEnabled;
    }

    public function set reArmorEnabled(param1:Boolean) : void {
      this._reArmorEnabled = param1;
    }

    public function get respawnDuration() : int {
      return this._respawnDuration;
    }

    public function set respawnDuration(param1:int) : void {
      this._respawnDuration = param1;
    }

    public function get shadowMapCorrectionFactor() : Number {
      return this._shadowMapCorrectionFactor;
    }

    public function set shadowMapCorrectionFactor(param1:Number) : void {
      this._shadowMapCorrectionFactor = param1;
    }

    public function get showAddressLink() : Boolean {
      return this._showAddressLink;
    }

    public function set showAddressLink(param1:Boolean) : void {
      this._showAddressLink = param1;
    }

    public function get spectator() : Boolean {
      return this._spectator;
    }

    public function set spectator(param1:Boolean) : void {
      this._spectator = param1;
    }

    public function get withoutBonuses() : Boolean {
      return this._withoutBonuses;
    }

    public function set withoutBonuses(param1:Boolean) : void {
      this._withoutBonuses = param1;
    }

    public function get withoutDrones() : Boolean {
      return this._withoutDrones;
    }

    public function set withoutDrones(param1:Boolean) : void {
      this._withoutDrones = param1;
    }

    public function get withoutSupplies() : Boolean {
      return this._withoutSupplies;
    }

    public function set withoutSupplies(param1:Boolean) : void {
      this._withoutSupplies = param1;
    }

    public function toString() : String {
      var local1:String = "BattlefieldCC [";
      local1 += "active = " + this.active + " ";
      local1 += "battleId = " + this.battleId + " ";
      local1 += "battlefieldSounds = " + this.battlefieldSounds + " ";
      local1 += "colorTransformMultiplier = " + this.colorTransformMultiplier + " ";
      local1 += "idleKickPeriodMsec = " + this.idleKickPeriodMsec + " ";
      local1 += "map = " + this.map + " ";
      local1 += "mineExplosionLighting = " + this.mineExplosionLighting + " ";
      local1 += "proBattle = " + this.proBattle + " ";
      local1 += "range = " + this.range + " ";
      local1 += "reArmorEnabled = " + this.reArmorEnabled + " ";
      local1 += "respawnDuration = " + this.respawnDuration + " ";
      local1 += "shadowMapCorrectionFactor = " + this.shadowMapCorrectionFactor + " ";
      local1 += "showAddressLink = " + this.showAddressLink + " ";
      local1 += "spectator = " + this.spectator + " ";
      local1 += "withoutBonuses = " + this.withoutBonuses + " ";
      local1 += "withoutDrones = " + this.withoutDrones + " ";
      local1 += "withoutSupplies = " + this.withoutSupplies + " ";
      return local1 + "]";
    }
  }
}
