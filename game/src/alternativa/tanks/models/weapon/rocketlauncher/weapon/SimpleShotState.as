package alternativa.tanks.models.weapon.rocketlauncher.weapon {
  import alternativa.tanks.models.weapon.WeaponObject;
  import flash.utils.getTimer;

  public class SimpleShotState implements RocketLauncherWeaponState {
    private static const SWITCH_INTERVAL:int = 200;

    private var weapon:RocketLauncherWeapon;
    private var switchStateTime:int;
    private var canExplodeRockets:Boolean;
    private var weaponObj:WeaponObject;

    public function SimpleShotState(param1:RocketLauncherWeapon, param2:WeaponObject) {
      super();
      this.weapon = param1;
      this.canExplodeRockets = param1.canExplodeRockets();
      this.weaponObj = param2;
    }

    public function getStatus() : Number {
      if(this.weapon.isStunned()) {
        return this.weapon.getStunnedStatus();
      }
      return Math.min(1 - (this.weapon.getReloadingEndTime() - getTimer()) / this.weapon.getReloadingDuration(),1);
    }

    public function update(param1:int) : void {
      if(this.weapon.isBuffed()) {
        this.weapon.switchToBuffedState(param1);
        return;
      }
      if(this.weapon.canShoot(param1) && param1 >= this.switchStateTime) {
        this.weapon.switchToSalvoState(param1);
      }
    }

    public function start(param1:int) : void {
      this.switchStateTime = param1 + SWITCH_INTERVAL;
      if(!this.weapon.canShoot(param1) && this.canExplodeRockets) {
        this.weapon.explodeRockets();
      }
    }

    public function stop(param1:int) : void {
      if(this.weapon.canShoot(param1)) {
        this.weapon.simpleShoot(param1);
      }
    }

    public function getReloadTime() : int {
      return this.weaponObj.getReloadTimeMS();
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.weapon = null;
    }

    public function weaponStunned(param1:int) : void {
    }
  }
}
