package alternativa.tanks.camera {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.math.Matrix3;
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.CameraFovCalculator;

  public class GameCamera extends Camera3D {
    private static const m:Matrix3 = new Matrix3();
    private static const eulerAngles:Vector3 = new Vector3();

    public var position:Vector3 = new Vector3();
    public var xAxis:Vector3 = new Vector3();
    public var yAxis:Vector3 = new Vector3();
    public var zAxis:Vector3 = new Vector3();

    public function GameCamera() {
      super();
      nearClipping = 40;
      farClipping = 200000;
      z = 10000;
      rotationX = -0.01;
      diagramVerticalMargin = 35;
    }

    public function calculateAdditionalData() : void {
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local8:Number = NaN;
      var local1:Number = Math.cos(rotationX);
      var local2:Number = Math.sin(rotationX);
      var local3:Number = Math.cos(rotationY);
      local4 = Math.sin(rotationY);
      local5 = Math.cos(rotationZ);
      var local6:Number = Math.sin(rotationZ);
      var local7:Number = local5 * local4;
      local8 = local6 * local4;
      this.xAxis.x = local5 * local3;
      this.yAxis.x = local7 * local2 - local6 * local1;
      this.zAxis.x = local7 * local1 + local6 * local2;
      this.xAxis.y = local6 * local3;
      this.yAxis.y = local8 * local2 + local5 * local1;
      this.zAxis.y = local8 * local1 - local5 * local2;
      this.xAxis.z = -local4;
      this.yAxis.z = local3 * local2;
      this.zAxis.z = local3 * local1;
      this.position.x = x;
      this.position.y = y;
      this.position.z = z;
    }

    public function getGlobalVector(param1:Vector3, param2:Vector3) : void {
      m.setRotationMatrix(rotationX,rotationY,rotationZ);
      m.transformVector(param1,param2);
    }

    public function getLocalVector(param1:Vector3, param2:Vector3) : void {
      m.setRotationMatrix(rotationX,rotationY,rotationZ);
      m.transformVectorInverse(param1,param2);
    }

    public function setPosition(param1:Vector3) : void {
      x = param1.x;
      y = param1.y;
      z = param1.z;
    }

    public function setRotation(param1:Vector3) : void {
      rotationX = param1.x;
      rotationY = param1.y;
      rotationZ = param1.z;
    }

    public function setQRotation(param1:Quaternion) : void {
      param1.getEulerAngles(eulerAngles);
      this.setRotation(eulerAngles);
    }

    public function readPosition(param1:Vector3) : void {
      param1.x = x;
      param1.y = y;
      param1.z = z;
    }

    public function readRotation(param1:Vector3) : void {
      param1.x = rotationX;
      param1.y = rotationY;
      param1.z = rotationZ;
    }

    public function readQRotation(param1:Quaternion) : void {
      param1.setFromEulerAnglesXYZ(rotationX,rotationY,rotationZ);
    }

    public function updateFov() : void {
      fov = CameraFovCalculator.getCameraFov(view.width,view.height);
    }

    public function rotateBy(param1:Number, param2:Number, param3:Number) : void {
      rotationX += param1;
      rotationY += param2;
      rotationZ += param3;
    }
  }
}
