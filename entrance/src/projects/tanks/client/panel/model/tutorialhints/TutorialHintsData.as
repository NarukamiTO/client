package projects.tanks.client.panel.model.tutorialhints {
  import alternativa.types.Long;

  public class TutorialHintsData {
    private var _canBuyTargetItem:Boolean;
    private var _canUpgrageCurrentTurret:Boolean;
    private var _hasUntakenQuestPrize:Boolean;
    private var _mountedTurretId:Long;
    private var _neverBoughtTurretOrWeapon:Boolean;
    private var _neverUpgradeTurretOrWeapon:Boolean;
    private var _targetToBuyItemId:Long;

    public function TutorialHintsData(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:Long = null, param5:Boolean = false, param6:Boolean = false, param7:Long = null) {
      super();
      this._canBuyTargetItem = param1;
      this._canUpgrageCurrentTurret = param2;
      this._hasUntakenQuestPrize = param3;
      this._mountedTurretId = param4;
      this._neverBoughtTurretOrWeapon = param5;
      this._neverUpgradeTurretOrWeapon = param6;
      this._targetToBuyItemId = param7;
    }

    public function get canBuyTargetItem() : Boolean {
      return this._canBuyTargetItem;
    }

    public function set canBuyTargetItem(param1:Boolean) : void {
      this._canBuyTargetItem = param1;
    }

    public function get canUpgrageCurrentTurret() : Boolean {
      return this._canUpgrageCurrentTurret;
    }

    public function set canUpgrageCurrentTurret(param1:Boolean) : void {
      this._canUpgrageCurrentTurret = param1;
    }

    public function get hasUntakenQuestPrize() : Boolean {
      return this._hasUntakenQuestPrize;
    }

    public function set hasUntakenQuestPrize(param1:Boolean) : void {
      this._hasUntakenQuestPrize = param1;
    }

    public function get mountedTurretId() : Long {
      return this._mountedTurretId;
    }

    public function set mountedTurretId(param1:Long) : void {
      this._mountedTurretId = param1;
    }

    public function get neverBoughtTurretOrWeapon() : Boolean {
      return this._neverBoughtTurretOrWeapon;
    }

    public function set neverBoughtTurretOrWeapon(param1:Boolean) : void {
      this._neverBoughtTurretOrWeapon = param1;
    }

    public function get neverUpgradeTurretOrWeapon() : Boolean {
      return this._neverUpgradeTurretOrWeapon;
    }

    public function set neverUpgradeTurretOrWeapon(param1:Boolean) : void {
      this._neverUpgradeTurretOrWeapon = param1;
    }

    public function get targetToBuyItemId() : Long {
      return this._targetToBuyItemId;
    }

    public function set targetToBuyItemId(param1:Long) : void {
      this._targetToBuyItemId = param1;
    }

    public function toString() : String {
      var local1:String = "TutorialHintsData [";
      local1 += "canBuyTargetItem = " + this.canBuyTargetItem + " ";
      local1 += "canUpgrageCurrentTurret = " + this.canUpgrageCurrentTurret + " ";
      local1 += "hasUntakenQuestPrize = " + this.hasUntakenQuestPrize + " ";
      local1 += "mountedTurretId = " + this.mountedTurretId + " ";
      local1 += "neverBoughtTurretOrWeapon = " + this.neverBoughtTurretOrWeapon + " ";
      local1 += "neverUpgradeTurretOrWeapon = " + this.neverUpgradeTurretOrWeapon + " ";
      local1 += "targetToBuyItemId = " + this.targetToBuyItemId + " ";
      return local1 + "]";
    }
  }
}
