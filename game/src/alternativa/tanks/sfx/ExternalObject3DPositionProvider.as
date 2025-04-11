package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class ExternalObject3DPositionProvider extends PooledObject implements Object3DPositionProvider {
    private var position:Vector3 = new Vector3();

    public function ExternalObject3DPositionProvider(param1:Pool) {
      super(param1);
    }

    public function setPosition(param1:Vector3) : void {
      this.position.copy(param1);
    }

    public function initPosition(param1:Object3D) : void {
      param1.x = this.position.x;
      param1.y = this.position.y;
      param1.z = this.position.z;
    }

    public function updateObjectPosition(param1:Object3D, param2:GameCamera, param3:int) : void {
      this.initPosition(param1);
    }

    public function destroy() : void {
      recycle();
    }
  }
}
