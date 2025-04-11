package alternativa.tanks.models.battle.gui.inventory.cooldown {
  import alternativa.tanks.models.battle.gui.inventory.InventoryIcons;
  import alternativa.tanks.models.battle.gui.inventory.splash.ISplashController;
  import flash.utils.getTimer;

  public class InventoryCooldownItem {
    public static const FILL_EFFECT_TIME_IN_SEC:Number = 0.1;
    public static const ADDING_EFFECT_TIME_IN_SEC:Number = 0.1;
    public static const TOLERANCE_EFFECT_TIME:Number = 300;

    private var _effectController:EffectController;
    private var _cooldownController:CooldownController;
    private var _inventoryIcon:InventoryIcons;
    private var _finishCallBack:Function;
    private var _startCooldownCallBack:Function;

    public function InventoryCooldownItem(param1:int, param2:CooldownIndicator, param3:CooldownIndicator, param4:ISplashController, param5:InventoryIcons, param6:Function, param7:Function, param8:Boolean = true) {
      super();
      this._inventoryIcon = param5;
      this._finishCallBack = param6;
      this._startCooldownCallBack = param7;
      this.init(param1,param2,param3,param4,param8);
    }

    private function init(param1:int, param2:CooldownIndicator, param3:CooldownIndicator, param4:ISplashController, param5:Boolean) : void {
      this._effectController = new EffectController(param1,this._inventoryIcon,param2,param4,this._finishCallBack,this.finishFillEffect,param5);
      this._cooldownController = new CooldownController(param1,param3,param4,this.finishCooldown,this.finishFillCoolDown);
    }

    private function finishCooldown() : void {
      if(!this._effectController.isActive) {
        this._finishCallBack.apply();
      }
    }

    private function finishFillEffect() : void {
      this._inventoryIcon.state = InventoryIcons.EFFECT_STATE;
    }

    private function finishFillCoolDown() : void {
      if(!this._effectController.isActive) {
        this._startCooldownCallBack.apply();
      }
    }

    public function activateCooldown(param1:int) : void {
      this._cooldownController.activate(getTimer(),param1,this._effectController.isActive,false);
    }

    public function changeEffectTime(param1:int, param2:Boolean) : void {
      this._effectController.changeTime(getTimer(),param1,param2);
    }

    public function activateInfinite() : void {
      this._cooldownController.activateInfinite();
      this._effectController.activateInfinite();
    }

    public function activateDependedCooldown(param1:int) : void {
      this._cooldownController.changeTime(getTimer(),param1,this._effectController.isActive,true);
    }

    public function destroy() : void {
      this._effectController.destroy();
      this._cooldownController.destroy();
    }

    public function canActivate() : Boolean {
      return !this._effectController.isActive && !this._cooldownController.isActive;
    }

    public function isActive() : Boolean {
      return !this.canActivate();
    }

    public function isEffectActive() : Boolean {
      return this._effectController.isActive;
    }

    public function isCooldownActive() : Boolean {
      return this._cooldownController.isActive;
    }

    public function update(param1:int) : void {
      if(!this._effectController.isActive && !this._cooldownController.isActive) {
        return;
      }
      this._effectController.update(param1);
      this._cooldownController.update(param1,this._effectController.getProgress());
    }

    public function stopEffect() : void {
      this._effectController.stopEffect();
    }

    public function setCooldownDuration(param1:int) : void {
      this._cooldownController.setCooldownDuration(param1);
    }

    public function setCooldownVisible(param1:Boolean) : void {
      this._cooldownController.setVisible(param1);
    }
  }
}
