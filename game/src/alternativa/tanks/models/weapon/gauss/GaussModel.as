package alternativa.tanks.models.weapon.gauss {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.CustomTurretSkin;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkin;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.models.weapon.IWeaponModel;
  import alternativa.tanks.models.weapon.WeaponConst;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import alternativa.tanks.models.weapon.common.WeaponBuffListener;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapon.shared.shot.WeaponReloadTimeChangedListener;
  import alternativa.tanks.models.weapons.targeting.TargetingSystem;
  import alternativa.tanks.models.weapons.targeting.direction.sector.SectorDirectionCalculator;
  import alternativa.tanks.models.weapons.targeting.priority.TargetingPriorityCalculator;
  import alternativa.tanks.models.weapons.targeting.priority.targeting.CommonTargetPriorityCalculator;
  import alternativa.tanks.models.weapons.targeting.processor.PrecisionTargetingParams;
  import alternativa.tanks.models.weapons.targeting.processor.SingleTargetPrecisionDirectionProcessor;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.gauss.GaussCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.gauss.GaussModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.gauss.IGaussModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  [ModelInfo]
  public class GaussModel extends GaussModelBase implements IGaussModelBase, IWeaponModel, GaussSkin, ObjectLoadListener, CustomTurretSkin, WeaponBuffListener, WeaponReloadTimeChangedListener, UltimateStunListener, GaussWeaponCallback {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private static const MAX_DISTANCE:Number = 1000000;
    private static const PRECISION_PARAMS:PrecisionTargetingParams = new PrecisionTargetingParams(5,15);

    private var globalHitPoint:Vector3 = new Vector3();
    private var localUser:IGameObject;

    public function GaussModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:GaussCC = getInitParam();
      local1.primaryShellRadius = BattleUtils.toClientScale(local1.primaryShellRadius);
      local1.primaryShellSpeed = BattleUtils.toClientScale(local1.primaryShellSpeed);
      local1.shotRange = BattleUtils.toClientScale(local1.shotRange);
      local1.aimedShotKickback *= WeaponConst.BASE_IMPACT_FORCE.getNumber();
      local1.aimedShotImpact *= WeaponConst.BASE_IMPACT_FORCE.getNumber();
    }

    public function dummyShot() : void {
      this.remoteWeapon().dummyShot();
    }

    public function primaryShot(param1:int, param2:Vector3d) : void {
      this.remoteWeapon().primaryShot(param1,BattleUtils.getVector3(param2));
    }

    public function secondaryHitTargetCommand(param1:IGameObject, param2:Vector3d) : void {
      this.remoteWeapon().secondaryHitTargetCommand(param1,BattleUtils.getVector3(param2));
    }

    private function remoteWeapon() : RemoteGaussWeapon {
      return RemoteGaussWeapon(getData(RemoteGaussWeapon));
    }

    private function localWeapon() : LocalGaussWeapon {
      return LocalGaussWeapon(getData(LocalGaussWeapon));
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      this.localUser = param1;
      var local2:WeaponObject = new WeaponObject(object);
      var local3:LocalGaussWeapon = new LocalGaussWeapon(local2,getInitParam(),this.createTargetingSystem(local2,param1),this.getWeaponForces());
      putData(LocalGaussWeapon,local3);
      return local3;
    }

    private function createTargetingSystem(param1:WeaponObject, param2:IGameObject) : TargetingSystem {
      var local3:TargetingPriorityCalculator = new TargetingPriorityCalculator(new CommonTargetPriorityCalculator(param1));
      var local4:SectorDirectionCalculator = new SectorDirectionCalculator(param2,param1,MAX_DISTANCE,local3);
      var local5:SingleTargetPrecisionDirectionProcessor = new SingleTargetPrecisionDirectionProcessor(param2,MAX_DISTANCE,PRECISION_PARAMS);
      var local6:TargetingSystem = new TargetingSystem(local4,local5,local3);
      local6.getProcessor().setShotFromMuzzle();
      return local6;
    }

    private function getWeaponForces() : WeaponForces {
      var local1:WeaponCommonData = this.getWeaponCommon().getCommonData();
      return new WeaponForces(local1.getImpactForce(),local1.getRecoilForce());
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var local2:WeaponObject = new WeaponObject(object);
      local2.markAsRemote();
      var local3:RemoteGaussWeapon = new RemoteGaussWeapon(local2,getInitParam(),this.getWeaponForces());
      putData(RemoteGaussWeapon,local3);
      return local3;
    }

    public function startAiming() : void {
      this.remoteWeapon().startAiming();
    }

    public function stopAiming() : void {
      this.remoteWeapon().stopAiming();
    }

    private function getWeaponCommon() : IWeaponCommonModel {
      return IWeaponCommonModel(object.adapt(IWeaponCommonModel));
    }

    public function doPrimaryShot(param1:int, param2:Vector3) : void {
      battleEventDispatcher.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.primaryShotCommand(this.getTime(),param1,param2.toVector3d());
    }

    public function doSecondaryShot(param1:IGameObject, param2:Vector3, param3:Vector3) : void {
      battleEventDispatcher.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      var local4:ITankModel = ITankModel(param1.adapt(ITankModel));
      var local5:Tank = local4.getTank();
      this.globalHitPoint.copy(param3);
      BattleUtils.localToGlobal(local5.getBody(),this.globalHitPoint);
      server.secondaryHitTargetCommand(this.getTime(),param1,param2.toVector3d(),param3.toVector3d(),this.globalHitPoint.toVector3d());
    }

    public function doDummyShot() : void {
      server.dummyShotCommand(this.getTime());
    }

    public function doStartAiming() : void {
      server.startAiming(this.getTime());
    }

    public function doStopAiming() : void {
      server.stopAiming(this.getTime());
    }

    public function doPrimaryHitStatic(param1:int, param2:Vector3) : void {
      server.primaryHitStaticCommand(this.getTime(),param1,param2.toVector3d());
    }

    public function doPrimaryHitTarget(param1:int, param2:IGameObject, param3:Vector3, param4:Vector3) : void {
      server.primaryHitTargetCommand(this.getTime(),param1,param2,param3.toVector3d(),param4.toVector3d());
    }

    private function getTime() : int {
      return battleService.getPhysicsTime();
    }

    public function createSkin(param1:Tanks3DSResource) : TurretSkin {
      var local2:GaussTurretSkin = new GaussTurretSkin(param1);
      putData(GaussTurretSkin,local2);
      return local2;
    }

    public function getSkin() : GaussTurretSkin {
      return GaussTurretSkin(getData(GaussTurretSkin));
    }

    private function isLocal(param1:IGameObject) : Boolean {
      return this.localUser == param1;
    }

    public function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void {
      var local4:CommonGaussWeapon = null;
      if(this.isLocal(param1)) {
        local4 = this.localWeapon();
        LocalGaussWeapon(local4).setBuffedMode(param2);
        if(!param2) {
          Weapon(local4).fullyRecharge();
        }
      } else {
        local4 = this.remoteWeapon();
      }
      local4.updateRecoilForce(param3);
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      if(param2) {
        this.localWeapon().stun();
      }
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      if(param2) {
        this.localWeapon().calm(param3);
      }
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      var local3:LocalGaussWeapon = this.localWeapon();
      if(local3 != null) {
        local3.weaponReloadTimeChanged(param1,param2);
      }
    }
  }
}
