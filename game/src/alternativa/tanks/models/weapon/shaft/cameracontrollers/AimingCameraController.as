package alternativa.tanks.models.weapon.shaft.cameracontrollers {
  import alternativa.math.Matrix3;
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.camera.CameraController;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.shaft.LinearInterpolator;
  import alternativa.tanks.models.weapon.shaft.ShaftAimingType;
  import alternativa.tanks.models.weapon.shaft.ShaftWeapon;
  import alternativa.tanks.utils.MathUtils;
  import alternativa.utils.removeDisplayObject;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class AimingCameraController implements CameraController {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleService:BattleService;

    private static const OFFSET_ELIMINATION_SPEED:Number = 1;
    private static const Cross:Class = AimingCameraController_Cross;
    private static const CrossBitmap:BitmapData = new Cross().bitmapData;

    private var cross:Bitmap = new Bitmap(CrossBitmap);
    private var weapon:ShaftWeapon;
    private var weaponPlatform:WeaponPlatform;

    private const gunParams:AllGlobalGunParams = new AllGlobalGunParams();
    private const rotation:Quaternion = new Quaternion();
    private const directionRotation:Quaternion = new Quaternion();
    private const elevationRotation:Quaternion = new Quaternion();
    private const m3:Matrix3 = new Matrix3();
    private const yAxis:Vector3 = new Vector3();
    private const globalAimDirection:Vector3 = new Vector3();

    private var aimingType:ShaftAimingType = ShaftAimingType.DIRECTIONAL;
    private var elevationOffset:Number = 0;
    private var directionOffset:Number = 0;
    private var fovInterpolator:LinearInterpolator = new LinearInterpolator();

    public function AimingCameraController(param1:ShaftWeapon, param2:WeaponPlatform, param3:Number, param4:Number) {
      super();
      this.weapon = param1;
      this.weaponPlatform = param2;
      this.fovInterpolator.setInterval(param3,param4);
    }

    public function activate(param1:GameCamera) : void {
      this.elevationOffset = 0;
      this.directionOffset = 0;
      this.showReticle();
      if(this.aimingType == ShaftAimingType.MOUSE) {
        this.showCross();
      }
    }

    public function deactivate() : void {
      this.hideCross();
      this.hideReticle();
    }

    private function showReticle() : void {
      battleService.getBattleView().getParentDisplayContainer().addChild(this.weapon.getReticleDisplay());
      this.weapon.getReticleDisplay().centerOnScreen();
    }

    private function hideReticle() : void {
      removeDisplayObject(this.weapon.getReticleDisplay());
    }

    private function showCross() : void {
      battleService.getBattleView().getParentDisplayContainer().addChild(this.cross);
      this.updateCrossPosition();
    }

    private function hideCross() : void {
      removeDisplayObject(this.cross);
    }

    public function setAimingType(param1:ShaftAimingType) : void {
      if(this.aimingType != param1) {
        this.aimingType = param1;
        switch(param1) {
          case ShaftAimingType.DIRECTIONAL:
            this.directionOffset = MathUtils.clampAngleDelta(this.weapon.getTargetDirection(),this.weaponPlatform.getWeaponMount().getTurretInterpolatedDirection());
            this.elevationOffset = this.weapon.getTargetElevation() - this.weapon.getInterpolatedElevation();
            this.hideCross();
            break;
          case ShaftAimingType.MOUSE:
            this.showCross();
        }
      }
    }

    public function update(param1:GameCamera, param2:int, param3:int) : void {
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      param1.fov = this.fovInterpolator.interpolate(this.weapon.getAimingModeEnergyFraction());
      this.weaponPlatform.getAllGunParams(this.gunParams);
      var local4:Vector3 = this.gunParams.elevationAxis;
      var local5:Vector3 = this.gunParams.direction;
      this.yAxis.cross2(local5,local4);
      this.m3.setAxis(local4,this.yAxis,local5);
      this.m3.rotationMatrixToQuaternion(this.rotation);
      switch(this.aimingType) {
        case ShaftAimingType.DIRECTIONAL:
          local8 = OFFSET_ELIMINATION_SPEED * 0.001 * param3;
          this.directionOffset = MathUtils.moveValueTowards(this.directionOffset,0,local8);
          this.elevationOffset = MathUtils.moveValueTowards(this.elevationOffset,0,local8);
          local7 = this.directionOffset;
          local6 = this.weapon.getInterpolatedElevation() + this.elevationOffset;
          break;
        case ShaftAimingType.MOUSE:
          local7 = MathUtils.clampAngleDelta(this.weapon.getTargetDirection(),this.weaponPlatform.getWeaponMount().getTurretInterpolatedDirection());
          local6 = this.weapon.getTargetElevation();
          this.updateCrossPosition();
      }
      this.directionRotation.setFromAxisAngle(Vector3.Y_AXIS,-local7);
      this.elevationRotation.setFromAxisAngle(Vector3.X_AXIS,local6);
      this.rotation.prepend(this.directionRotation);
      this.rotation.prepend(this.elevationRotation);
      param1.setPosition(this.gunParams.barrelOrigin);
      param1.setQRotation(this.rotation);
      this.weapon.getAimDirection(this.globalAimDirection);
      this.weapon.getReticleDisplay().updatePositon(this.globalAimDirection);
    }

    private function updateCrossPosition() : void {
      this.cross.x = display.stage.stageWidth - this.cross.width >> 1;
      this.cross.y = display.stage.stageHeight - this.cross.height >> 1;
    }
  }
}
