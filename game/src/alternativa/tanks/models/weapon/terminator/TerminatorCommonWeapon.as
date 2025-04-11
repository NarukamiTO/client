package alternativa.tanks.models.weapon.terminator {
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponConst;
  import alternativa.tanks.models.weapon.railgun.IRailgunSFXModel;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherEffects;
  import alternativa.tanks.models.weapon.terminator.sfx.TerminatorEffects;
  import alternativa.tanks.models.weapon.terminator.sfx.TerminatorSFX;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.terminator.TerminatorCC;

  public class TerminatorCommonWeapon {
    private var gunParams:AllGlobalGunParams;
    private var _weaponObject:TerminatorObject;
    private var weaponPlatform:WeaponPlatform;
    private var _effects:TerminatorEffects;
    private var _initParam:TerminatorCC;
    private var _object:IGameObject;
    private var _user:IGameObject;

    public function TerminatorCommonWeapon(param1:IGameObject, param2:IGameObject, param3:TerminatorObject, param4:TerminatorCC) {
      super();
      this._weaponObject = param3;
      this._initParam = param4;
      this._object = param1;
      this._user = param2;
    }

    public function init(param1:WeaponPlatform, param2:AllGlobalGunParams) : void {
      this.weaponPlatform = param1;
      this.gunParams = param2;
      this._effects = new TerminatorEffects(this.weaponObject,TerminatorSFX(this.object.adapt(TerminatorSFX)).getSfxData(),param1.getTurret3D(),new RocketLauncherEffects(this.weaponObject.rocketLauncherObject.getSfxData(),param1.getTurret3D()),IRailgunSFXModel(this._object.adapt(IRailgunSFXModel)).getEffects());
    }

    public function resetEffects() : void {
      if(this._effects != null) {
        this._effects.reset();
      }
    }

    public function get weaponObject() : TerminatorObject {
      return this._weaponObject;
    }

    public function get effects() : TerminatorEffects {
      return this._effects;
    }

    public function get object() : IGameObject {
      return this._object;
    }

    public function get user() : IGameObject {
      return this._user;
    }

    public function get initParam() : TerminatorCC {
      return this._initParam;
    }

    public function createPrimaryChargeEffects(param1:int) : void {
      this._effects.railgunEffects.createChargeEffect(this.weaponPlatform.getLocalMuzzlePosition(param1),this.weaponPlatform.getTurret3D(),this._initParam.primaryCC.chargingTimeMsec);
      this.weaponPlatform.getAllGunParams(this.gunParams,param1);
      this._effects.railgunEffects.createSoundEffect(this.gunParams.muzzlePosition,0);
    }

    public function createSecondaryShotEffects(param1:int) : void {
      this.weaponPlatform.getBody().addWorldForceScaled(this.gunParams.muzzlePosition,this.gunParams.direction,-this._initParam.secondaryKickback * WeaponConst.BASE_IMPACT_FORCE.getNumber());
      this.weaponPlatform.addDust();
      this._effects.rocketLauncherEffects.playShotEffect(this.gunParams.muzzlePosition,param1);
    }

    public function destroy() : void {
      this._effects.close();
      this._weaponObject = null;
      this._initParam = null;
      this._effects = null;
      this._object = null;
      this._user = null;
    }
  }
}
