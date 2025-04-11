package alternativa.tanks.models.weapon.flamethrower {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.objects.tank.ConfigurableWeapon;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.models.weapon.ConicAreaData;
  import alternativa.tanks.models.weapon.IWeaponModel;
  import alternativa.tanks.models.weapon.common.WeaponBuffListener;
  import alternativa.tanks.models.weapon.shared.ConicAreaTargetingSystem;
  import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
  import alternativa.tanks.models.weapon.shared.streamweapon.IStreamWeaponCallback;
  import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeapon;
  import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;
  import alternativa.tanks.models.weapon.streamweapon.IStreamWeaponModel;
  import alternativa.tanks.models.weapon.streamweapon.StreamConeParams;
  import alternativa.tanks.models.weapon.streamweapon.StreamWeaponData;
  import alternativa.tanks.models.weapon.streamweapon.StreamWeaponReconfiguredListener;
  import alternativa.tanks.physics.TanksCollisionDetector;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower.FlameThrowerCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower.FlameThrowerModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower.IFlameThrowerModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  [ModelInfo]
  public class FlamethrowerModel extends FlameThrowerModelBase implements IFlameThrowerModelBase, IWeaponModel, IStreamWeaponCallback, ObjectLoadListener, StreamWeaponReconfiguredListener, WeaponBuffListener, UltimateStunListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private const targets:Vector.<IGameObject> = new Vector.<IGameObject>();
    private const targetIncarnations:Vector.<int> = new Vector.<int>();

    private var localUser:IGameObject;
    private var weapons:Dictionary = new Dictionary();
    private var battleEventSupport:BattleEventSupport;

    public function FlamethrowerModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
      this.battleEventSupport.activateHandlers();
    }

    private static function getStreamWeaponData() : StreamWeaponData {
      var local1:IStreamWeaponModel = IStreamWeaponModel(object.adapt(IStreamWeaponModel));
      return local1.getStreamWeaponData();
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:FlameThrowerCC = getInitParam();
      var local2:ConicAreaData = new ConicAreaData(local1.coneAngle,BattleUtils.toClientScale(local1.range));
      putData(ConicAreaData,local2);
    }

    [Obfuscation(rename="false")]
    public function startFire(param1:IGameObject) : void {
      var local2:RemoteFlamethrower = this.weapons[param1];
      if(local2 != null) {
        local2.startFire();
      }
    }

    [Obfuscation(rename="false")]
    public function stopFire(param1:IGameObject) : void {
      var local2:RemoteFlamethrower = this.weapons[param1];
      if(local2 != null) {
        local2.stopFire();
      }
    }

    private function onTankUnloaded(param1:TankUnloadedEvent) : void {
      var local2:IGameObject = param1.tank.getUser();
      if(this.localUser == local2) {
        this.localUser = null;
      }
      delete this.weapons[local2];
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      this.localUser = param1;
      var local2:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
      var local3:ConicAreaData = ConicAreaData(getData(ConicAreaData));
      var local4:ConicAreaTargetingSystem = new ConicAreaTargetingSystem(local3.getRange(),local3.getConeAngle(),StreamConeParams.NUM_RADIAL_RAYS,StreamConeParams.NUM_STEPS,local2,battleService.getConicAreaTargetValidator());
      var local5:SimpleWeaponController = new SimpleWeaponController();
      var local6:StreamWeaponData = getStreamWeaponData();
      var local7:Number = local6.getEnergyCapacity();
      var local8:Number = local6.getEnergyDischargeSpeed();
      var local9:Number = local6.getEnergyRechargeSpeed();
      var local10:Weapon = new StreamWeapon(local7,local8,local9,local6.getTickIntervalMsec(),local4,local5,IStreamWeaponCallback(object.adapt(IStreamWeaponCallback)),this.getEffects(),ItemProperty.FIREBIRD_RESISTANCE);
      this.weapons[param1] = local10;
      return local10;
    }

    private function getEffects() : StreamWeaponEffects {
      var local1:ConicAreaData = ConicAreaData(getData(ConicAreaData));
      var local2:IFlamethrowerSFXModel = IFlamethrowerSFXModel(object.adapt(IFlamethrowerSFXModel));
      return local2.getFlamethrowerEffects(local1.getRange(),local1.getConeAngle());
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var local2:Weapon = new RemoteFlamethrower(this.getEffects());
      this.weapons[param1] = local2;
      return local2;
    }

    public function start(param1:int) : void {
      server.startFireCommand(param1);
    }

    public function stop(param1:int) : void {
      server.stopFireCommand(param1);
    }

    public function onTick(param1:Weapon, param2:Vector.<Body>, param3:Vector.<Number>, param4:Vector.<Vector3>, param5:int) : void {
      var local6:Vector.<Vector3d> = null;
      var local7:Vector.<Vector3d> = null;
      var local8:int = 0;
      var local9:Body = null;
      if(param1 == this.weapons[this.localUser]) {
        this.collectTargetsData(param2);
        local6 = new Vector.<Vector3d>(param2.length);
        local7 = new Vector.<Vector3d>(param2.length);
        local8 = 0;
        while(local8 < param2.length) {
          local9 = param2[local8];
          local6[local8] = BattleUtils.getVector3d(local9.state.position);
          local7[local8] = BattleUtils.getVector3d(param4[local8]);
          local8++;
        }
        this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
        server.hitCommand(param5,this.targets,this.targetIncarnations,local6,local7);
        this.targets.length = 0;
        this.targetIncarnations.length = 0;
      }
    }

    private function collectTargetsData(param1:Vector.<Body>) : void {
      var local3:Body = null;
      var local4:Tank = null;
      var local2:int = 0;
      while(local2 < param1.length) {
        local3 = Body(param1[local2]);
        local4 = local3.tank;
        this.targets[local2] = local4.getUser();
        this.targetIncarnations[local2] = local4.incarnation;
        local2++;
      }
      this.targets.length = param1.length;
      this.targetIncarnations.length = param1.length;
    }

    public function streamWeaponReconfigured(param1:IGameObject, param2:Number) : void {
      var local3:StreamWeapon = null;
      if(this.isLocal(param1)) {
        local3 = this.weapons[param1];
        local3.updateDischargeRate(param2);
      }
    }

    public function streamWeaponDistanceChanged(param1:IGameObject, param2:Number) : void {
      var local3:StreamWeapon = null;
      var local4:ConfigurableWeapon = null;
      if(this.isLocal(param1)) {
        local3 = this.weapons[param1];
        local3.updateRange(param2);
      } else {
        local4 = this.weapons[param1];
        local4.updateRange(param2);
      }
    }

    public function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void {
      var local4:StreamWeapon = null;
      var local5:ConfigurableWeapon = null;
      if(this.isLocal(param1)) {
        local4 = this.weapons[param1];
        local4.setBuffedMode(param2);
        local4.fullyRecharge();
      } else {
        local5 = this.weapons[param1];
        local5.setBuffedMode(param2);
      }
    }

    private function isLocal(param1:IGameObject) : Boolean {
      return this.localUser == param1;
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      if(param2) {
        StreamWeapon(this.weapons[param1.user]).stun();
      }
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      if(param2) {
        StreamWeapon(this.weapons[param1.user]).calm(param3);
      }
    }
  }
}
