package alternativa.physics {
  import alternativa.math.Vector3;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.physics.contactislands.ContactIsland;
  import alternativa.physics.contactislands.IslandsGenerator;
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;

  public class PhysicsScene {
    private static const thousandth:EncryptedInt = new EncryptedIntImpl(1000);

    public var penetrationErrorCorrection:Number = 0.7;
    public var maxCorrectablePenetration:Number = 10;
    public var allowedPenetration:Number = 0.01;
    public var collisionIterations:int = 4;
    public var contactIterations:int = 4;
    public var freezeSteps:int = 10;
    public var linSpeedFreezeLimit:Number = 5;
    public var angSpeedFreezeLimit:Number = 0.05;

    public const gravity:Vector3 = new Vector3(0,0,-9.8);

    public var collisionDetector:CollisionDetector;
    public var bodies:Vector.<Body> = new Vector.<Body>();
    public var timeStamp:int;
    public var time:int;
    public var dt:Number;

    private const bodyContacts:Vector.<BodyContact> = new Vector.<BodyContact>();

    private var islandsGenerator:IslandsGenerator;

    public function PhysicsScene() {
      super();
      this.islandsGenerator = new IslandsGenerator(this);
    }

    public function addBody(param1:Body) : void {
      param1.scene = this;
      param1.id = this.bodies.length;
      this.bodies.push(param1);
    }

    public function removeBody(param1:Body) : void {
      var local3:int = 0;
      var local4:Body = null;
      var local2:int = int(this.bodies.indexOf(param1));
      if(local2 > -1) {
        local3 = this.bodies.length - 1;
        local4 = this.bodies[local3];
        this.bodies[local2] = local4;
        local4.id = local2;
        this.bodies.length = local3;
        param1.scene = null;
      }
    }

    public function update(param1:int) : void {
      ++this.timeStamp;
      this.time += param1;
      this.dt = param1 / thousandth.getInt();
      this.applyForces();
      this.detectCollisions();
      this.prepareBodyContacts(this.bodyContacts,this.dt);
      this.islandsGenerator.generate(this.bodyContacts,this.bodies.length);
      this.resolveCollisions(this.islandsGenerator.contactIslands);
      this.intergateVelocities(this.dt);
      this.resolveContacts(this.islandsGenerator.contactIslands);
      this.islandsGenerator.clear();
      this.disposeBodyContacts(this.bodyContacts);
      this.integratePositions(this.dt);
      this.postPhysics();
    }

    private function applyForces() : void {
      var local3:Body = null;
      var local1:int = int(this.bodies.length);
      var local2:int = 0;
      while(local2 < local1) {
        local3 = this.bodies[local2];
        local3.calcAccelerations();
        if(local3.movable && !local3.frozen) {
          local3.acceleration.x += this.gravity.x;
          local3.acceleration.y += this.gravity.y;
          local3.acceleration.z += this.gravity.z;
        }
        local2++;
      }
    }

    private function detectCollisions() : void {
      this.calculateBodiesDerivedData();
      this.collisionDetector.getBodyContacts(this.bodyContacts);
    }

    private function calculateBodiesDerivedData() : void {
      var local3:Body = null;
      var local1:int = int(this.bodies.length);
      var local2:int = 0;
      while(local2 < local1) {
        local3 = this.bodies[local2];
        if(!local3.frozen) {
          local3.saveState();
          local3.calcDerivedData();
        }
        local2++;
      }
    }

    private function prepareBodyContacts(param1:Vector.<BodyContact>, param2:Number) : void {
      var local5:BodyContact = null;
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param1[local4];
        this.prepareShapeContacts(local5.shapeContacts,param2);
        local4++;
      }
    }

    private function prepareShapeContacts(param1:Vector.<ShapeContact>, param2:Number) : void {
      var local5:ShapeContact = null;
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param1[local4];
        local5.calculatePersistentFrameData();
        local5.calcualteDynamicFrameData(this.allowedPenetration,this.penetrationErrorCorrection,this.maxCorrectablePenetration,param2);
        local4++;
      }
    }

    private function resolveCollisions(param1:Vector.<ContactIsland>) : void {
      var local4:ContactIsland = null;
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = param1[local3];
        local4.collisionPhase(this.collisionIterations);
        local3++;
      }
    }

    private function resolveContacts(param1:Vector.<ContactIsland>) : void {
      var local4:ContactIsland = null;
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = param1[local3];
        local4.contactPhase(this.contactIterations);
        local3++;
      }
    }

    private function intergateVelocities(param1:Number) : void {
      var local4:Body = null;
      var local2:int = int(this.bodies.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = this.bodies[local3];
        local4.integrateVelocity(param1);
        local3++;
      }
    }

    private function integratePositions(param1:Number) : void {
      var local4:Body = null;
      var local2:int = int(this.bodies.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = this.bodies[local3];
        if(local4.movable && !local4.frozen) {
          local4.integratePosition(param1);
          local4.integratePseudoVelocity(param1);
        }
        local3++;
      }
    }

    private function postPhysics() : void {
      var local3:Body = null;
      var local4:BodyState = null;
      var local1:int = int(this.bodies.length);
      var local2:int = 0;
      while(local2 < local1) {
        local3 = this.bodies[local2];
        local3.clearAccumulators();
        local3.calcDerivedData();
        if(local3.canFreeze && !local3.frozen) {
          local4 = local3.state;
          if(local4.velocity.length() < this.linSpeedFreezeLimit && local4.angularVelocity.length() < this.angSpeedFreezeLimit) {
            ++local3.freezeCounter;
            if(local3.freezeCounter >= this.freezeSteps) {
              local3.frozen = true;
            }
          } else {
            local3.freezeCounter = 0;
            local3.frozen = false;
          }
        }
        local2++;
      }
    }

    private function disposeBodyContacts(param1:Vector.<BodyContact>) : void {
      var local4:BodyContact = null;
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = param1[local3];
        local4.dispose();
        local3++;
      }
      param1.length = 0;
    }
  }
}
