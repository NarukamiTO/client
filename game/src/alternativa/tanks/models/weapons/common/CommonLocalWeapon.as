package alternativa.tanks.models.weapons.common {
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.LocalWeapon;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
  import flash.errors.IllegalOperationError;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class CommonLocalWeapon extends BattleRunnerProvider implements Weapon, LocalWeapon, LogicUnit {
    [Inject]
    public static var battleService:BattleService;

    protected static const gunParams:AllGlobalGunParams = new AllGlobalGunParams();

    private var enabled:Boolean;
    private var triggerPulled:Boolean;
    private var shooting:Boolean;
    private var controller:SimpleWeaponController;
    private var weaponPlatform:WeaponPlatform;

    public function CommonLocalWeapon(param1:Boolean) {
      super();
      if(param1) {
        this.controller = new SimpleWeaponController();
        this.controller.setWeapon(this);
      }
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
      if(this.controller != null) {
        this.controller.init();
        getBattleRunner().addLogicUnit(this);
      }
    }

    public function destroy() : void {
      if(this.controller != null) {
        this.controller.destroy();
        this.weaponPlatform = null;
        getBattleRunner().removeLogicUnit(this);
      }
    }

    public function activate() : void {
    }

    public function deactivate() : void {
      this.disable(true);
    }

    public function enable() : void {
      if(!this.enabled) {
        this.enabled = true;
        this.triggerPulled = this.controller.isTriggerPulled();
        if(this.triggerPulled) {
          if(this.canStart()) {
            this.start(getBattleRunner().getPhysicsTime());
          }
        }
      }
    }

    public function disable(param1:Boolean) : void {
      if(this.enabled) {
        if(this.triggerPulled) {
          this.triggerPulled = false;
          this.stop(getBattleRunner().getPhysicsTime(),param1);
        }
        this.enabled = false;
      }
    }

    public function reset() : void {
      this.shooting = false;
      this.triggerPulled = false;
    }

    public function pullTrigger() : void {
      if(this.enabled) {
        this.triggerPulled = true;
        if(this.canStart()) {
          this.start(getBattleRunner().getPhysicsTime());
        }
      }
    }

    public function releaseTrigger() : void {
      if(this.enabled) {
        this.triggerPulled = false;
        this.stop(getBattleRunner().getPhysicsTime(),true);
      }
    }

    protected function start(param1:int) : void {
      this.shooting = true;
    }

    protected function stop(param1:int, param2:Boolean) : void {
      this.shooting = false;
    }

    public function getStatus() : Number {
      return 0;
    }

    public function runLogic(param1:int, param2:int) : void {
      if(this.isEnabled() && this.triggerPulled && !this.isShooting() && this.canStart()) {
        this.start(param1);
      }
    }

    public function isShooting() : Boolean {
      return this.isEnabled() && this.shooting;
    }

    public function isEnabled() : Boolean {
      return this.enabled;
    }

    public function getWeaponPlatform() : WeaponPlatform {
      return this.weaponPlatform;
    }

    protected function canStart() : Boolean {
      return true;
    }

    public function getResistanceProperty() : ItemProperty {
      throw new IllegalOperationError();
    }

    protected function getPhysicsTime() : int {
      return battleService.getPhysicsTime();
    }

    public function updateRecoilForce(param1:Number) : void {
    }

    public function fullyRecharge() : void {
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
    }

    public function stun() : void {
    }

    public function calm(param1:int) : void {
    }
  }
}
