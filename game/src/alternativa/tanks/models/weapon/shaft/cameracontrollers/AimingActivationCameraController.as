package alternativa.tanks.models.weapon.shaft.cameracontrollers {
  import alternativa.math.Matrix3;
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.camera.CameraController;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.shaft.LinearInterpolator;

  public class AimingActivationCameraController implements CameraController {
    private var weaponPlatform:WeaponPlatform;
    private var transitionDuration:Number = 0;
    private var transitionTime:Number = 0;

    private const initialPosition:Vector3 = new Vector3();
    private const currentPosition:Vector3 = new Vector3();
    private const initialRotation:Quaternion = new Quaternion();
    private const targetRotation:Quaternion = new Quaternion();
    private const currentRotation:Quaternion = new Quaternion();
    private const currentEulerAngles:Vector3 = new Vector3();
    private const gunParams:AllGlobalGunParams = new AllGlobalGunParams();

    private var fovInterpolator:LinearInterpolator = new LinearInterpolator();
    private var targetCameraFov:Number;

    private const yAxis:Vector3 = new Vector3();
    private const m3:Matrix3 = new Matrix3();

    public function AimingActivationCameraController(param1:WeaponPlatform, param2:int, param3:Number) {
      super();
      this.weaponPlatform = param1;
      this.transitionDuration = param2;
      this.targetCameraFov = param3;
    }

    public function activate(param1:GameCamera) : void {
      param1.readPosition(this.initialPosition);
      param1.readQRotation(this.initialRotation);
      this.transitionTime = this.transitionDuration;
      this.fovInterpolator.setInterval(param1.fov,this.targetCameraFov);
    }

    public function deactivate() : void {
    }

    public function update(param1:GameCamera, param2:int, param3:int) : void {
      this.transitionTime -= param3;
      var local4:Number = 1 - this.transitionTime / this.transitionDuration;
      if(local4 > 1) {
        local4 = 1;
      }
      this.weaponPlatform.getAllGunParams(this.gunParams);
      this.currentPosition.interpolate(local4,this.initialPosition,this.gunParams.barrelOrigin);
      this.calculateTargetRotation(this.gunParams,this.targetRotation);
      this.currentRotation.slerp(this.initialRotation,this.targetRotation,local4);
      this.currentRotation.normalize();
      this.currentRotation.getEulerAngles(this.currentEulerAngles);
      param1.setPosition(this.currentPosition);
      param1.setRotation(this.currentEulerAngles);
      param1.fov = this.fovInterpolator.interpolate(local4);
    }

    private function calculateTargetRotation(param1:AllGlobalGunParams, param2:Quaternion) : void {
      var local3:Vector3 = param1.elevationAxis;
      var local4:Vector3 = param1.direction;
      this.yAxis.cross2(local4,local3);
      this.m3.setAxis(local3,this.yAxis,local4);
      this.m3.getEulerAngles(this.currentEulerAngles);
      param2.setFromEulerAngles(this.currentEulerAngles);
    }
  }
}
