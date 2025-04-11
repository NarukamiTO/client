package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class MuzzlePositionProvider extends PooledObject implements Object3DPositionProvider {
    private static const turretMatrix:Matrix4 = new Matrix4();
    private static const globalPosition:Vector3 = new Vector3();

    private var turret:Object3D;
    private var localPosition:Vector3 = new Vector3();

    public function MuzzlePositionProvider(param1:Pool) {
      super(param1);
    }

    public function init(param1:Object3D, param2:Vector3, param3:Number = 0) : void {
      this.turret = param1;
      this.localPosition.copy(param2);
      this.localPosition.y += param3;
    }

    public function initPosition(param1:Object3D) : void {
    }

    public function updateObjectPosition(param1:Object3D, param2:GameCamera, param3:int) : void {
      turretMatrix.setMatrix(this.turret.x,this.turret.y,this.turret.z,this.turret.rotationX,this.turret.rotationY,this.turret.rotationZ);
      turretMatrix.transformVector(this.localPosition,globalPosition);
      param1.x = globalPosition.x;
      param1.y = globalPosition.y;
      param1.z = globalPosition.z;
    }

    public function destroy() : void {
      this.turret = null;
      recycle();
    }
  }
}
