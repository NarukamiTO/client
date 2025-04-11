package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class ScalingObject3DPositionProvider extends PooledObject implements Object3DPositionProvider {
    private var initialPosition:Vector3 = new Vector3();
    private var velocity:Vector3 = new Vector3();
    private var scaleVelocity:Number;

    public function ScalingObject3DPositionProvider(param1:Pool) {
      super(param1);
    }

    public function initPosition(param1:Object3D) : void {
      param1.x = this.initialPosition.x;
      param1.y = this.initialPosition.y;
      param1.z = this.initialPosition.z;
      param1.scaleX = 1;
      param1.scaleY = 1;
      param1.scaleZ = 1;
    }

    public function init(param1:Vector3, param2:Vector3, param3:Number) : void {
      this.initialPosition.copy(param1);
      this.velocity.copy(param2);
      this.scaleVelocity = param3;
    }

    public function updateObjectPosition(param1:Object3D, param2:GameCamera, param3:int) : void {
      var local4:Number = 0.001 * param3;
      param1.x += this.velocity.x * local4;
      param1.y += this.velocity.y * local4;
      param1.z += this.velocity.z * local4;
      param1.scaleX += this.scaleVelocity;
      param1.scaleY += this.scaleVelocity;
      param1.scaleZ += this.scaleVelocity;
    }

    public function destroy() : void {
      recycle();
    }
  }
}
