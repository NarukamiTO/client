package alternativa.tanks.models.battle.gui.inventory.cooldown {
  import alternativa.tanks.display.EffectBlinkerUtil;
  import alternativa.tanks.models.battle.gui.inventory.InventoryIcons;
  import alternativa.tanks.models.battle.gui.inventory.splash.ISplashController;
  import alternativa.tanks.models.battle.gui.inventory.splash.SplashColor;
  import alternativa.tanks.sfx.Blinker;
  import flash.utils.getTimer;
  import utils.tweener.TweenLite;

  public class EffectController {
    private var _view:CooldownIndicator;
    private var _startTime:int;
    private var _durationTime:int;
    private var _isFillEffect:Boolean;
    private var _fillTween:TweenLite;
    private var _addingTween:TweenLite;
    private var _isActive:Boolean;
    private var _isAddingEffect:Boolean;
    private var _finishCallback:Function;
    private var _finishFillEffectCallBack:Function;
    private var _effectProgressData:CooldownProgressData;
    private var _splashController:ISplashController;
    private var _slotNumber:int;
    private var _inventoryIcon:InventoryIcons;
    private var blinker:Blinker;
    private var blinkingPeriod:int;
    private var lastUpdateTime:int = -1;
    private var blinkerInited:Boolean = false;
    private var effectStopped:Boolean = false;
    private var blinkEnabled:Boolean = true;

    public function EffectController(param1:int, param2:InventoryIcons, param3:CooldownIndicator, param4:ISplashController, param5:Function, param6:Function, param7:Boolean = true) {
      super();
      this.blinkEnabled = param7;
      this._slotNumber = param1;
      this._inventoryIcon = param2;
      this._view = param3;
      this._splashController = param4;
      this._finishCallback = param5;
      this._finishFillEffectCallBack = param6;
      this._effectProgressData = new CooldownProgressData();
      this.blinkingPeriod = EffectBlinkerUtil.getBlinkingPeriod(this._slotNumber);
      this.blinker = EffectBlinkerUtil.createBlinker(this._slotNumber);
    }

    public function update(param1:int) : void {
      var local2:int = 0;
      if(!this._isActive) {
        return;
      }
      if(this.lastUpdateTime < 0) {
        this.lastUpdateTime = param1;
      } else {
        local2 = param1 - this.lastUpdateTime;
        this.lastUpdateTime = param1;
        if(this.blinkEnabled && param1 - this._startTime > this._durationTime - this.blinkingPeriod) {
          if(!this.effectStopped) {
            this.blinkIcon(param1,local2);
          }
        } else if(this.blinkerInited) {
          this.resetVarsForBlink();
        }
      }
      if(this._isFillEffect || this._isAddingEffect) {
        return;
      }
      this._effectProgressData.progress = this.calculateProgress(param1,this._startTime,this._durationTime);
      if(this._effectProgressData.progress > 1) {
        this._effectProgressData.progress = 1;
        this.finish();
      }
      this._view.setProgress(this._effectProgressData.progress,1);
    }

    public function get isActive() : Boolean {
      return this._isActive;
    }

    public function destroy() : void {
      if(this._isActive) {
        this._isActive = false;
        this._isFillEffect = false;
        this._isAddingEffect = false;
        this._startTime = -1;
        this._durationTime = 0;
        this._effectProgressData.reset();
        this._view.setProgress(0,0);
        TweenLite.killTweensOf(this._effectProgressData);
        this.resetVarsForBlink();
      }
    }

    public function getProgress() : Number {
      if(this._isAddingEffect) {
        return this._effectProgressData.addingProgress;
      }
      if(this._isFillEffect) {
        return this._effectProgressData.fillProgress;
      }
      return this._effectProgressData.progress;
    }

    public function changeTime(param1:int, param2:int, param3:Boolean) : void {
      var local4:int = 0;
      var local5:int = 0;
      var local6:int = 0;
      this.effectStopped = false;
      if(this._isActive) {
        local4 = this.getRemainingTime();
        local5 = param2 - local4;
        if(local5 > InventoryCooldownItem.TOLERANCE_EFFECT_TIME) {
          if(this._isFillEffect || this._isAddingEffect) {
            if(this._isFillEffect) {
              local6 = param2 - (local4 + InventoryCooldownItem.FILL_EFFECT_TIME_IN_SEC * 1000);
            }
            if(this._isAddingEffect) {
              local6 = param2 - (local4 + InventoryCooldownItem.ADDING_EFFECT_TIME_IN_SEC * 1000);
            }
            if(local6 > InventoryCooldownItem.TOLERANCE_EFFECT_TIME) {
              this._durationTime += local6;
            }
          } else {
            this.activateAddingEffect(param1,param2,param3);
          }
        }
      } else {
        this.activate(param1,param2,param3);
      }
    }

    public function stopEffect() : void {
      this.resetVarsForBlink();
      this.effectStopped = true;
      this._startTime = -1;
      this._durationTime = 0;
    }

    private function blinkIcon(param1:int, param2:int) : void {
      var local3:Number = NaN;
      if(this.blinkerInited) {
        local3 = this.blinker.updateValue(param1,param2);
        if(local3 != this._inventoryIcon.alpha) {
          this._inventoryIcon.alpha = local3;
        }
      } else {
        this.blinker.setMinValue(EffectBlinkerUtil.MIN_VALUE);
        this.blinker.init(param1);
        this.blinkerInited = true;
      }
    }

    private function finish() : void {
      this._isActive = false;
      this._startTime = -1;
      this._durationTime = 0;
      this.resetVarsForBlink();
      this._effectProgressData.reset();
      this._view.setProgress(this._effectProgressData.progress,1);
      this._finishCallback.apply();
    }

    private function calculateProgress(param1:int, param2:int, param3:int) : Number {
      var local4:int = param1 - param2;
      return local4 / param3;
    }

    private function activate(param1:int, param2:int, param3:Boolean) : void {
      if(this._isActive || param2 <= 0) {
        return;
      }
      this._isActive = true;
      this.activateFillEffect(param1,param2,param3);
    }

    public function activateInfinite() : void {
      this._isActive = true;
      this._effectProgressData.progress = 0;
      this._effectProgressData.fillProgress = 1;
      this._durationTime = int.MAX_VALUE;
    }

    private function activateFillEffect(param1:int, param2:int, param3:Boolean) : void {
      if(this._isFillEffect) {
        this.changeTime(param1,param2,param3);
        return;
      }
      var local4:int = param2 - InventoryCooldownItem.FILL_EFFECT_TIME_IN_SEC * 1000;
      if(local4 > InventoryCooldownItem.TOLERANCE_EFFECT_TIME) {
        this._isFillEffect = true;
        this._splashController.startFlash(SplashColor.getColor(this._slotNumber));
        this._startTime = param1 + InventoryCooldownItem.FILL_EFFECT_TIME_IN_SEC * 1000;
        this._durationTime = local4;
        this._effectProgressData.progress = 0;
        this._effectProgressData.fillProgress = 1;
        this._fillTween = TweenLite.to(this._effectProgressData,InventoryCooldownItem.FILL_EFFECT_TIME_IN_SEC,{
          "fillProgress":0,
          "onComplete":this.onCompleteFill
        });
      }
    }

    private function onCompleteFill() : void {
      this._effectProgressData.fillProgress = 0;
      this._view.setProgress(0,1);
      this._finishFillEffectCallBack.apply();
      this._isFillEffect = false;
    }

    private function getRemainingTime() : int {
      if(this._durationTime == 0 || this._startTime == -1) {
        return 0;
      }
      return this._durationTime - (getTimer() - this._startTime);
    }

    private function activateAddingEffect(param1:int, param2:int, param3:Boolean) : void {
      if(this._isAddingEffect) {
        this.changeTime(param1,param2,param3);
        return;
      }
      var local4:int = param2 - InventoryCooldownItem.ADDING_EFFECT_TIME_IN_SEC * 1000;
      if(local4 > 0) {
        this._isAddingEffect = true;
        this._splashController.startFlash(SplashColor.getColor(this._slotNumber));
        this._startTime = param1 + InventoryCooldownItem.ADDING_EFFECT_TIME_IN_SEC * 1000;
        this._durationTime = local4;
        this._effectProgressData.addingProgress = this._effectProgressData.progress;
        this._addingTween = TweenLite.to(this._effectProgressData,InventoryCooldownItem.ADDING_EFFECT_TIME_IN_SEC,{
          "addingProgress":0,
          "onComplete":this.onCompleteAdding
        });
      }
    }

    private function onCompleteAdding() : void {
      this._effectProgressData.addingProgress = 0;
      this._view.setProgress(0,1);
      this._isAddingEffect = false;
    }

    private function resetVarsForBlink() : void {
      this._inventoryIcon.alpha = 1;
      this.blinkerInited = false;
    }
  }
}
