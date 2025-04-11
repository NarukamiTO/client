package alternativa.tanks.models.weapon.healing {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisState;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class RemoteHealingGun implements Weapon, HealingGun {
    private var effects:HealingGunEffects;
    private var currentTarget:Tank;

    public function RemoteHealingGun(param1:HealingGunEffects) {
      super();
      this.effects = param1;
    }

    public function init(param1:WeaponPlatform) : void {
      this.effects.init(param1.getTurret3D(),param1.getLocalMuzzlePosition());
    }

    public function destroy() : void {
      this.reset();
    }

    public function activate() : void {
    }

    public function deactivate() : void {
      this.reset();
    }

    public function enable() : void {
    }

    public function disable(param1:Boolean) : void {
      this.reset();
    }

    public function reset() : void {
      this.currentTarget = null;
      this.effects.stopEffects();
    }

    public function getStatus() : Number {
      return 0;
    }

    public function startAction(param1:IsisState, param2:Tank = null, param3:Vector3 = null) : void {
      this.effects.setRemoteEffectsType(param1,param2,param3);
      this.currentTarget = param2;
    }

    public function resetTarget() : void {
      this.effects.setRemoteEffectsType(IsisState.IDLE);
      this.currentTarget = null;
    }

    public function stop() : void {
      this.effects.stopEffects();
      this.currentTarget = null;
    }

    public function onTargetLost(param1:Tank) : void {
      if(param1 != null) {
        if(this.currentTarget == param1) {
          this.currentTarget = null;
          this.effects.setRemoteEffectsType(IsisState.IDLE);
        }
      }
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.ISIS_RESISTANCE;
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
