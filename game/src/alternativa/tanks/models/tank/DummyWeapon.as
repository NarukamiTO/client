package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class DummyWeapon implements Weapon {
    public function DummyWeapon() {
      super();
    }

    public function init(param1:WeaponPlatform) : void {
    }

    public function destroy() : void {
    }

    public function activate() : void {
    }

    public function deactivate() : void {
    }

    public function enable() : void {
    }

    public function disable(param1:Boolean) : void {
    }

    public function reset() : void {
    }

    public function getStatus() : Number {
      return 0;
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.MINE_RESISTANCE;
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
