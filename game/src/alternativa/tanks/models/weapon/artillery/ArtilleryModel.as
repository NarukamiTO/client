package alternativa.tanks.models.weapon.artillery {
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.ArtilleryTurretSkin;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.CustomTurretSkin;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkin;
  import alternativa.tanks.models.tank.DestroyTankPart;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.models.weapon.IWeaponModel;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryEffects;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtillerySfx;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtillerySfxData;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import alternativa.tanks.models.weapon.common.WeaponBuffListener;
  import alternativa.tanks.models.weapon.shared.shot.WeaponReloadTimeChangedListener;
  import alternativa.tanks.models.weapons.charging.WeaponChargingListener;
  import alternativa.tanks.utils.MathUtils;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.ArtilleryCC;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.ArtilleryModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.IArtilleryModelBase;
  import projects.tanks.clients.flash.resources.object3ds.IObject3DS;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  [ModelInfo]
  public class ArtilleryModel extends ArtilleryModelBase implements IArtilleryModelBase, IArtilleryModel, ArtillerySkin, ArtilleryEffectsProvider, IWeaponModel, WeaponChargingListener, ObjectLoadListener, WeaponBuffListener, UltimateStunListener, CustomTurretSkin, WeaponReloadTimeChangedListener, DestroyTankPart {
    private var localWeapon:ArtilleryWeapon = null;
    private var localUser:IGameObject;

    public function ArtilleryModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:ArtilleryCC = getInitParam();
      local1.shellRadius = BattleUtils.toClientScale(local1.shellRadius);
      local1.minShellSpeed = BattleUtils.toClientScale(local1.minShellSpeed);
      local1.maxShellSpeed = BattleUtils.toClientScale(local1.maxShellSpeed);
      local1.initialTurretAngle = MathUtils.toRadians(local1.initialTurretAngle);
    }

    public function getDefaultElevation() : Number {
      return getInitParam().initialTurretAngle;
    }

    public function getWeapon() : ArtilleryWeapon {
      return ArtilleryWeapon(getData(ArtilleryWeapon));
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      var local2:ArtilleryEffects = new ArtilleryEffects(this.getSfxData(),this.getSkin(),true);
      putData(ArtilleryEffects,local2);
      var local3:ArtilleryObject = new ArtilleryObject(object);
      var local4:ArtilleryWeapon = new ArtilleryWeapon(param1,local3,getInitParam(),this.getSfxData(),local2);
      putData(ArtilleryWeapon,local4);
      this.localWeapon = local4;
      this.localUser = param1;
      return local4;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var local2:ArtilleryEffects = new ArtilleryEffects(this.getSfxData(),this.getSkin(),false);
      putData(ArtilleryEffects,local2);
      var local3:ArtilleryObject = new ArtilleryObject(object);
      local3.markAsRemote();
      var local4:RemoteArtilleryWeapon = new RemoteArtilleryWeapon(param1,local3,getInitParam(),this.getSfxData(),local2);
      putData(RemoteArtilleryWeapon,local4);
      return local4;
    }

    private function getSfxData() : ArtillerySfxData {
      return ArtillerySfx(object.adapt(ArtillerySfx)).getSfxData();
    }

    public function handleChargingStart() : void {
      this.remoteWeapon().startCharging();
    }

    public function handleChargingFinish(param1:int) : void {
      this.remoteWeapon().shoot(param1);
    }

    public function createSkin(param1:Tanks3DSResource) : TurretSkin {
      return this.getSkin();
    }

    public function getSkin() : ArtilleryTurretSkin {
      var local2:IObject3DS = null;
      var local1:ArtilleryTurretSkin = ArtilleryTurretSkin(getData(ArtilleryTurretSkin));
      if(local1 == null) {
        local2 = IObject3DS(object.adapt(IObject3DS));
        local1 = new ArtilleryTurretSkin(local2.getResource3DS());
        putData(ArtilleryTurretSkin,local1);
      }
      return local1;
    }

    private function remoteWeapon() : RemoteArtilleryWeapon {
      return RemoteArtilleryWeapon(getData(RemoteArtilleryWeapon));
    }

    public function getArtilleryEffects() : ArtilleryEffects {
      return ArtilleryEffects(getData(ArtilleryEffects));
    }

    public function destroyTankPart() : void {
      ArtilleryEffects(getData(ArtilleryEffects)).close();
      clearData(ArtilleryEffects);
      clearData(ArtilleryTurretSkin);
      clearData(ArtilleryWeapon);
      clearData(RemoteArtilleryWeapon);
    }

    private function isLocalWeapon() : Boolean {
      var local1:Tank = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
      return ITankModel(local1.user.adapt(ITankModel)).isLocal();
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      if(this.isLocalWeapon()) {
        this.localWeapon.weaponReloadTimeChanged(param1,param2);
      }
    }

    public function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void {
      var local4:ArtilleryWeapon = param1 == this.localUser ? this.localWeapon : this.remoteWeapon();
      local4.setBuffedMode(param2);
      if(!param2) {
        local4.fullyRecharge();
      }
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      if(param2) {
        this.localWeapon.stun();
      }
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      if(param2) {
        this.localWeapon.calm(param3);
      }
    }
  }
}
