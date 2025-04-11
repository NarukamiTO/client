package alternativa.tanks.bonuses {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;

  public class FallController implements BonusController {
    private static const MAX_ANGLE_X:Number = 0.1;
    private static const ANGLE_X_FREQ:Number = 1;
    private static const m:Matrix3 = new Matrix3();
    private static const v:Vector3 = new Vector3();

    private const interpolatedMatrix:Matrix3 = new Matrix3();
    private const interpolatedVector:Vector3 = new Vector3();
    private const oldState:BattleBonusState = new BattleBonusState();
    private const newState:BattleBonusState = new BattleBonusState();
    private const interpolatedState:BattleBonusState = new BattleBonusState();

    private var battleBonus:BattleBonus;
    private var minPivotZ:Number;
    private var time:Number;
    private var fallSpeed:Number;
    private var t0:Number;
    private var x:Number = 0;
    private var y:Number = 0;

    public function FallController(param1:BattleBonus) {
      super();
      this.battleBonus = param1;
    }

    public function init(param1:Vector3, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void {
      this.x = param1.x;
      this.y = param1.y;
      this.newState.pivotZ = param1.z + BonusConst.BONUS_OFFSET_Z - param2 * param5;
      this.newState.angleZ = param6 + BonusConst.ANGULAR_SPEED_Z * param5;
      this.fallSpeed = param2;
      this.minPivotZ = param3;
      this.t0 = param4;
      this.time = param5;
    }

    public function start() : void {
    }

    public function runBeforePhysicsUpdate(param1:Number) : void {
      this.oldState.copy(this.newState);
      this.time += param1;
      this.newState.pivotZ -= this.fallSpeed * param1;
      this.newState.angleX = MAX_ANGLE_X * Math.sin(ANGLE_X_FREQ * (this.t0 + this.time));
      this.newState.angleZ += BonusConst.ANGULAR_SPEED_Z * param1;
      if(this.newState.pivotZ <= this.minPivotZ) {
        this.newState.pivotZ = this.minPivotZ;
        this.newState.angleX = 0;
        this.interpolatePhysicsState(1);
        this.render();
        this.battleBonus.onTouchGround();
      }
      this.updateTrigger();
    }

    private function updateTrigger() : void {
      m.setRotationMatrix(this.newState.angleX,0,this.newState.angleZ);
      m.transformVector(Vector3.DOWN,v);
      v.scale(BonusConst.BONUS_OFFSET_Z);
      var local1:BonusTrigger = this.battleBonus.getTrigger();
      local1.updateByComponents(this.x + v.x,this.y + v.y,this.newState.pivotZ + v.z,this.newState.angleX,0,this.newState.angleZ);
    }

    public function interpolatePhysicsState(param1:Number) : void {
      this.interpolatedState.interpolate(this.oldState,this.newState,param1);
      this.interpolatedMatrix.setRotationMatrix(this.interpolatedState.angleX,0,this.interpolatedState.angleZ);
      this.interpolatedMatrix.transformVector(Vector3.DOWN,this.interpolatedVector);
    }

    public function render() : void {
      this.setObjectTransform(this.battleBonus.getParachute(),BonusConst.PARACHUTE_OFFSET_Z,this.interpolatedVector);
      this.setObjectTransform(this.battleBonus.getBonusMesh(),BonusConst.BONUS_OFFSET_Z,this.interpolatedVector);
      this.battleBonus.getCords().updateVertices();
    }

    private function setObjectTransform(param1:Object3DWrapper, param2:Number, param3:Vector3) : void {
      param1.setRotationComponents(this.interpolatedState.angleX,0,this.interpolatedState.angleZ);
      param1.setPositionComponents(this.x + param2 * param3.x,this.y + param2 * param3.y,this.interpolatedState.pivotZ + param2 * param3.z);
    }
  }
}
