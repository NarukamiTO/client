package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.objects.tank.Weapon;

  public class RemoteWeaponController extends BattleRunnerProvider implements IWeaponController {
    private var weapon:Weapon;

    public function RemoteWeaponController(param1:Weapon) {
      super();
      this.weapon = param1;
    }

    public function lockWeapon(param1:int, param2:Boolean) : void {
      this.weapon.disable(false);
    }

    public function unlockWeapon(param1:int) : void {
      this.weapon.enable();
    }

    public function activateWeapon() : void {
      this.weapon.activate();
    }

    public function deactivateWeapon() : void {
      this.weapon.deactivate();
    }
  }
}
