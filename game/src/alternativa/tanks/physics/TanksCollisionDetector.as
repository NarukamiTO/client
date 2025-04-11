package alternativa.tanks.physics {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.BodyContact;
  import alternativa.physics.ShapeContact;
  import alternativa.physics.collision.Collider;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.physics.collision.CollisionKdNode;
  import alternativa.physics.collision.CollisionKdTree;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.IRayCollisionFilter;
  import alternativa.physics.collision.colliders.BoxBoxCollider;
  import alternativa.physics.collision.colliders.BoxRectCollider;
  import alternativa.physics.collision.colliders.BoxSphereCollider;
  import alternativa.physics.collision.colliders.BoxTriangleCollider;
  import alternativa.physics.collision.types.AABB;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.objects.tank.Tank;

  public class TanksCollisionDetector implements CollisionDetector {
    private static const AABB_INTERSECTION_EPSILON:Number = 0.01;

    private const colliders:Object = {};
    private const _rayHit:RayHit = new RayHit();
    private const _time:MinMax = new MinMax();
    private const _normal:Vector3 = new Vector3();
    private const _o:Vector3 = new Vector3();
    private const _dynamicRayHit:RayHit = new RayHit();
    private const _rayAABB:AABB = new AABB();
    private const shapeContacts:Vector.<ShapeContact> = new Vector.<ShapeContact>();

    private var tree:CollisionKdTree = new CollisionKdTree();
    private var threshold:Number = 0.0001;
    private var tankBodies:Vector.<TankBody> = new Vector.<TankBody>();
    private var staticBody:Body;

    public function TanksCollisionDetector() {
      super();
      var local1:Number = 0.000001;
      this.setCollider(CollisionShape.BOX,CollisionShape.BOX,new BoxBoxCollider(local1));
      this.setCollider(CollisionShape.BOX,CollisionShape.RECT,new BoxRectCollider(local1));
      this.setCollider(CollisionShape.BOX,CollisionShape.TRIANGLE,new BoxTriangleCollider(local1));
      this.setCollider(CollisionShape.BOX,CollisionShape.SPHERE,new BoxSphereCollider());
      this.createStaticBody();
    }

    private function setCollider(param1:int, param2:int, param3:Collider) : void {
      this.colliders[param1 | param2] = param3;
    }

    private function createStaticBody() : void {
      this.staticBody = new Body(1,new Matrix3(),10000000000);
      this.staticBody.movable = false;
    }

    public function buildKdTree(param1:Vector.<CollisionShape>, param2:AABB = null) : void {
      var local3:CollisionShape = null;
      for each(local3 in param1) {
        local3.body = this.staticBody;
      }
      this.tree.createTree(param1,param2);
    }

    public function addTankBody(param1:TankBody) : void {
      param1.hasContactsWithStatic = false;
      this.tankBodies.push(param1);
    }

    public function removeTankBody(param1:TankBody) : void {
      var local3:int = 0;
      var local2:int = int(this.tankBodies.indexOf(param1));
      if(local2 > -1) {
        local3 = this.tankBodies.length - 1;
        this.tankBodies[local2] = this.tankBodies[local3];
        this.tankBodies.length = local3;
      }
    }

    public function getTankBodies() : Vector.<TankBody> {
      return this.tankBodies;
    }

    public function getBodyContacts(param1:Vector.<BodyContact>) : void {
      var local4:TankBody = null;
      var local5:Tank = null;
      var local6:int = 0;
      var local2:int = int(this.tankBodies.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = this.tankBodies[local3];
        local4.wasContactWithStatic = local4.hasContactsWithStatic;
        local5 = local4.body.tank;
        local4.hasContactsWithStatic = local5.hasTracksContactsWithStatic();
        local4.penetratedBodies.length = 0;
        local3++;
      }
      local3 = 0;
      while(local3 < local2) {
        local4 = this.tankBodies[local3];
        local6 = int(param1.length);
        this.getContactsWithStatic(local4,param1);
        if(local6 != param1.length) {
          local4.hasContactsWithStatic = true;
        }
        local6 = int(param1.length);
        this.getContactsWithOtherBodies(local4,local3 + 1,param1);
        local3++;
      }
    }

    public function getShapeContactsWithStatic(param1:CollisionShape, param2:Vector.<ShapeContact>) : void {
      return this.getShapeNodeCollisions(this.tree.rootNode,param1,param2);
    }

    private function getContactsWithStatic(param1:TankBody, param2:Vector.<BodyContact>) : void {
      var local3:int = 0;
      var local4:int = 0;
      var local5:BodyContact = null;
      if(!param1.body.frozen) {
        local3 = int(param1.staticShapes.length);
        local4 = 0;
        while(local4 < local3) {
          this.getShapeNodeCollisions(this.tree.rootNode,param1.staticShapes[local4],this.shapeContacts);
          local4++;
        }
        if(this.shapeContacts.length > 0) {
          local5 = BodyContact.create();
          local5.body1 = param1.body;
          local5.body2 = this.staticBody;
          local5.setShapeContacts(this.shapeContacts);
          this.shapeContacts.length = 0;
          param2[param2.length] = local5;
        }
      }
    }

    private function getContactsWithOtherBodies(param1:TankBody, param2:int, param3:Vector.<BodyContact>) : void {
      var local6:TankBody = null;
      var local7:Body = null;
      var local8:Body = null;
      var local9:int = 0;
      var local10:Boolean = false;
      var local11:Boolean = false;
      var local12:BodyContact = null;
      var local13:int = 0;
      var local14:ShapeContact = null;
      var local4:int = int(this.tankBodies.length);
      var local5:int = param2;
      while(local5 < local4) {
        local6 = this.tankBodies[local5];
        local7 = param1.body;
        local8 = local6.body;
        if(!(local7.frozen && local8.frozen) && local7.aabb.intersects(local8.aabb,AABB_INTERSECTION_EPSILON)) {
          this.getContacts(param1.tankCollisionBox,local6.tankCollisionBox,this.shapeContacts);
          local9 = int(this.shapeContacts.length);
          if(local9 > 0) {
            local10 = local7.postCollisionFilter == null || Boolean(local7.postCollisionFilter.considerBodies(local7,local8));
            local11 = local8.postCollisionFilter == null || Boolean(local8.postCollisionFilter.considerBodies(local8,local7));
            if(local10 && local11) {
              local12 = BodyContact.create();
              local12.body1 = local7;
              local12.body2 = local8;
              local12.setShapeContacts(this.shapeContacts);
              param3[param3.length] = local12;
              param1.penetratedBodies.push(local8);
              local6.penetratedBodies.push(local7);
            } else {
              local13 = 0;
              while(local13 < local9) {
                local14 = this.shapeContacts[local13];
                local14.dispose();
                local13++;
              }
            }
            this.shapeContacts.length = 0;
          }
        }
        local5++;
      }
    }

    public function getContacts(param1:CollisionShape, param2:CollisionShape, param3:Vector.<ShapeContact>) : void {
      if((param1.collisionGroup & param2.collisionGroup) == 0) {
        return;
      }
      if(param1.body == param2.body) {
        return;
      }
      if(!param1.aabb.intersects(param2.aabb,AABB_INTERSECTION_EPSILON)) {
        return;
      }
      var local4:Collider = this.colliders[param1.type | param2.type];
      local4.getContacts(param1,param2,param3);
    }

    public function testCollision(param1:CollisionShape, param2:CollisionShape) : Boolean {
      if((param1.collisionGroup & param2.collisionGroup) == 0) {
        return false;
      }
      if(param1.body == param2.body) {
        return false;
      }
      if(!param1.aabb.intersects(param2.aabb,AABB_INTERSECTION_EPSILON)) {
        return false;
      }
      var local3:Collider = this.colliders[param1.type | param2.type];
      return local3.haveCollision(param1,param2);
    }

    public function raycast(param1:Vector3, param2:Vector3, param3:int, param4:Number, param5:IRayCollisionFilter, param6:RayHit) : Boolean {
      var local7:Boolean = this.raycastStatic(param1,param2,param3,param4,param5,param6);
      var local8:Boolean = this.raycastDynamic(param1,param2,param3,param4,param5,this._dynamicRayHit);
      if(!(local8 || local7)) {
        return false;
      }
      if(local8 && local7) {
        if(param6.t > this._dynamicRayHit.t) {
          param6.copy(this._dynamicRayHit);
        }
        this._dynamicRayHit.clear();
        return true;
      }
      if(local7) {
        this._dynamicRayHit.clear();
        return true;
      }
      param6.copy(this._dynamicRayHit);
      this._dynamicRayHit.clear();
      return true;
    }

    public function raycastStatic(param1:Vector3, param2:Vector3, param3:int, param4:Number, param5:IRayCollisionFilter, param6:RayHit) : Boolean {
      if(!this.getRayBoundBoxIntersection(param1,param2,this.tree.rootNode.boundBox,this._time)) {
        return false;
      }
      if(this._time.max < 0 || this._time.min > param4) {
        return false;
      }
      if(this._time.min <= 0) {
        this._time.min = 0;
        this._o.x = param1.x;
        this._o.y = param1.y;
        this._o.z = param1.z;
      } else {
        this._o.x = param1.x + this._time.min * param2.x;
        this._o.y = param1.y + this._time.min * param2.y;
        this._o.z = param1.z + this._time.min * param2.z;
      }
      if(this._time.max > param4) {
        this._time.max = param4;
      }
      var local7:Boolean = this.testRayAgainstNode(this.tree.rootNode,param1,this._o,param2,param3,this._time.min,this._time.max,param5,param6);
      return local7 ? param6.t <= param4 : false;
    }

    public function hasStaticHit(param1:Vector3, param2:Vector3, param3:int, param4:Number, param5:IRayCollisionFilter = null) : Boolean {
      var local6:Boolean = this.raycastStatic(param1,param2,param3,param4,param5,this._rayHit);
      this._rayHit.clear();
      return local6;
    }

    private function getShapeNodeCollisions(param1:CollisionKdNode, param2:CollisionShape, param3:Vector.<ShapeContact>) : void {
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Vector.<CollisionShape> = null;
      var local7:Vector.<int> = null;
      var local8:int = 0;
      var local9:int = 0;
      if(param1.indices != null) {
        local6 = this.tree.staticChildren;
        local7 = param1.indices;
        local8 = int(local7.length);
        local9 = 0;
        while(local9 < local8) {
          this.getContacts(param2,local6[local7[local9]],param3);
          local9++;
        }
      }
      if(param1.axis == -1) {
        return;
      }
      switch(param1.axis) {
        case 0:
          local4 = param2.aabb.minX;
          local5 = param2.aabb.maxX;
          break;
        case 1:
          local4 = param2.aabb.minY;
          local5 = param2.aabb.maxY;
          break;
        case 2:
          local4 = param2.aabb.minZ;
          local5 = param2.aabb.maxZ;
      }
      if(local4 < param1.coord) {
        this.getShapeNodeCollisions(param1.negativeNode,param2,param3);
      }
      if(local5 > param1.coord) {
        this.getShapeNodeCollisions(param1.positiveNode,param2,param3);
      }
      if(param1.splitTree != null && local4 < param1.coord && local5 > param1.coord) {
        this.getShapeNodeCollisions(param1.splitTree.rootNode,param2,param3);
      }
    }

    private function testShapeNodeCollision(param1:CollisionShape, param2:CollisionKdNode) : Boolean {
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local5:Vector.<CollisionShape> = null;
      var local6:Vector.<int> = null;
      var local7:int = 0;
      var local8:int = 0;
      if(param2.indices != null) {
        local5 = this.tree.staticChildren;
        local6 = param2.indices;
        local7 = int(local6.length);
        local8 = 0;
        while(local8 < local7) {
          if(this.testCollision(param1,local5[local6[local8]])) {
            return true;
          }
          local8++;
        }
      }
      if(param2.axis == -1) {
        return false;
      }
      switch(param2.axis) {
        case 0:
          local3 = param1.aabb.minX;
          local4 = param1.aabb.maxX;
          break;
        case 1:
          local3 = param1.aabb.minY;
          local4 = param1.aabb.maxY;
          break;
        case 2:
          local3 = param1.aabb.minZ;
          local4 = param1.aabb.maxZ;
      }
      if(param2.splitTree != null && local3 < param2.coord && local4 > param2.coord) {
        if(this.testShapeNodeCollision(param1,param2.splitTree.rootNode)) {
          return true;
        }
      }
      if(local3 < param2.coord) {
        if(this.testShapeNodeCollision(param1,param2.negativeNode)) {
          return true;
        }
      }
      if(local4 > param2.coord) {
        if(this.testShapeNodeCollision(param1,param2.positiveNode)) {
          return true;
        }
      }
      return false;
    }

    private function raycastDynamic(param1:Vector3, param2:Vector3, param3:int, param4:Number, param5:IRayCollisionFilter, param6:RayHit) : Boolean {
      var local13:TankBody = null;
      var local14:Body = null;
      var local15:AABB = null;
      var local16:int = 0;
      var local17:CollisionShape = null;
      var local18:Number = NaN;
      var local7:Number = param1.x + param2.x * param4;
      var local8:Number = param1.y + param2.y * param4;
      var local9:Number = param1.z + param2.z * param4;
      if(local7 < param1.x) {
        this._rayAABB.minX = local7;
        this._rayAABB.maxX = param1.x;
      } else {
        this._rayAABB.minX = param1.x;
        this._rayAABB.maxX = local7;
      }
      if(local8 < param1.y) {
        this._rayAABB.minY = local8;
        this._rayAABB.maxY = param1.y;
      } else {
        this._rayAABB.minY = param1.y;
        this._rayAABB.maxY = local8;
      }
      if(local9 < param1.z) {
        this._rayAABB.minZ = local9;
        this._rayAABB.maxZ = param1.z;
      } else {
        this._rayAABB.minZ = param1.z;
        this._rayAABB.maxZ = local9;
      }
      var local10:Number = param4 + 1;
      var local11:int = int(this.tankBodies.length);
      var local12:int = 0;
      while(local12 < local11) {
        local13 = this.tankBodies[local12];
        local14 = local13.body;
        local15 = local14.aabb;
        if(!(this._rayAABB.maxX < local15.minX || this._rayAABB.minX > local15.maxX || this._rayAABB.maxY < local15.minY || this._rayAABB.minY > local15.maxY || this._rayAABB.maxZ < local15.minZ || this._rayAABB.minZ > local15.maxZ)) {
          local16 = 0;
          while(local16 < local14.numCollisionShapes) {
            local17 = local14.collisionShapes[local16];
            if((local17.collisionGroup & param3) != 0) {
              local15 = local17.aabb;
              if(!(this._rayAABB.maxX < local15.minX || this._rayAABB.minX > local15.maxX || this._rayAABB.maxY < local15.minY || this._rayAABB.minY > local15.maxY || this._rayAABB.maxZ < local15.minZ || this._rayAABB.minZ > local15.maxZ)) {
                if(!(param5 != null && !param5.considerBody(local14))) {
                  local18 = local17.raycast(param1,param2,this.threshold,this._normal);
                  if(local18 >= 0 && local18 < local10) {
                    local10 = local18;
                    param6.shape = local17;
                    param6.normal.x = this._normal.x;
                    param6.normal.y = this._normal.y;
                    param6.normal.z = this._normal.z;
                  }
                }
              }
            }
            local16++;
          }
        }
        local12++;
      }
      if(local10 > param4) {
        return false;
      }
      param6.position.x = param1.x + param2.x * local10;
      param6.position.y = param1.y + param2.y * local10;
      param6.position.z = param1.z + param2.z * local10;
      param6.t = local10;
      return true;
    }

    private function getRayBoundBoxIntersection(param1:Vector3, param2:Vector3, param3:AABB, param4:MinMax) : Boolean {
      var local5:Number = NaN;
      var local6:Number = NaN;
      param4.min = -1;
      param4.max = 1e+308;
      var local7:int = 0;
      for(; local7 < 3; local7++) {
        switch(local7) {
          case 0:
            if(!(param2.x < this.threshold && param2.x > -this.threshold)) {
              local5 = (param3.minX - param1.x) / param2.x;
              local6 = (param3.maxX - param1.x) / param2.x;
              break;
            }
            if(param1.x < param3.minX || param1.x > param3.maxX) {
              return false;
            }
            continue;
          case 1:
            if(!(param2.y < this.threshold && param2.y > -this.threshold)) {
              local5 = (param3.minY - param1.y) / param2.y;
              local6 = (param3.maxY - param1.y) / param2.y;
              break;
            }
            if(param1.y < param3.minY || param1.y > param3.maxY) {
              return false;
            }
            continue;
          case 2:
            if(!(param2.z < this.threshold && param2.z > -this.threshold)) {
              local5 = (param3.minZ - param1.z) / param2.z;
              local6 = (param3.maxZ - param1.z) / param2.z;
              break;
            }
            if(param1.z < param3.minZ || param1.z > param3.maxZ) {
              return false;
            }
            continue;
        }
        if(local5 < local6) {
          if(local5 > param4.min) {
            param4.min = local5;
          }
          if(local6 < param4.max) {
            param4.max = local6;
          }
        } else {
          if(local6 > param4.min) {
            param4.min = local6;
          }
          if(local5 < param4.max) {
            param4.max = local5;
          }
        }
        if(param4.max < param4.min) {
          return false;
        }
      }
      return true;
    }

    private function testRayAgainstNode(param1:CollisionKdNode, param2:Vector3, param3:Vector3, param4:Vector3, param5:int, param6:Number, param7:Number, param8:IRayCollisionFilter, param9:RayHit) : Boolean {
      var local10:Number = NaN;
      var local11:CollisionKdNode = null;
      var local12:Boolean = false;
      var local13:CollisionKdNode = null;
      var local14:int = 0;
      var local15:int = 0;
      var local16:CollisionShape = null;
      if(param1.indices != null && this.getRayNodeIntersection(param2,param4,param5,this.tree.staticChildren,param1.indices,param8,param9)) {
        return true;
      }
      if(param1.axis == -1) {
        return false;
      }
      switch(param1.axis) {
        case 0:
          if(param4.x > -this.threshold && param4.x < this.threshold) {
            local10 = param7 + 1;
          } else {
            local10 = (param1.coord - param2.x) / param4.x;
          }
          local11 = param3.x < param1.coord ? param1.negativeNode : param1.positiveNode;
          break;
        case 1:
          if(param4.y > -this.threshold && param4.y < this.threshold) {
            local10 = param7 + 1;
          } else {
            local10 = (param1.coord - param2.y) / param4.y;
          }
          local11 = param3.y < param1.coord ? param1.negativeNode : param1.positiveNode;
          break;
        case 2:
          if(param4.z > -this.threshold && param4.z < this.threshold) {
            local10 = param7 + 1;
          } else {
            local10 = (param1.coord - param2.z) / param4.z;
          }
          local11 = param3.z < param1.coord ? param1.negativeNode : param1.positiveNode;
      }
      if(local10 < param6 || local10 > param7) {
        return this.testRayAgainstNode(local11,param2,param3,param4,param5,param6,param7,param8,param9);
      }
      local12 = this.testRayAgainstNode(local11,param2,param3,param4,param5,param6,local10,param8,param9);
      if(local12) {
        return true;
      }
      this._o.x = param2.x + local10 * param4.x;
      this._o.y = param2.y + local10 * param4.y;
      this._o.z = param2.z + local10 * param4.z;
      if(param1.splitTree != null) {
        local13 = param1.splitTree.rootNode;
        while(local13 != null && local13.axis != -1) {
          switch(local13.axis) {
            case 0:
              local13 = this._o.x < local13.coord ? local13.negativeNode : local13.positiveNode;
              break;
            case 1:
              local13 = this._o.y < local13.coord ? local13.negativeNode : local13.positiveNode;
              break;
            case 2:
              local13 = this._o.z < local13.coord ? local13.negativeNode : local13.positiveNode;
              break;
          }
        }
        if(local13 != null && local13.indices != null) {
          local14 = int(local13.indices.length);
          local15 = 0;
          while(local15 < local14) {
            local16 = this.tree.staticChildren[local13.indices[local15]];
            if((local16.collisionGroup & param5) != 0) {
              if(!(param8 != null && !param8.considerBody(local16.body))) {
                param9.t = local16.raycast(param2,param4,this.threshold,param9.normal);
                if(param9.t >= 0) {
                  param9.position.copy(this._o);
                  param9.shape = local16;
                  return true;
                }
              }
            }
            local15++;
          }
        }
      }
      return this.testRayAgainstNode(local11 == param1.negativeNode ? param1.positiveNode : param1.negativeNode,param2,this._o,param4,param5,local10,param7,param8,param9);
    }

    private function getRayNodeIntersection(param1:Vector3, param2:Vector3, param3:int, param4:Vector.<CollisionShape>, param5:Vector.<int>, param6:IRayCollisionFilter, param7:RayHit) : Boolean {
      var local11:CollisionShape = null;
      var local12:Number = NaN;
      var local8:int = int(param5.length);
      var local9:Number = 1e+308;
      var local10:int = 0;
      while(local10 < local8) {
        local11 = param4[param5[local10]];
        if((local11.collisionGroup & param3) != 0) {
          if(!(param6 != null && !param6.considerBody(local11.body))) {
            local12 = local11.raycast(param1,param2,this.threshold,this._normal);
            if(local12 > 0 && local12 < local9) {
              local9 = local12;
              param7.shape = local11;
              param7.normal.x = this._normal.x;
              param7.normal.y = this._normal.y;
              param7.normal.z = this._normal.z;
            }
          }
        }
        local10++;
      }
      if(local9 == 1e+308) {
        return false;
      }
      param7.position.x = param1.x + param2.x * local9;
      param7.position.y = param1.y + param2.y * local9;
      param7.position.z = param1.z + param2.z * local9;
      param7.t = local9;
      return true;
    }

    public function testStaticCollision(param1:CollisionShape) : Boolean {
      return this.testShapeNodeCollision(param1,this.tree.rootNode);
    }

    public function destroy() : void {
      var local1:TankBody = null;
      this.tree.destroyTree();
      this.tree = null;
      for each(local1 in this.tankBodies) {
        local1.destroy();
      }
      this.tankBodies.length = 0;
      this.staticBody = null;
    }
  }
}
