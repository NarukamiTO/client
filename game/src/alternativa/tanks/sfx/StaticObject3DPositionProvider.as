package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class StaticObject3DPositionProvider extends PooledObject implements Object3DPositionProvider {
    private static const toCamera:Vector3 = new Vector3();

    private var position:Vector3 = new Vector3();
    private var offsetToCamera:Number;

    public function StaticObject3DPositionProvider(param1:Pool) {
      super(param1);
    }

    public function init(param1:Vector3, param2:Number) : void {
      this.position.copy(param1);
      this.offsetToCamera = param2;
    }

    public function initPosition(param1:Object3D) : void {
    }

    public function updateObjectPosition(param1:Object3D, param2:GameCamera, param3:int) : void {
      toCamera.x = param2.x - this.position.x;
      toCamera.y = param2.y - this.position.y;
      toCamera.z = param2.z - this.position.z;
      toCamera.normalize();
      param1.x = this.position.x + this.offsetToCamera * toCamera.x;
      param1.y = this.position.y + this.offsetToCamera * toCamera.y;
      param1.z = this.position.z + this.offsetToCamera * toCamera.z;
    }

    public function destroy() : void {
      recycle();
    }
  }
}
