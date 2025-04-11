package alternativa.tanks.models.weapon.terminator.state {
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.RocketLauncherWeaponState;
  import alternativa.tanks.models.weapon.terminator.ITerminatorWeapon;
  import flash.utils.getTimer;

  public class PrimaryShotState implements RocketLauncherWeaponState {
    private static const SWITCH_INTERVAL:int = 200;

    private var weapon:ITerminatorWeapon;
    private var switchStateTime:int;
    private var reloadTime:int;
    private var chargeTime:int;
    private var chargingTrigger:Boolean = false;

    public function PrimaryShotState(param1:ITerminatorWeapon, param2:int, param3:int) {
      super();
      this.weapon = param1;
      this.reloadTime = param2;
      this.chargeTime = param3;
    }

    public function getStatus() : Number {
      if(this.chargingTrigger) {
        return (this.weapon.getPrimaryNextChargeTime() - getTimer()) / this.chargeTime;
      }
      return 1 - (this.weapon.getPrimaryNextShotTime() - this.chargeTime - getTimer()) / this.reloadTime;
    }

    public function update(param1:int) : void {
      if(Boolean(this.weapon.isShooting()) && param1 >= this.weapon.getPrimaryNextShotTime() && param1 >= this.switchStateTime) {
        this.weapon.switchToSecondaryState(param1);
      }
      if(this.chargingTrigger && param1 >= this.weapon.getPrimaryNextChargeTime()) {
        this.weapon.shootPrimary(param1);
        this.chargingTrigger = false;
      }
    }

    public function start(param1:int) : void {
      this.switchStateTime = param1 + SWITCH_INTERVAL;
    }

    public function stop(param1:int) : void {
      if(!this.chargingTrigger && param1 >= this.weapon.getPrimaryNextShotTime() - this.chargeTime && param1 < this.switchStateTime) {
        this.chargingTrigger = true;
        this.weapon.startCharging(param1);
      }
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.weapon = null;
    }

    public function getReloadTime() : int {
      return 0;
    }

    public function stopCharging() : void {
      this.chargingTrigger = false;
    }

    public function resetNextShotTime() : void {
      this.weapon.resetPrimaryNextShotTime();
    }

    public function weaponStunned(param1:int) : void {
    }

    public function isCharging() : Boolean {
      return this.chargingTrigger;
    }
  }
}
