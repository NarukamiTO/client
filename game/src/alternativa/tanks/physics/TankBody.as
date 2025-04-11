package alternativa.tanks.physics {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.primitives.CollisionBox;

  public class TankBody {
    public var id:int;
    public var body:Body;
    public var tankCollisionBox:CollisionBox;
    public var staticShapes:Vector.<CollisionShape> = new Vector.<CollisionShape>();
    public var hasContactsWithStatic:Boolean;
    public var penetratedBodies:Vector.<Body> = new Vector.<Body>();
    public var wasContactWithStatic:Boolean;
    public var additionForcesSum:Vector3 = new Vector3();
    public var previousUpVelocity:Number = 0;

    private var soaringChecker:SoaringChecker;

    public function TankBody(param1:Body) {
      super();
      this.body = param1;
    }

    public function onTankInited() : void {
      this.soaringChecker = new SoaringChecker(this);
    }

    public function hasContactsWithOtherBodies() : Boolean {
      return this.penetratedBodies.length > 0;
    }

    public function destroy() : void {
      this.soaringChecker = null;
      this.body = null;
      this.staticShapes = null;
      this.penetratedBodies = null;
    }

    public function updateSoaring() : void {
      this.soaringChecker.updateSoaring();
    }

    public function isSoaring() : Boolean {
      return this.soaringChecker.isSoaring();
    }

    public function isJumpBegin() : Boolean {
      return this.soaringChecker.isJumpBegin();
    }

    public function isJumpEnd() : Boolean {
      return this.soaringChecker.isJumpEnd();
    }

    public function isElasticStaticCollisionWhenSoaring() : Boolean {
      return this.soaringChecker.isElasticStaticCollisionWhenSoaring();
    }
  }
}
