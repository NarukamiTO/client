package alternativa.tanks.physics {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.PhysicsScene;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.utils.DataValidationErrorEvent;
  import alternativa.tanks.utils.DataValidatorType;
  import alternativa.tanks.utils.Vector3Validator;

  public class TankPhysicsScene {
    private static const MAX_UP_VELOCITY:Number = 200;

    private var gravityValidator:Vector3Validator;
    private var physicsScene:PhysicsScene;
    private var collisionDetector:TanksCollisionDetector;
    private var battleEventDispatcher:BattleEventDispatcher;

    public function TankPhysicsScene(param1:int, param2:Number, param3:BattleEventDispatcher) {
      super();
      this.battleEventDispatcher = param3;
      this.physicsScene = new PhysicsScene();
      this.physicsScene.gravity.reset(0,0,-param2);
      this.gravityValidator = new Vector3Validator(this.physicsScene.gravity);
      this.physicsScene.collisionIterations = 4;
      this.physicsScene.contactIterations = 4;
      this.physicsScene.allowedPenetration = 5;
      this.collisionDetector = new TanksCollisionDetector();
      this.physicsScene.collisionDetector = this.collisionDetector;
      this.physicsScene.time = param1;
    }

    public function getPhysicsTime() : int {
      return this.physicsScene.time;
    }

    public function initStaticGeometry(param1:Vector.<CollisionShape>) : void {
      this.collisionDetector.buildKdTree(param1);
    }

    public function getCollisionDetector() : TanksCollisionDetector {
      return this.collisionDetector;
    }

    public function addBody(param1:TankBody) : void {
      this.physicsScene.addBody(param1.body);
      this.collisionDetector.addTankBody(param1);
    }

    public function removeBody(param1:TankBody) : void {
      this.physicsScene.removeBody(param1.body);
      this.collisionDetector.removeTankBody(param1);
    }

    public function destroy() : void {
      this.collisionDetector.destroy();
    }

    public function update(param1:int) : void {
      if(this.gravityValidator.isValid()) {
        this.physicsScene.update(param1);
        this.postPhysicsTankProcessor();
      } else {
        this.physicsScene.time = int.MAX_VALUE;
        this.battleEventDispatcher.dispatchEventOnce(new DataValidationErrorEvent(DataValidatorType.MEMHACK_GRAVITY));
      }
    }

    private function postPhysicsTankProcessor() : void {
      var local1:TankBody = null;
      var local2:Body = null;
      var local3:Vector3 = null;
      var local4:Vector3 = null;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      for each(local1 in this.collisionDetector.getTankBodies()) {
        local2 = local1.body;
        local3 = local2.state.velocity;
        local4 = BattleUtils.tmpVector;
        local2.state.orientation.getZAxis(local4);
        local5 = local3.x * local4.x + local3.y * local4.y + local3.z * local4.z;
        if(local4.z < -0.1 || local4.z < 0.1 && local5 < 0) {
          local5 = -local5;
          local4.reverse();
        }
        local1.updateSoaring();
        if(local1.hasContactsWithStatic || local1.wasContactWithStatic || local1.hasContactsWithOtherBodies() || !local1.isSoaring()) {
          local6 = MAX_UP_VELOCITY;
          if(!local1.hasContactsWithStatic && local1.isSoaring() && local1.previousUpVelocity > local6) {
            local6 = local1.previousUpVelocity;
          }
          local7 = local1.additionForcesSum.dot(local4);
          local8 = local7 * local1.body.invMass * BattleRunner.PHYSICS_STEP_IN_MS / 1000;
          if(local8 < MAX_UP_VELOCITY) {
            local8 = 0;
          }
          local6 = Math.max(local8,local6);
          if(local5 > local6) {
            local9 = local5 - local6;
            local3.x -= local9 * local4.x;
            local3.y -= local9 * local4.y;
            local3.z -= local9 * local4.z;
            local5 = local6;
          }
        }
        local1.previousUpVelocity = local5;
        local1.additionForcesSum.reset();
      }
    }

    public function getGravity() : Number {
      return this.physicsScene.gravity.z;
    }
  }
}
