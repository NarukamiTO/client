package alternativa.tanks.models.weapon.twins {
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
  import projects.tanks.client.battlefield.models.tankparts.weapon.twins.ITwinsModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.twins.TwinsModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;

  [ModelInfo]
  public class TwinsModel extends TwinsModelBase implements ITwinsModelBase, ObjectLoadListener, IWeaponModel, TwinsWeaponCallback, WeaponBuffListener, WeaponReloadTimeChangedListener, UltimateStunListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var weapons:Dictionary = new Dictionary();
    private var battleEventSupport:BattleEventSupport;

    public function TwinsModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankUnloadedEvent,this.onTankUnloaded);
      this.battleEventSupport.activateHandlers();
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:TwinsCC = getInitParam();
      local1.speed = BattleUtils.toClientScale(local1.speed);
      local1.shellRadius = BattleUtils.toClientScale(local1.shellRadius);
    }

    [Obfuscation(rename="false")]
    public function fire(param1:IGameObject, param2:int, param3:int, param4:Vector3d) : void {
      var local5:RemoteTwinsWeapon = null;
      if(battleService.isBattleActive()) {
        local5 = this.weapons[param1];
        if(local5 != null) {
          local5.fire(param2,param3,BattleUtils.getVector3(param4));
        }
      }
    }

    [Obfuscation(rename="false")]
    public function fireDummy(param1:IGameObject, param2:int) : void {
      var local3:RemoteTwinsWeapon = null;
      if(battleService.isBattleActive()) {
        local3 = this.weapons[param1];
        if(local3 != null) {
          local3.fireDummy(param2);
        }
      }
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      var local2:Weapon = new TwinsWeapon(param1,object,getInitParam());
      this.weapons[param1] = local2;
      return local2;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var local2:Weapon = new RemoteTwinsWeapon(object,getInitParam());
      this.weapons[param1] = local2;
      return local2;
    }

    public function onShot(param1:int, param2:int, param3:int, param4:Vector3) : void {
      if(battleService.isBattleActive()) {
        this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
        server.fireCommand(param1,param3,param2,BattleUtils.getVector3d(param4));
      }
    }

    public function onDummyShot(param1:int, param2:int) : void {
      if(battleService.isBattleActive()) {
        this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
        server.fireDummyCommand(param1,param2);
      }
    }

    public function onTargetHit(param1:int, param2:Body, param3:Vector3) : void {
      var local4:Tank = null;
      var local5:IGameObject = null;
      var local6:Vector3d = null;
      if(battleService.isBattleActive()) {
        local4 = param2.tank;
        local5 = local4.getUser();
        local6 = BattleUtils.getVector3d(param2.state.position);
        server.hitTargetCommand(battleService.getPhysicsTime(),param1,local5,local6,BattleUtils.getVector3d(param3));
      }
    }

    private function onTankUnloaded(param1:TankUnloadedEvent) : void {
      delete this.weapons[param1.tank.getUser()];
    }

    public function onStaticHit(param1:int, param2:Vector3) : void {
      if(battleService.isBattleActive()) {
        server.hitStaticCommand(battleService.getPhysicsTime(),param1,BattleUtils.getVector3d(param2));
      }
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
      var local3:Tank = null;
      if(this.isLocalWeapon()) {
        local3 = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
        Weapon(this.weapons[local3.user]).weaponReloadTimeChanged(param1,param2);
      }
    }

    public function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void {
      var local4:Weapon = this.weapons[param1];
      if(local4 != null) {
        local4.updateRecoilForce(param3);
        if(!param2) {
          local4.fullyRecharge();
        }
      }
    }

    private function isLocalWeapon() : Boolean {
      var local1:Tank = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
      return ITankModel(local1.user.adapt(ITankModel)).isLocal();
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      if(param2) {
        Weapon(this.weapons[param1.user]).stun();
      }
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      if(param2) {
        Weapon(this.weapons[param1.user]).calm(param3);
      }
    }
  }
}
