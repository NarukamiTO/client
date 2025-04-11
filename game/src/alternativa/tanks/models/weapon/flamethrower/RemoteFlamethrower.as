package alternativa.tanks.models.weapon.flamethrower {
  import alternativa.tanks.battle.objects.tank.ConfigurableWeapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class RemoteFlamethrower implements ConfigurableWeapon {
    private var effects:StreamWeaponEffects;
    private var weaponPlatform:WeaponPlatform;

    public function RemoteFlamethrower(param1:StreamWeaponEffects) {
      super();
      this.effects = param1;
    }

    public function init(param1:WeaponPlatform) : void {
      this.weaponPlatform = param1;
    }

    public function destroy() : void {
      this.effects.stopEffects();
    }

    public function activate() : void {
    }

    public function deactivate() : void {
      this.effects.stopEffects();
    }

    public function enable() : void {
    }

    public function disable(param1:Boolean) : void {
      this.effects.stopEffects();
    }

    public function reset() : void {
    }

    public function getStatus() : Number {
      return 0;
    }

    public function startFire() : void {
      this.effects.startEffects(this.weaponPlatform.getBody(),this.weaponPlatform.getLocalMuzzlePosition(),this.weaponPlatform.getTurret3D());
    }

    public function stopFire() : void {
      this.effects.stopEffects();
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.FIREBIRD_RESISTANCE;
    }

    public function updateRange(param1:Number) : void {
      this.effects.updateRange(param1);
    }

    public function setBuffedMode(param1:Boolean) : void {
      this.effects.setBuffedMode(param1);
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
