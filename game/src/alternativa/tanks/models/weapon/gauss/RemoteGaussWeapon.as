package alternativa.tanks.models.weapon.gauss {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.gauss.sfx.GaussShell;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.gauss.GaussCC;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class RemoteGaussWeapon extends CommonGaussWeapon implements Weapon {
    private var secondaryHitPoint:Vector3 = new Vector3();

    public function RemoteGaussWeapon(param1:WeaponObject, param2:GaussCC, param3:WeaponForces) {
      super(param1,param2);
      this.weaponObject = param1;
      this.primaryWeaponForces = param3;
    }

    override public function init(param1:WeaponPlatform) : void {
      super.init(param1);
      this.weaponPlatform = param1;
    }

    public function destroy() : void {
    }

    public function activate() : void {
    }

    public function deactivate() : void {
    }

    public function stun() : void {
    }

    public function calm(param1:int) : void {
    }

    public function reset() : void {
      effects.reset();
    }

    public function getStatus() : Number {
      return 0;
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.GAUSS_RESISTANCE;
    }

    public function fullyRecharge() : void {
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
    }

    public function dummyShot() : void {
      weaponPlatform.getAllGunParams(gunParams);
      weaponPlatform.getBody().addWorldForceScaled(gunParams.muzzlePosition,gunParams.direction,-primaryWeaponForces.getRecoilForce());
      effects.playSoundEffect(sfxData.primaryShotSound,gunParams.muzzlePosition);
    }

    public function primaryShot(param1:int, param2:Vector3) : void {
      weaponPlatform.getAllGunParams(gunParams);
      effects.playCommonShotEffect(gunParams.muzzlePosition,param2,primaryWeaponForces);
      var local3:GaussShell = getShell();
      local3.addToGame(gunParams,param2,weaponPlatform.getBody(),true,param1);
      effects.playSoundEffect(sfxData.primaryShotSound,gunParams.muzzlePosition);
    }

    public function startAiming() : void {
      effects.playOpenEffect();
    }

    public function stopAiming() : void {
      effects.playHideEffect();
    }

    public function secondaryHitTargetCommand(param1:IGameObject, param2:Vector3) : void {
      var local3:ITankModel = ITankModel(param1.adapt(ITankModel));
      weaponPlatform.getAllGunParams(gunParams);
      var local4:Tank = local3.getTank();
      this.secondaryHitPoint.copy(param2);
      BattleUtils.localToGlobal(local4.getBody(),this.secondaryHitPoint);
      var local5:Vector3 = new Vector3().copy(this.secondaryHitPoint).subtract(gunParams.muzzlePosition).normalize();
      effects.playCommonShotEffect(gunParams.muzzlePosition,local5,secondaryWeaponForces);
      effects.playPowerShotEffect(local4.getBody(),this.secondaryHitPoint);
      local4.applyWeaponHit(this.secondaryHitPoint,gunParams.direction,secondaryWeaponForces.getImpactForce());
      applySecondarySplashImpact(this.secondaryHitPoint,local4.getBody());
    }
  }
}
