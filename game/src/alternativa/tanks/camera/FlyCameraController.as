package alternativa.tanks.camera {
  import alternativa.math.Vector3;
  import alternativa.tanks.utils.MathUtils;

  public class FlyCameraController implements CameraController {
    private static const FLY_HEIGHT:Number = 3000;
    private static const cameraPosition:Vector3 = new Vector3();

    private var p1:Vector3 = new Vector3();
    private var p2:Vector3 = new Vector3();
    private var p3:Vector3 = new Vector3();
    private var p4:Vector3 = new Vector3();
    private var totalDistance:Number;
    private var distance:Number;
    private var acceleration:Number;
    private var speed:Number;
    private var angleValuesX:AngleValues = new AngleValues();
    private var angleValuesZ:AngleValues = new AngleValues();
    private var duration:int;

    private const targetPosition:Vector3 = new Vector3();
    private const targetAngles:Vector3 = new Vector3();

    public function FlyCameraController(param1:int) {
      super();
      this.duration = param1;
    }

    public function init(param1:Vector3, param2:Vector3) : void {
      this.targetPosition.copy(param1);
      this.targetAngles.copy(param2);
    }

    public function activate(param1:GameCamera) : void {
      this.p1.copy(param1.position);
      this.p2.copy(this.p1);
      this.p4.copy(this.targetPosition);
      this.p3.copy(this.p4);
      this.p2.z = this.p3.z = (this.p1.z > this.p4.z ? this.p1.z : this.p4.z) + FLY_HEIGHT;
      var local2:Number = 4000000 / (this.duration * this.duration);
      this.angleValuesX.init(MathUtils.clampAngle(param1.rotationX),this.targetAngles.x,local2);
      this.angleValuesZ.init(MathUtils.clampAngle(param1.rotationZ),this.targetAngles.z,local2);
      var local3:Vector3 = new Vector3();
      local3.diff(this.p4,this.p1);
      this.totalDistance = local3.length();
      this.acceleration = this.totalDistance * local2;
      this.distance = 0;
      this.speed = 0;
    }

    public function deactivate() : void {
    }

    public function update(param1:GameCamera, param2:int, param3:int) : void {
      if(this.speed < 0) {
        return;
      }
      if(this.distance > 0.5 * this.totalDistance && this.acceleration > 0) {
        this.acceleration = -this.acceleration;
        this.angleValuesX.reverseAcceleration();
        this.angleValuesZ.reverseAcceleration();
      }
      var local4:Number = 0.001 * param3;
      var local5:Number = this.acceleration * local4;
      this.distance += (this.speed + 0.5 * local5) * local4;
      this.speed += local5;
      if(this.distance > this.totalDistance) {
        this.distance = this.totalDistance;
      }
      this.bezier(this.distance / this.totalDistance,this.p1,this.p2,this.p3,this.p4,cameraPosition);
      param1.setPosition(cameraPosition);
      param1.rotateBy(this.angleValuesX.update(local4),0,this.angleValuesZ.update(local4));
    }

    private function bezier(param1:Number, param2:Vector3, param3:Vector3, param4:Vector3, param5:Vector3, param6:Vector3) : void {
      var local9:Number = NaN;
      var local11:Number = NaN;
      var local7:Number = 1 - param1;
      var local8:Number = local7 * local7;
      local9 = 3 * param1 * local8;
      local8 *= local7;
      var local10:Number = param1 * param1;
      local11 = 3 * local10 * local7;
      local10 *= param1;
      param6.x = local8 * param2.x + local9 * param3.x + local11 * param4.x + local10 * param5.x;
      param6.y = local8 * param2.y + local9 * param3.y + local11 * param4.y + local10 * param5.y;
      param6.z = local8 * param2.z + local9 * param3.z + local11 * param4.z + local10 * param5.z;
    }
  }
}
