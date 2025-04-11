package alternativa.tanks.models.weapon.machinegun {
  import alternativa.math.Vector3;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.Weapon;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.RayCollisionFilter;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapon.machinegun.sfx.MachineGunSFXData;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.physics.TanksCollisionDetector;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
  import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.cc.MachineGunCC;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class MachineGunRemoteWeapon implements LogicUnit, Weapon {
    [Inject]
    public static var battleService:BattleService;

    private static const MAX_DISTANCE:Number = 1000000;
    private static const rayHit:RayHit = new RayHit();
    private static const collisionFilter:RayCollisionFilter = new RayCollisionFilter();

    private var gunParams:AllGlobalGunParams;
    private var hittingTime:int;
    private var lastTime:int;
    private var params:MachineGunCC;
    private var target:Tank;
    private var hitPosition:Vector3;
    private var shooting:Boolean;
    private var weaponPlatform:WeaponPlatform;
    private var commonWeapon:MachineGunCommonWeapon;
    private var lastUpdateTargetTime:int;
    private var wasCallUpdateTargets:Boolean;
    private var spinUpTime:int;

    public function MachineGunRemoteWeapon(param1:IGameObject, param2:MachineGunCC, param3:MachineGunSFXData, param4:WeaponCommonData) {
      super();
      this.commonWeapon = new MachineGunCommonWeapon(param1,param2,param3,param4);
      this.lastTime = 0;
      this.params = param2;
      this.spinUpTime = param2.spinUpTime;
    }

    public function init(param1:WeaponPlatform) : void {
      this.commonWeapon.init(param1);
      this.weaponPlatform = param1;
    }

    public function destroy() : void {
      this.commonWeapon.destroy();
      battleService.getBattleRunner().removeLogicUnit(this);
    }

    public function deactivate() : void {
      this.commonWeapon.stopEffects();
      this.disable(false);
      battleService.getBattleRunner().removeLogicUnit(this);
    }

    public function start() : void {
      this.commonWeapon.start();
      this.gunParams = this.commonWeapon.updateGunParams();
      this.shooting = true;
      this.wasCallUpdateTargets = false;
      this.lastTime = this.getCurrentPhysicsTime();
      this.hittingTime = this.lastTime + this.spinUpTime;
    }

    public function updateTargets(param1:Vector3, param2:Vector.<TargetHit>) : void {
      this.gunParams = this.commonWeapon.updateGunParams();
      this.hitPosition = null;
      this.target = null;
      this.wasCallUpdateTargets = true;
      this.lastUpdateTargetTime = this.getCurrentPhysicsTime();
      var local3:Boolean = false;
      if(param2.length == 0) {
        if(this.calculateHitPosition(param1)) {
          this.hitPosition = rayHit.position;
          local3 = BattleUtils.isTankBody(rayHit.shape.body);
        }
      } else {
        local3 = true;
        this.hitPosition = BattleUtils.getVector3(param2[0].localHitPoint);
        this.target = ITankModel(param2[0].target.adapt(ITankModel)).getTank();
        BattleUtils.localToGlobal(this.target.getBody(),this.hitPosition);
      }
      this.updateTargetPosition(local3);
    }

    public function stop() : void {
      this.commonWeapon.stop();
      this.target = null;
      this.shooting = false;
    }

    public function runLogic(param1:int, param2:int) : void {
      var local3:Number = NaN;
      this.commonWeapon.updateCharacteristicsAndEffects(param2,this.shooting);
      this.gunParams = this.commonWeapon.updateGunParams();
      if(this.shooting) {
        this.updateTargetsIfNeed();
        local3 = this.commonWeapon.getPowerCoeff(param2,this.lastTime,this.hittingTime);
        if(local3 > 0) {
          this.commonWeapon.addRecoilForShooter(this.gunParams.direction,local3);
          if(Boolean(this.target) && this.lastUpdateTargetTime + 500 < this.getCurrentPhysicsTime()) {
            this.target = null;
          }
          if(this.target != null && this.target.getBody() != null) {
            this.commonWeapon.addImpactForTarget(this.target.getBody(),this.hitPosition,this.gunParams.direction,local3);
          }
        }
      }
      this.lastTime = param1;
    }

    public function activate() : void {
      this.commonWeapon.activate();
      if(this.params.started) {
        this.params.started = false;
        this.start();
        this.hittingTime = this.lastTime + this.spinUpTime * (1 - this.params.state);
        this.updateTargets(this.gunParams.direction,new Vector.<TargetHit>());
      }
      battleService.getBattleRunner().addLogicUnit(this);
    }

    public function enable() : void {
      this.commonWeapon.enable();
    }

    public function disable(param1:Boolean) : void {
      this.stop();
    }

    public function reset() : void {
      this.commonWeapon.reset();
      this.target = null;
    }

    public function getStatus() : Number {
      return 0;
    }

    private function getCurrentPhysicsTime() : int {
      return battleService.getBattleRunner().getPhysicsTime();
    }

    private function updateTargetsIfNeed() : void {
      var local1:Boolean = false;
      if(this.commonWeapon.state == 1 && !this.wasCallUpdateTargets) {
        this.gunParams = this.commonWeapon.updateGunParams();
        local1 = false;
        if(this.calculateHitPosition(this.gunParams.direction)) {
          this.hitPosition = rayHit.position;
          local1 = BattleUtils.isTankBody(rayHit.shape.body);
        } else {
          this.hitPosition = null;
        }
        this.updateTargetPosition(local1);
      }
    }

    private function calculateHitPosition(param1:Vector3) : Boolean {
      var local2:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
      collisionFilter.exclusion = this.weaponPlatform.getBody();
      return local2.raycast(this.gunParams.barrelOrigin,param1,CollisionGroup.WEAPON,MAX_DISTANCE,collisionFilter,rayHit);
    }

    private function updateTargetPosition(param1:Boolean) : void {
      if(this.hitPosition != null) {
        this.commonWeapon.setTargetPosition(this.hitPosition,param1);
      } else {
        this.commonWeapon.clearTargetPosition();
      }
    }

    public function getResistanceProperty() : ItemProperty {
      return ItemProperty.MACHINE_GUN_RESISTANCE;
    }

    public function updateRecoilForce(param1:Number) : void {
      this.commonWeapon.updateRecoilForce(param1);
    }

    public function fullyRecharge() : void {
    }

    public function weaponReloadTimeChanged(param1:int, param2:int) : void {
    }

    public function updateSpinTimes(param1:int, param2:int) : void {
      var local3:int = this.commonWeapon.getCurrentSpinUpTime();
      var local4:int = param1 - local3;
      this.spinUpTime = param1;
      this.hittingTime += local4;
      this.commonWeapon.updateSpinTimes(param1,param2);
    }

    public function stun() : void {
    }

    public function calm(param1:int) : void {
    }

    public function spin() : void {
      this.commonWeapon.spin();
    }
  }
}
