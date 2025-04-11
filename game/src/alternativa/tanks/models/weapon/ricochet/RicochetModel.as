package alternativa.tanks.models.weapon.ricochet {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import alternativa.tanks.battle.events.TankUnloadedEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.models.weapon.IWeaponModel;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import alternativa.tanks.models.weapon.common.WeaponBuffListener;
  import alternativa.tanks.models.weapon.shared.shot.WeaponReloadTimeChangedListener;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.IRicochetModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetModelBase;

  [ModelInfo]
  public class RicochetModel extends RicochetModelBase implements IRicochetModelBase, ObjectLoadListener, IWeaponModel, RicochetWeaponCallback, WeaponBuffListener, WeaponReloadTimeChangedListener, UltimateStunListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private static const shotDirection:Vector3 = new Vector3();

    private var battleEventSupport:BattleEventSupport;
    private var weapons:Dictionary = new Dictionary();
    private var localWeapon:RicochetWeapon;

    public function RicochetModel() {
      super();
      this.initBattleEventListeners();
    }

    private static function clientToServer(param1:Number) : Number {
      return param1 * 32767;
    }

    private static function serverToClient(param1:Number) : Number {
      return param1 / 32767;
    }

    private function initBattleEventListeners() : void {
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
      this.battleEventSupport.activateHandlers();
    }

    [Obfuscation(rename="false")]
    public function fire(param1:IGameObject, param2:int, param3:int, param4:int) : void {
      var local5:RemoteRicochetWeapon = this.weapons[param1];
      if(local5 != null) {
        shotDirection.reset(serverToClient(param2),serverToClient(param3),serverToClient(param4)).normalize();
        local5.shoot(shotDirection);
      }
    }

    [Obfuscation(rename="false")]
    public function fireDummy(param1:IGameObject) : void {
      var local2:RemoteRicochetWeapon = this.weapons[param1];
      if(local2 != null) {
        local2.shootDummy();
      }
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:RicochetCC = getInitParam();
      local1.shellRadius = BattleUtils.toClientScale(local1.shellRadius);
      local1.shellSpeed = BattleUtils.toClientScale(local1.shellSpeed);
      local1.shotDistance = BattleUtils.toClientScale(local1.shotDistance);
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      this.localWeapon = new RicochetWeapon(object,getInitParam());
      this.weapons[param1] = this.localWeapon;
      return this.localWeapon;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var local2:Weapon = new RemoteRicochetWeapon(object,getInitParam());
      this.weapons[param1] = local2;
      return local2;
    }

    public function onShot(param1:int, param2:int, param3:Vector3) : void {
      if(battleService.isBattleActive()) {
        this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
        server.fireCommand(param1,param2,clientToServer(param3.x),clientToServer(param3.y),clientToServer(param3.z));
      }
    }

    public function onDummyShot(param1:int) : void {
      if(battleService.isBattleActive()) {
        this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
        server.fireDummyCommand(param1);
      }
    }

    public function onTargetHit(param1:int, param2:Body, param3:Vector.<Vector3>) : void {
      var local4:Tank = null;
      if(battleService.isBattleActive()) {
        local4 = param2.tank;
        server.hitTargetCommand(battleService.getPhysicsTime(),local4.getUser(),param1,BattleUtils.getVector3d(param2.state.position),BattleUtils.getVector3dVector(param3));
      }
    }

    public function onStaticHit(param1:int, param2:Vector.<Vector3>) : void {
      if(battleService.isBattleActive()) {
        server.hitStaticCommand(battleService.getPhysicsTime(),param1,BattleUtils.getVector3dVector(param2));
      }
    }

    private function onTankUnloaded(param1:TankUnloadedEvent) : void {
      delete this.weapons[param1.tank.getUser()];
    }

    public function addEnergy(param1:int) : void {
      if(this.isLocalWeapon()) {
        this.localWeapon.addEnergy(param1);
      }
    }

    public function reconfigureWeapon(param1:Number, param2:Number) : void {
      var local3:Number = NaN;
      if(this.isLocalWeapon()) {
        local3 = BattleUtils.toClientScale(param1);
        this.localWeapon.reconfigure(local3,param2);
      }
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      if(this.isLocalWeapon()) {
        this.localWeapon.weaponReloadTimeChanged(param1,param2);
      }
    }

    public function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void {
      var local4:IRicochetWeapon = this.weapons[param1];
      if(local4 != null) {
        local4.updateRecoilForce(param3);
        local4.setBuffedMode(param2);
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

    private function isLocalWeapon() : Boolean {
      var local1:Tank = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
      return ITankModel(local1.user.adapt(ITankModel)).isLocal();
    }
  }
}
