package alternativa.tanks.bonuses {
  import alternativa.math.Matrix3;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.PhysicsMaterial;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.primitives.CollisionBox;
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.Trigger;
  import alternativa.tanks.physics.CollisionGroup;

  public class BonusTrigger extends BattleRunnerProvider implements Trigger {
    private var bonus:BattleBonus;
    private var collisionBox:CollisionBox;

    public function BonusTrigger(param1:BattleBonus) {
      super();
      this.bonus = param1;
      var local2:Number = BonusConst.BONUS_HALF_SIZE;
      this.collisionBox = new CollisionBox(new Vector3(local2,local2,local2),CollisionGroup.BONUS_WITH_TANK,PhysicsMaterial.DEFAULT_MATERIAL);
    }

    public function enable() : void {
      getBattleRunner().addTrigger(this);
    }

    public function disable() : void {
      getBattleRunner().removeTrigger(this);
    }

    public function update(param1:Matrix4) : void {
      var local2:Matrix4 = this.collisionBox.transform;
      local2.copy(param1);
      this.collisionBox.calculateAABB();
    }

    public function updateByComponents(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:Number) : void {
      var local7:Matrix4 = this.collisionBox.transform;
      local7.setMatrix(param1,param2,param3,param4,param5,param6);
      this.collisionBox.calculateAABB();
    }

    public function setTransform(param1:Vector3, param2:Matrix3) : void {
      var local3:Matrix4 = this.collisionBox.transform;
      local3.setFromMatrix3(param2,param1);
      this.collisionBox.calculateAABB();
    }

    public function checkTrigger(param1:Body) : void {
      var local3:CollisionShape = null;
      var local2:int = 0;
      while(local2 < param1.numCollisionShapes) {
        local3 = param1.collisionShapes[local2];
        if(getBattleRunner().getCollisionDetector().testCollision(local3,this.collisionBox)) {
          this.bonus.onTriggerActivated();
          return;
        }
        local2++;
      }
    }
  }
}
