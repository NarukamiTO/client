package alternativa.tanks.models.weapon.terminator {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.tankskin.terminator.TerminatorTurretSkin;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.CustomTurretSkin;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkin;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.models.weapon.IWeaponModel;
  import alternativa.tanks.models.weapon.WeaponForces;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapon.railgun.RailgunData;
  import alternativa.tanks.models.weapons.shell.TargetShellWeaponListener;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.railgun.RailgunCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.terminator.ITerminatorModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.terminator.TerminatorModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  [ModelInfo]
  public class TerminatorModel extends TerminatorModelBase implements TargetShellWeaponListener, ITerminatorModelBase, UltimateStunListener, ObjectLoadListener, CustomTurretSkin, TerminatorSkin, IWeaponModel, Terminator {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var battleEventSupport:BattleEventSupport;
    private var tanksOnField:Dictionary = new Dictionary();

    public function TerminatorModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
      this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
      this.battleEventSupport.activateHandlers();
    }

    private static function getWeaponCommonData() : WeaponCommonData {
      return IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getCommonData();
    }

    private static function convertTargets(param1:Vector.<IGameObject>, param2:Dictionary) : Vector.<Body> {
      var local3:Vector.<Body> = null;
      var local4:int = 0;
      var local5:Tank = null;
      if(param1 != null) {
        local3 = new Vector.<Body>(param1.length);
        local4 = 0;
        while(local4 < param1.length) {
          local5 = param2[param1[local4]];
          if(local5 == null) {
            local3[local4] = null;
          } else {
            local3[local4] = local5.getBody();
          }
          local4++;
        }
        return local3;
      }
      return null;
    }

    private static function convertHitPoints(param1:Vector.<Vector3d>) : Vector.<Vector3> {
      var local2:Vector.<Vector3> = null;
      var local3:int = 0;
      var local4:Vector3d = null;
      if(param1 != null) {
        local2 = new Vector.<Vector3>(param1.length);
        local3 = 0;
        while(local3 < param1.length) {
          local4 = param1[local3];
          if(!BattleUtils.isFiniteVector3d(local4)) {
            return null;
          }
          local2[local3] = BattleUtils.getVector3(local4);
          local3++;
        }
        return local2;
      }
      return null;
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:RocketLauncherCC = getInitParam().secondaryCC;
      local1.minSpeed = BattleUtils.toClientScale(local1.minSpeed);
      local1.maxSpeed = BattleUtils.toClientScale(local1.maxSpeed);
      local1.shellRadius = BattleUtils.toClientScale(local1.shellRadius);
      local1.shotRange = BattleUtils.toClientScale(local1.shotRange);
      var local2:RailgunCC = getInitParam().primaryCC;
      putData(RailgunData,new RailgunData(local2.chargingTimeMsec,local2.weakeningCoeff));
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      var local2:TerminatorObject = new TerminatorObject(object);
      var local3:* = new TerminatorWeapon(RailgunData(getData(RailgunData)),this.createCommonWeapon(param1,local2));
      putData(TerminatorWeapon,local3);
      return local3;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var local2:TerminatorObject = new TerminatorObject(object);
      local2.markAsRemote();
      local2.rocketLauncherObject.markAsRemote();
      var local3:* = RailgunData(getData(RailgunData));
      var local4:* = getWeaponCommonData();
      var local5:* = new WeaponForces(local4.getImpactForce(),local4.getRecoilForce());
      var local6:* = new RemoteTerminatorWeapon(this.createCommonWeapon(param1,local2),local5,local3);
      putData(RemoteTerminatorWeapon,local6);
      return local6;
    }

    private function createCommonWeapon(param1:IGameObject, param2:TerminatorObject) : TerminatorCommonWeapon {
      return new TerminatorCommonWeapon(object,param1,param2,getInitParam());
    }

    private function remoteWeapon() : RemoteTerminatorWeapon {
      return RemoteTerminatorWeapon(getData(RemoteTerminatorWeapon));
    }

    private function localWeapon() : TerminatorWeapon {
      return TerminatorWeapon(getData(TerminatorWeapon));
    }

    public function createSkin(param1:Tanks3DSResource) : TurretSkin {
      var local2:TerminatorTurretSkin = new TerminatorTurretSkin(param1);
      putData(TerminatorTurretSkin,local2);
      return local2;
    }

    public function getSkin() : TerminatorTurretSkin {
      return TerminatorTurretSkin(getData(TerminatorTurretSkin));
    }

    public function onShotWithTarget(param1:int, param2:int, param3:Vector3, param4:Tank, param5:Vector3) : void {
      this.remoteWeapon().secondaryShoot(param1,param3,param4,param5);
    }

    public function onDummyShot(param1:int) : void {
      this.remoteWeapon().secondaryDummyShoot(param1);
    }

    public function secondaryOpen(param1:int) : void {
      server.secondaryOpen(param1);
    }

    public function secondaryHide(param1:int) : void {
      server.secondaryHide(param1);
    }

    public function primaryCharge(param1:int, param2:int) : void {
      server.primaryCharge(param1,param2);
    }

    public function primaryShot(param1:int, param2:Vector3, param3:Vector.<Body>, param4:Vector.<Vector3>, param5:int) : void {
      var local6:Vector.<IGameObject> = null;
      var local7:Vector.<Vector3d> = null;
      var local8:Vector.<int> = null;
      var local9:Vector.<Vector3d> = null;
      var local11:Vector.<Vector3d> = null;
      var local13:int = 0;
      var local14:Body = null;
      var local15:Vector3 = null;
      var local16:Vector3 = null;
      var local17:Tank = null;
      var local10:int = int(param3.length);
      if(local10 > 0) {
        local6 = new Vector.<IGameObject>(local10);
        local7 = new Vector.<Vector3d>(local10);
        local8 = new Vector.<int>(local10);
        local9 = new Vector.<Vector3d>(local10);
        local11 = new Vector.<Vector3d>(local10);
        local13 = 0;
        while(local13 < local10) {
          local14 = param3[local13];
          local15 = param4[local13];
          local16 = new Vector3();
          local16.copy(local15);
          BattleUtils.globalToLocal(local14,local15);
          local17 = local14.tank;
          local8[local13] = local17.incarnation;
          local6[local13] = local17.getUser();
          local7[local13] = BattleUtils.getVector3d(local15);
          local9[local13] = BattleUtils.getVector3d(local14.state.position);
          local11[local13] = BattleUtils.getVector3d(local16);
          local13++;
        }
      }
      var local12:Vector3d = BattleUtils.getVector3dOrNull(param2);
      this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.primaryShot(param1,local12,local6,local7,local8,local9,local11,param5);
    }

    public function secondaryRemoteHide(param1:IGameObject) : void {
      this.remoteWeapon().commonWeapon.effects.createHideEffect();
    }

    public function secondaryRemoteOpen(param1:IGameObject) : void {
      this.remoteWeapon().commonWeapon.effects.createOpenEffect();
    }

    public function primaryRemoteCharge(param1:IGameObject, param2:int) : void {
      this.remoteWeapon().commonWeapon.createPrimaryChargeEffects(param2);
    }

    public function primaryRemoteShot(param1:IGameObject, param2:Vector3d, param3:Vector.<IGameObject>, param4:Vector.<Vector3d>, param5:int) : void {
      var local7:Vector.<Body> = null;
      var local8:int = 0;
      var local9:Body = null;
      var local6:Vector.<Vector3> = convertHitPoints(param4);
      if(local6 != null) {
        local7 = convertTargets(param3,this.tanksOnField);
        if(param3 != null) {
          if(param3.length == local6.length) {
            local8 = 0;
            while(local8 < param3.length) {
              local9 = local7[local8];
              if(local9 != null && local9.tank != null) {
                BattleUtils.localToGlobal(local9,local6[local8]);
              }
              local8++;
            }
          } else {
            param3 = null;
            local6 = null;
          }
        }
      }
      this.remoteWeapon().createPrimaryShotEffect(BattleUtils.getVector3OrNull(param2),local7,local6,param5);
    }

    public function primaryRemoteDummy(param1:IGameObject, param2:int) : void {
      this.remoteWeapon().createPrimaryDummyShotEffect(param2);
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      this.tanksOnField[param1.tank.getUser()] = param1.tank;
    }

    private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void {
      delete this.tanksOnField[param1.tank.getUser()];
    }

    private function onTankUnloaded(param1:TankUnloadedEvent) : void {
      delete this.tanksOnField[param1.tank.getUser()];
    }

    public function primaryDummyShot(param1:int, param2:int) : void {
      server.primaryDummyShot(param1,param2);
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
  }
}
