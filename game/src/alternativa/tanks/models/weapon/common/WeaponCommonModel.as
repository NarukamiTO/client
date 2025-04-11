package alternativa.tanks.models.weapon.common {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.TankControlLockBits;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.IWeaponController;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponConst;
  import flash.events.Event;
  import flash.utils.getTimer;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.tankparts.weapon.common.IWeaponCommonModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.common.WeaponCommonCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.common.WeaponCommonModelBase;

  [ModelInfo]
  public class WeaponCommonModel extends WeaponCommonModelBase implements IWeaponCommonModelBase, IWeaponCommonModel, WeaponSound, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var display:IDisplay;

    private static var allGunParams:AllGlobalGunParams = new AllGlobalGunParams();

    public function WeaponCommonModel() {
      super();
    }

    public function objectLoaded() : void {
      putData(Boolean,getInitParam().buffed);
      putData(int,0);
    }

    public function objectUnloaded() : void {
      display.stage.removeEventListener(Event.ENTER_FRAME,getFunctionWrapper(this.onEnterFrame));
    }

    public function setBuffed(param1:Boolean, param2:Number) : void {
      putData(Boolean,param1);
      var local3:Number = param2 * WeaponConst.BASE_IMPACT_FORCE.getNumber();
      WeaponCommonData(getData(WeaponCommonData)).setRecoilForce(local3);
      WeaponBuffListener(object.event(WeaponBuffListener)).weaponBuffStateChanged(this.getTank().user,param1,local3);
      if(!param1 && getInitParam().buffShotCooldownMs > 0) {
        this.getWeaponController().lockWeapon(TankControlLockBits.DEBUFF,false);
        putData(int,getTimer() + getInitParam().buffShotCooldownMs);
      }
    }

    private function getWeaponController() : IWeaponController {
      var local1:ITankModel = ITankModel(this.getTank().user.adapt(ITankModel));
      local1.getWeaponController();
      return IWeaponController(local1.getWeaponController());
    }

    public function getCommonData() : WeaponCommonData {
      var local2:WeaponCommonCC = null;
      var local1:WeaponCommonData = WeaponCommonData(getData(WeaponCommonData));
      if(local1 == null) {
        local2 = getInitParam();
        local1 = new WeaponCommonData(local2.turretRotationSpeed,local2.turretRotationAcceleration,local2.impactForce * WeaponConst.BASE_IMPACT_FORCE.getNumber(),local2.kickback * WeaponConst.BASE_IMPACT_FORCE.getNumber());
        putData(WeaponCommonData,local1);
      }
      return local1;
    }

    public function getTurretRotationSound() : SoundResource {
      return getInitParam().turretRotationSound;
    }

    public function storeTank(param1:Tank) : void {
      putData(Tank,param1);
      if(getInitParam().buffShotCooldownMs > 0 && Boolean(ITankModel(param1.user.adapt(ITankModel)).isLocal())) {
        display.stage.addEventListener(Event.ENTER_FRAME,getFunctionWrapper(this.onEnterFrame));
      }
    }

    public function getTank() : Tank {
      return Tank(getData(Tank));
    }

    public function getGunParams(param1:int = 0) : AllGlobalGunParams {
      this.getTank().getAllGunParams(allGunParams,param1);
      return allGunParams;
    }

    private function onEnterFrame(param1:Event) : void {
      var local2:int = int(getData(int));
      if(local2 != 0 && local2 < getTimer()) {
        this.getWeaponController().unlockWeapon(TankControlLockBits.DEBUFF);
        putData(int,0);
      }
    }
  }
}
