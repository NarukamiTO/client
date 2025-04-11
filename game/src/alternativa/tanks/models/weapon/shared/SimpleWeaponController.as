package alternativa.tanks.models.weapon.shared {
  import alternativa.tanks.battle.objects.tank.LocalWeapon;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.GameActionListener;

  public class SimpleWeaponController implements GameActionListener {
    [Inject]
    public static var battleInputService:BattleInputService;

    private var weapon:LocalWeapon;
    private var triggerPulled:Boolean;
    private var wasTriggerPulled:Boolean;

    public function SimpleWeaponController() {
      super();
    }

    public function init() : void {
      battleInputService.addGameActionListener(this);
    }

    public function destroy() : void {
      battleInputService.removeGameActionListener(this);
    }

    public function setWeapon(param1:LocalWeapon) : void {
      this.weapon = param1;
    }

    public function wasActive() : Boolean {
      return this.triggerPulled || this.wasTriggerPulled;
    }

    public function isTriggerPulled() : Boolean {
      return this.triggerPulled;
    }

    public function discardStoredAction() : void {
      this.wasTriggerPulled = false;
    }

    public function onGameAction(param1:GameActionEnum, param2:Boolean) : void {
      if(param1 == GameActionEnum.SHOT) {
        if(param2) {
          this.pullTrigger();
        } else {
          this.releaseTrigger();
        }
      }
    }

    private function pullTrigger() : void {
      if(!this.triggerPulled) {
        this.triggerPulled = true;
        this.wasTriggerPulled = true;
        if(this.weapon != null) {
          this.weapon.pullTrigger();
        }
      }
    }

    private function releaseTrigger() : void {
      if(this.triggerPulled) {
        this.triggerPulled = false;
        if(this.weapon != null) {
          this.weapon.releaseTrigger();
        }
      }
    }
  }
}
