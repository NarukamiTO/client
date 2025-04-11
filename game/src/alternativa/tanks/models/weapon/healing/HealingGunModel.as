package alternativa.tanks.models.weapon.healing {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.models.weapon.IWeaponModel;
  import alternativa.tanks.models.weapon.common.WeaponBuffListener;
  import alternativa.tanks.models.weapon.shared.SimpleWeaponController;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IIsisModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisState;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
  import projects.tanks.client.battlefield.types.Vector3d;

  [ModelInfo]
  public class HealingGunModel extends IsisModelBase implements IIsisModelBase, IWeaponModel, HealingGunCallback, ObjectLoadListener, WeaponBuffListener, UltimateStunListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var tmpVector:Vector3 = new Vector3();
    private var localHitPoint:Vector3d = new Vector3d();
    private var tanksInBattle:Dictionary = new Dictionary();
    private var battleEventSupport:BattleEventSupport;

    public function HealingGunModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
      this.battleEventSupport.activateHandlers();
    }

    private static function getEffects() : HealingGunEffects {
      var local1:IHealingGunSFXModel = IHealingGunSFXModel(object.adapt(IHealingGunSFXModel));
      return local1.getHealingGunEffects();
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      var local1:IsisCC = getInitParam();
      local1.radius = BattleUtils.toClientScale(local1.radius);
    }

    [Obfuscation(rename="false")]
    public function setTarget(param1:IsisState, param2:TargetHit) : void {
      this.doStartWeapon(param1,param2);
    }

    [Obfuscation(rename="false")]
    public function stopWeapon() : void {
      var local1:RemoteHealingGun = this.getRemoteWeapon();
      if(local1 != null) {
        local1.stop();
      }
    }

    [Obfuscation(rename="false")]
    public function resetTarget() : void {
      var local1:RemoteHealingGun = this.getRemoteWeapon();
      local1.resetTarget();
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      var local2:HealingGunEffects = getEffects();
      var local3:Weapon = new LocalHealingGun(param1,getInitParam(),new SimpleWeaponController(),local2,HealingGunCallback(object.adapt(HealingGunCallback)));
      putData(LocalHealingGun,local3);
      return local3;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var local2:Weapon = new RemoteHealingGun(getEffects());
      putData(RemoteHealingGun,local2);
      return local2;
    }

    public function updateHit(param1:int, param2:RayHit) : void {
      var local3:Body = null;
      var local4:Tank = null;
      if(param2 != null) {
        local3 = param2.shape.body;
        local4 = local3.tank;
        local4.setLastHitPoint(param2.position);
        server.setTarget(param1,local4.getUser(),local4.incarnation,this.getLocalHitPoint(param2));
      } else {
        server.resetTarget(param1);
      }
    }

    public function stop(param1:int) : void {
      server.stopWeaponCommand(param1);
    }

    public function onTick(param1:int, param2:RayHit) : void {
      this.battleEventSupport.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      var local3:Body = param2.shape.body;
      var local4:Tank = local3.tank;
      server.tickCommand(param1,local4.incarnation,BattleUtils.getVector3d(local3.state.position),this.getLocalHitPoint(param2));
    }

    private function doStartWeapon(param1:IsisState, param2:TargetHit) : void {
      var local4:Tank = null;
      var local5:Vector3 = null;
      var local6:Vector3d = null;
      var local3:RemoteHealingGun = this.getRemoteWeapon();
      if(local3 != null) {
        if(param1 != IsisState.IDLE) {
          if(param2 != null && param2.target != null) {
            local4 = this.tanksInBattle[param2.target.id];
          }
        }
        if(param1 == IsisState.IDLE || local4 != null) {
          local5 = this.tmpVector;
          local6 = param2.localHitPoint;
          local5.reset(local6.x,local6.y,local6.z);
          local3.startAction(param1,local4,local5);
        } else {
          local3.stop();
        }
      }
    }

    private function getLocalHitPoint(param1:RayHit) : Vector3d {
      var local2:Body = param1.shape.body;
      var local3:Vector3 = BattleUtils.tmpVector;
      local3.copy(param1.position);
      BattleUtils.globalToLocal(local2,local3);
      BattleUtils.copyToVector3d(local3,this.localHitPoint);
      return this.localHitPoint;
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      this.tanksInBattle[param1.tank.getUser().id] = param1.tank;
    }

    private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void {
      delete this.tanksInBattle[param1.tank.getUser().id];
    }

    private function getRemoteWeapon() : RemoteHealingGun {
      return RemoteHealingGun(getData(RemoteHealingGun));
    }

    public function addEnergy(param1:int) : void {
      var local2:LocalHealingGun = LocalHealingGun(getData(LocalHealingGun));
      if(local2 != null) {
        local2.addEnergy(param1);
      }
    }

    public function reconfigureWeapon(param1:Number, param2:Number, param3:Number, param4:Number) : void {
      var local5:Number = BattleUtils.toClientScale(param4);
      var local6:LocalHealingGun = LocalHealingGun(getData(LocalHealingGun));
      if(local6 != null) {
        local6.reconfigure(param1,param2,param3,local5);
      }
    }

    public function weaponBuffStateChanged(param1:IGameObject, param2:Boolean, param3:Number) : void {
      var local5:RemoteHealingGun = null;
      var local4:LocalHealingGun = LocalHealingGun(getData(LocalHealingGun));
      if(local4 != null) {
        local4.setBuffedMode(param2);
        local4.addEnergy(getInitParam().capacity);
      } else {
        local5 = this.getRemoteWeapon();
        local5.setBuffedMode(param2);
      }
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      if(param2) {
        LocalHealingGun(getData(LocalHealingGun)).stun();
      }
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
      if(param2) {
        LocalHealingGun(getData(LocalHealingGun)).calm(param3);
      }
    }
  }
}
