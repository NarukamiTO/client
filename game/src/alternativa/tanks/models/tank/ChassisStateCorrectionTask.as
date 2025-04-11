package alternativa.tanks.models.tank {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.BodyState;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.PostPhysicsController;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.LocalTankKilledEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.battle.facilities.BattleFacilitiesChecker;
  import alternativa.tanks.models.weapon.shared.MarginalCollider;
  import alternativa.tanks.physics.SweptSphereTest;
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import flash.utils.Dictionary;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.IGameObject;

  public class ChassisStateCorrectionTask extends BattleRunnerProvider implements PostPhysicsController {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private static const COLLISION_PREDICTION_TIME_SEC:Number = 2;
    private static const PENETRATION_PREVENTION_INTERVAL_MSEC:EncryptedInt = new EncryptedIntImpl(1000);
    private static const MAX_INTERVAL_MS:EncryptedInt = new EncryptedIntImpl(2000);
    private static const MAX_DISTANCE:Number = 500;
    private static const MAX_DISTANCE_Z:Number = 200;
    private static const MAX_DISTANCE_SQUARED:Number = MAX_DISTANCE * MAX_DISTANCE;
    private static const SIGNIFICANT_ENERGY_DELTA:Number = 300000;

    private var tank:Tank;
    private var lastCorrectionTime:int;
    private var lastCorrectionPosition:Vector3 = new Vector3();
    private var previousEnergy:Number;
    private var tanksInBattle:Dictionary;
    private var tracksCollisions:int;
    private var bodyHasCollisions:Boolean;
    private var firstPhysicsStep:Boolean;
    private var battleEventSupport:BattleEventSupport;
    private var controlWasChanged:Boolean = false;

    public function ChassisStateCorrectionTask(param1:Tank, param2:Dictionary) {
      super();
      this.tank = param1;
      this.tanksInBattle = param2;
      this.firstPhysicsStep = true;
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(LocalTankKilledEvent,this.tankKilled);
      this.battleEventSupport.activateHandlers();
    }

    private function tankKilled(param1:Object) : void {
      this.firstPhysicsStep = true;
    }

    public function reset() : void {
      this.lastCorrectionTime = getBattleRunner().getPhysicsTime();
      this.lastCorrectionPosition.copy(this.getCurrentPosition());
      this.tracksCollisions = this.tank.getLeftTrack().numContacts + this.tank.getRightTrack().numContacts;
      this.bodyHasCollisions = this.tank.hasCollisionWithStatic() || this.tank.hasCollisionWithOtherBodies();
      this.previousEnergy = this.getEnergy();
    }

    public function runAfterPhysicsUpdate(param1:Number) : void {
      var local3:Body = null;
      var local2:Boolean = this.needMandatoryCorrection() || this.firstPhysicsStep;
      this.firstPhysicsStep = false;
      if(this.tank.hasCollisionWithOtherBodies()) {
        for each(local3 in this.tank.getPenetratedBodies()) {
          this.tankModel().handleCollisionWithOtherTank(local3.tank);
        }
      }
      if(this.hasStaticIntersection() || this.tank.isJumpBegin()) {
        this.correctByPreviousState();
      }
      if(local2 || this.needRegularCorrection()) {
        this.correctByCurrentState(local2);
        this.controlWasChanged = false;
      }
    }

    private function hasStaticIntersection() : Boolean {
      return MarginalCollider.segmentWithStaticIntersection(this.lastCorrectionPosition,this.tank.getBody().state.position);
    }

    private function correctByPreviousState() : void {
      this.lastCorrectionTime = getBattleRunner().getPhysicsTime() - BattleRunner.PHYSICS_STEP_IN_MS;
      this.lastCorrectionPosition.copy(this.getPrevPosition());
      this.tankModel().onPrevStateCorrection(true);
    }

    private function getPrevPosition() : Vector3 {
      return this.tank.getBody().prevState.position;
    }

    private function getPosition() : Vector3 {
      return this.tank.getBody().state.position;
    }

    private function needRegularCorrection() : Boolean {
      return this.isTimeToRegularCorrect() || this.controlWasChanged;
    }

    private function needMandatoryCorrection() : Boolean {
      return this.isXYDistanceTooLarge() || this.isZDistanceTooLarge() || this.isDeepPenetrationPreventionRequired() || this.tracksCollisionsStateChanges() || this.bodyCollisionsStateChanged() || this.fullEnergySignificallyChanges() || this.tank.isJumpEnd() || this.tank.isElasticStaticCollisionWhenSoaring() || this.overdrivesDemandsCorrection();
    }

    private function overdrivesDemandsCorrection() : Boolean {
      var local1:BattleFacilitiesChecker = BattleFacilitiesChecker(battleService.getBattle().adapt(BattleFacilitiesChecker));
      return local1.checkFacilityZonesDemandsStateCorrection(this.getPrevPosition(),this.getPosition());
    }

    public function controlChanged() : void {
      this.controlWasChanged = true;
    }

    private function bodyCollisionsStateChanged() : Boolean {
      var local1:Boolean = this.tank.hasCollisionWithStatic() || this.tank.hasCollisionWithOtherBodies();
      return local1 != this.bodyHasCollisions;
    }

    private function tracksCollisionsStateChanges() : Boolean {
      var local1:int = this.tank.getLeftTrack().numContacts + this.tank.getRightTrack().numContacts;
      return this.tracksCollisions == 0 && local1 != 0 || this.tracksCollisions != 0 && local1 == 0;
    }

    private function isTimeToRegularCorrect() : Boolean {
      return getBattleRunner().getPhysicsTime() - this.lastCorrectionTime >= MAX_INTERVAL_MS.getInt();
    }

    private function isXYDistanceTooLarge() : Boolean {
      return this.lastCorrectionPosition.distanceToXYSquared(this.getCurrentPosition()) > MAX_DISTANCE_SQUARED;
    }

    private function isZDistanceTooLarge() : Boolean {
      return Math.abs(this.lastCorrectionPosition.z - this.getCurrentPosition().z) > MAX_DISTANCE_Z;
    }

    private function correctByCurrentState(param1:Boolean) : void {
      this.reset();
      this.tankModel().sendStateCorrection(param1);
    }

    private function getCurrentPosition() : Vector3 {
      return this.tank.getBody().state.position;
    }

    private function fullEnergySignificallyChanges() : Boolean {
      var local1:Number = this.getEnergy() - this.previousEnergy;
      return local1 > SIGNIFICANT_ENERGY_DELTA;
    }

    private function isDeepPenetrationPreventionRequired() : Boolean {
      var local1:int = int(PENETRATION_PREVENTION_INTERVAL_MSEC.getInt());
      return this.isCollisionPossible() && getTimer() - this.lastCorrectionTime > local1;
    }

    private function getEnergy() : Number {
      var local1:BodyState = this.tank.getBody().state;
      var local2:Number = local1.position.z * Math.abs(getBattleRunner().getGravity());
      var local3:Number = local1.velocity.length();
      var local4:Number = local3 * local3 * 0.5;
      return local4 + local2;
    }

    private function isCollisionPossible() : Boolean {
      var local5:Tank = null;
      var local6:Body = null;
      var local7:BodyState = null;
      var local1:Body = this.tank.getBody();
      var local2:BodyState = local1.state;
      var local3:Number = this.tank.getBoundSphereRadius();
      var local4:Number = COLLISION_PREDICTION_TIME_SEC;
      for each(local5 in this.tanksInBattle) {
        if(this.tank != local5) {
          local6 = local5.getBody();
          local7 = local6.state;
          if(SweptSphereTest.test(local2.position,local2.velocity,local3,local7.position,local7.velocity,local5.getBoundSphereRadius(),local4)) {
            return true;
          }
        }
      }
      return false;
    }

    private function tankModel() : ITankModel {
      var local1:IGameObject = this.tank.getUser();
      return ITankModel(local1.adapt(ITankModel));
    }
  }
}
