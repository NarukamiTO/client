package alternativa.physics.contactislands {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.BodyContact;
  import alternativa.physics.PhysicsScene;
  import alternativa.physics.ShapeContact;

  public class ContactIsland {
    private static var poolSize:int;

    private static const pool:Vector.<ContactIsland> = new Vector.<ContactIsland>();
    private static const _relativeVelocity:Vector3 = new Vector3();
    private static const COLLISION_MODE:int = 0;
    private static const CONTACT_MODE:int = 1;

    public const bodyContacts:Vector.<BodyContact> = new Vector.<BodyContact>();

    private var physicsScene:PhysicsScene;

    private const allShapeContacts:Vector.<ShapeContact> = new Vector.<ShapeContact>();
    private const levelShapeContacts:Vector.<ShapeContact> = new Vector.<ShapeContact>();

    private var prevLevelBodies:Vector.<Body> = new Vector.<Body>();
    private var levelBodies:Vector.<Body> = new Vector.<Body>();

    private const levelBodyContacts:Vector.<BodyContact> = new Vector.<BodyContact>();
    private const contactLevels:ContactLevels = new ContactLevels();

    public function ContactIsland() {
      super();
    }

    public static function create() : ContactIsland {
      if(poolSize == 0) {
        return new ContactIsland();
      }
      --poolSize;
      var local1:ContactIsland = pool[poolSize];
      pool[poolSize] = null;
      return local1;
    }

    public function dispose() : void {
      this.physicsScene = null;
      this.bodyContacts.length = 0;
      this.allShapeContacts.length = 0;
      this.levelShapeContacts.length = 0;
      this.prevLevelBodies.length = 0;
      this.levelBodies.length = 0;
      this.levelBodyContacts.length = 0;
      this.contactLevels.clear();
      var local1:* = poolSize++;
      pool[local1] = this;
    }

    public function init(param1:PhysicsScene) : void {
      var local5:BodyContact = null;
      var local6:Vector.<ShapeContact> = null;
      var local7:int = 0;
      var local8:int = 0;
      this.physicsScene = param1;
      var local2:int = int(this.bodyContacts.length);
      var local3:Vector.<ShapeContact> = this.allShapeContacts;
      var local4:int = 0;
      while(local4 < local2) {
        local5 = this.bodyContacts[local4];
        local6 = local5.shapeContacts;
        local7 = int(local6.length);
        local8 = 0;
        while(local8 < local7) {
          local3[local3.length] = local6[local8];
          local8++;
        }
        local4++;
      }
    }

    public function collisionPhase(param1:int) : void {
      this.resolveCollisions(param1);
    }

    public function contactPhase(param1:int) : void {
      this.resolveContacts(param1);
    }

    private function resolveCollisions(param1:int) : void {
      var local4:int = 0;
      var local2:int = int(this.allShapeContacts.length);
      var local3:int = 0;
      while(local3 < param1) {
        this.shuffleContacts(this.allShapeContacts);
        local4 = 0;
        while(local4 < local2) {
          this.resolveContact(this.allShapeContacts[local4],COLLISION_MODE);
          local4++;
        }
        local3++;
      }
    }

    private function resolveContacts(param1:int) : void {
      var local2:Vector.<Body> = null;
      var local3:int = 0;
      var local4:int = 0;
      var local5:ShapeContact = null;
      this.processContacts(param1);
      this.contactLevels.init(this.bodyContacts);
      this.contactLevels.getStaticLevel(this.levelBodyContacts,this.levelBodies);
      if(this.levelBodyContacts.length > 0) {
        this.getShapeContacts(this.levelBodyContacts,this.levelShapeContacts);
        this.resolveContactsForLevel(param1,this.levelShapeContacts);
        this.calculatePseudoVelocities(param1,this.levelShapeContacts);
        while(this.contactLevels.hasContacts()) {
          local2 = this.prevLevelBodies;
          this.prevLevelBodies = this.levelBodies;
          this.levelBodies = local2;
          this.levelBodyContacts.length = 0;
          this.levelBodies.length = 0;
          this.contactLevels.getNextLevel(this.prevLevelBodies,this.levelBodyContacts,this.levelBodies);
          this.setBodiesMobility(this.prevLevelBodies,false);
          this.levelShapeContacts.length = 0;
          this.getShapeContacts(this.levelBodyContacts,this.levelShapeContacts);
          local3 = int(this.levelShapeContacts.length);
          local4 = 0;
          while(local4 < local3) {
            local5 = this.levelShapeContacts[local4];
            local5.calcualteDynamicFrameData(this.physicsScene.allowedPenetration,this.physicsScene.penetrationErrorCorrection,this.physicsScene.maxCorrectablePenetration,this.physicsScene.dt);
            local4++;
          }
          this.resolveContactsForLevel(param1,this.levelShapeContacts);
          this.calculatePseudoVelocities(param1,this.levelShapeContacts);
          this.setBodiesMobility(this.prevLevelBodies,true);
        }
      } else {
        this.getShapeContacts(this.bodyContacts,this.levelShapeContacts);
        this.resolveContactsForLevel(param1,this.levelShapeContacts);
        this.calculatePseudoVelocities(param1,this.levelShapeContacts);
      }
    }

    private function processContacts(param1:int) : void {
      var local4:int = 0;
      var local2:int = int(this.allShapeContacts.length);
      var local3:int = 0;
      while(local3 < param1) {
        this.shuffleContacts(this.allShapeContacts);
        local4 = 0;
        while(local4 < local2) {
          this.resolveContact(this.allShapeContacts[local4],CONTACT_MODE);
          local4++;
        }
        local3++;
      }
    }

    private function getShapeContacts(param1:Vector.<BodyContact>, param2:Vector.<ShapeContact>) : void {
      var local5:BodyContact = null;
      var local6:Vector.<ShapeContact> = null;
      var local7:int = 0;
      var local8:int = 0;
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param1[local4];
        local6 = local5.shapeContacts;
        local7 = int(local6.length);
        local8 = 0;
        while(local8 < local7) {
          param2[param2.length] = local6[local8];
          local8++;
        }
        local4++;
      }
    }

    private function shuffleContacts(param1:Vector.<ShapeContact>) : void {
      var local4:int = 0;
      var local5:ShapeContact = null;
      var local2:int = int(param1.length);
      var local3:int = 1;
      while(local3 < local2) {
        local4 = local3 * Math.random();
        local5 = param1[local4];
        param1[local4] = param1[local3];
        param1[local3] = local5;
        local3++;
      }
    }

    private function resolveContactsForLevel(param1:int, param2:Vector.<ShapeContact>) : void {
      var local4:int = 0;
      var local5:int = 0;
      var local3:int = 0;
      while(local3 < param1) {
        this.shuffleContacts(param2);
        local4 = int(param2.length);
        local5 = 0;
        while(local5 < local4) {
          this.resolveContact(param2[local5],CONTACT_MODE);
          local5++;
        }
        local3++;
      }
    }

    private function calculatePseudoVelocities(param1:int, param2:Vector.<ShapeContact>) : void {
      var local4:int = 0;
      var local5:int = 0;
      var local3:int = 0;
      while(local3 < param1) {
        this.shuffleContacts(param2);
        local4 = int(param2.length);
        local5 = 0;
        while(local5 < local4) {
          this.resolveContactPseudoVelocity(param2[local5]);
          local5++;
        }
        local3++;
      }
    }

    private function setBodiesMobility(param1:Vector.<Body>, param2:Boolean) : void {
      var local5:Body = null;
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param1[local4];
        local5.movable = param2;
        local4++;
      }
    }

    private function resolveContact(param1:ShapeContact, param2:int) : void {
      var local8:Number = NaN;
      var local20:Number = NaN;
      var local3:Vector3 = param1.normal;
      var local4:Body = param1.shape1.body;
      var local5:Body = param1.shape2.body;
      var local6:Vector3 = _relativeVelocity;
      this.calculateRelativeVelocity(param1,local6);
      var local7:Number = local6.x * local3.x + local6.y * local3.y + local6.z * local3.z;
      if(param2 == CONTACT_MODE) {
        local8 = 0;
        if(local7 < 0) {
          param1.satisfied = false;
        } else if(param1.satisfied) {
          return;
        }
      } else {
        param1.satisfied = true;
        local8 = param1.collisionSpeed;
      }
      var local9:Number = local6.dot(param1.tangent1);
      var local10:Number = local6.dot(param1.tangent2);
      var local11:Number = param1.tangentImpulse1 - local9 / param1.tangentSpeedDelta1;
      var local12:Number = param1.tangentImpulse2 - local10 / param1.tangentSpeedDelta2;
      var local13:Number = local11 * local11 + local12 * local12;
      var local14:Number = param1.friction * param1.normalImpulse;
      if(local13 > local14 * local14) {
        local20 = Math.sqrt(local13);
        local11 *= local14 / local20;
        local12 *= local14 / local20;
      }
      var local15:Number = local11 - param1.tangentImpulse1;
      var local16:Number = local12 - param1.tangentImpulse2;
      param1.tangentImpulse1 = local11;
      param1.tangentImpulse2 = local12;
      if(local4.movable) {
        local4.applyWorldImpulseAtLocalPoint(param1.r1,param1.tangent1,local15);
        local4.applyWorldImpulseAtLocalPoint(param1.r1,param1.tangent2,local16);
      }
      if(local5.movable) {
        local5.applyWorldImpulseAtLocalPoint(param1.r2,param1.tangent1,-local15);
        local5.applyWorldImpulseAtLocalPoint(param1.r2,param1.tangent2,-local16);
      }
      this.calculateRelativeVelocity(param1,local6);
      local7 = local6.x * local3.x + local6.y * local3.y + local6.z * local3.z;
      var local17:Number = local8 - local7;
      var local18:Number = param1.normalImpulse + local17 / param1.normalSpeedDelta;
      if(local18 < 0) {
        local18 = 0;
      }
      var local19:Number = local18 - param1.normalImpulse;
      param1.normalImpulse = local18;
      if(local4.movable) {
        local4.applyWorldImpulseAtLocalPoint(param1.r1,param1.normal,local19);
      }
      if(local5.movable) {
        local5.applyWorldImpulseAtLocalPoint(param1.r2,param1.normal,-local19);
      }
    }

    private function calculateRelativeVelocity(param1:ShapeContact, param2:Vector3) : void {
      var local4:Vector3 = null;
      var local3:Vector3 = param1.shape1.body.state.angularVelocity;
      local4 = param1.r1;
      var local5:Number = local3.y * local4.z - local3.z * local4.y;
      var local6:Number = local3.z * local4.x - local3.x * local4.z;
      var local7:Number = local3.x * local4.y - local3.y * local4.x;
      local4 = param1.shape1.body.state.velocity;
      param2.x = local4.x + local5;
      param2.y = local4.y + local6;
      param2.z = local4.z + local7;
      local3 = param1.shape2.body.state.angularVelocity;
      local4 = param1.r2;
      local5 = local3.y * local4.z - local3.z * local4.y;
      local6 = local3.z * local4.x - local3.x * local4.z;
      local7 = local3.x * local4.y - local3.y * local4.x;
      local4 = param1.shape2.body.state.velocity;
      param2.x -= local4.x + local5;
      param2.y -= local4.y + local6;
      param2.z -= local4.z + local7;
    }

    private function resolveContactPseudoVelocity(param1:ShapeContact) : void {
      var local2:Vector3 = _relativeVelocity;
      this.calcPseudoSeparationVelocity(param1,local2);
      var local3:Number = local2.x * param1.normal.x + local2.y * param1.normal.y + local2.z * param1.normal.z;
      var local4:Number = param1.contactSeparationSpeed - local3;
      var local5:Number = local4 / param1.normalSpeedDelta;
      if(param1.shape1.body.movable) {
        param1.shape1.body.applyWorldPseudoImpulseAtLocalPoint(param1.r1,param1.normal,local5);
      }
      if(param1.shape2.body.movable) {
        param1.shape2.body.applyWorldPseudoImpulseAtLocalPoint(param1.r2,param1.normal,-local5);
      }
    }

    private function calcPseudoSeparationVelocity(param1:ShapeContact, param2:Vector3) : void {
      var local4:Vector3 = null;
      var local3:Vector3 = param1.shape1.body.pseudoAngularVelocity;
      local4 = param1.r1;
      var local5:Number = local3.y * local4.z - local3.z * local4.y;
      var local6:Number = local3.z * local4.x - local3.x * local4.z;
      var local7:Number = local3.x * local4.y - local3.y * local4.x;
      local4 = param1.shape1.body.pseudoVelocity;
      param2.x = local4.x + local5;
      param2.y = local4.y + local6;
      param2.z = local4.z + local7;
      local3 = param1.shape2.body.pseudoAngularVelocity;
      local4 = param1.r2;
      local5 = local3.y * local4.z - local3.z * local4.y;
      local6 = local3.z * local4.x - local3.x * local4.z;
      local7 = local3.x * local4.y - local3.y * local4.x;
      local4 = param1.shape2.body.pseudoVelocity;
      param2.x -= local4.x + local5;
      param2.y -= local4.y + local6;
      param2.z -= local4.z + local7;
    }
  }
}
