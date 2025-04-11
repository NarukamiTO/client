package alternativa.tanks.physics {
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.PhysicsMaterial;
  import alternativa.physics.ShapeContact;
  import alternativa.physics.collision.primitives.CollisionBox;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.TankConst;

  public class SoaringChecker {
    [Inject]
    public static var battleService:BattleService;

    private static const HALF_WHEEL_SIZE:Number = 12.5;
    private static const contacts:Vector.<ShapeContact> = new Vector.<ShapeContact>();

    private var tank:Tank;
    private var testSoaringCollisionBox:CollisionBox;
    private var wasSoaring:Boolean;
    private var soaring:Boolean;
    private var staticIsNear:Boolean;

    public function SoaringChecker(param1:TankBody) {
      super();
      this.tank = param1.body.tank;
      var local2:Vector3 = this.tank.getMainCollisionBox().hs.clone();
      local2.z += HALF_WHEEL_SIZE;
      this.testSoaringCollisionBox = new CollisionBox(local2,-1,PhysicsMaterial.DEFAULT_MATERIAL);
      this.testSoaringCollisionBox.body = this.tank.getBody();
    }

    public function updateSoaring() : void {
      var local3:ShapeContact = null;
      var local4:Number = NaN;
      this.wasSoaring = this.soaring;
      this.updateSoaringCollisionBox();
      var local1:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
      local1.getShapeContactsWithStatic(this.testSoaringCollisionBox,contacts);
      var local2:Number = 0;
      for each(local3 in contacts) {
        if(local3.shape1 == this.testSoaringCollisionBox) {
          local4 = local3.normal.dot(Vector3.Z_AXIS);
        } else {
          local4 = local3.normal.dot(Vector3.DOWN);
        }
        local2 = Math.max(local2,local4);
        local3.dispose();
      }
      this.staticIsNear = contacts.length > 0;
      contacts.length = 0;
      this.soaring = local2 < TankConst.MAX_SLOPE_ANGLE_COS;
    }

    private function updateSoaringCollisionBox() : void {
      var local1:CollisionBox = this.tank.getMainCollisionBox();
      var local2:Matrix4 = this.testSoaringCollisionBox.transform;
      local2.copy(local1.transform);
      local2.m03 -= local2.m02 * HALF_WHEEL_SIZE;
      local2.m13 -= local2.m12 * HALF_WHEEL_SIZE;
      local2.m23 -= local2.m22 * HALF_WHEEL_SIZE;
      this.testSoaringCollisionBox.calculateAABB();
    }

    public function isSoaring() : Boolean {
      return this.soaring;
    }

    public function isJumpBegin() : Boolean {
      return this.soaring && !this.wasSoaring;
    }

    public function isJumpEnd() : Boolean {
      return this.wasSoaring && !this.soaring;
    }

    public function isElasticStaticCollisionWhenSoaring() : Boolean {
      return this.soaring && this.staticIsNear;
    }
  }
}
