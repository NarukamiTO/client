package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class MovingObject3DPositionProvider extends PooledObject implements Object3DPositionProvider {
    private var initialPosition:Vector3 = new Vector3();
    private var velocity:Vector3 = new Vector3();
    private var acceleration:Number;

    public function MovingObject3DPositionProvider(param1:Pool) {
      super(param1);
    }

    public function initPosition(param1:Object3D) : void {
      param1.x = this.initialPosition.x;
      param1.y = this.initialPosition.y;
      param1.z = this.initialPosition.z;
    }

    public function init(param1:Vector3, param2:Vector3, param3:Number) : void {
      this.initialPosition.copy(param1);
      this.velocity.copy(param2);
      this.acceleration = param3;
    }

    public function updateObjectPosition(param1:Object3D, param2:GameCamera, param3:int) : void {
      var local4:Number = 0.001 * param3;
      param1.x += this.velocity.x * local4;
      param1.y += this.velocity.y * local4;
      param1.z += this.velocity.z * local4;
      var local5:Number = this.velocity.length();
      local5 += this.acceleration * local4;
      if(local5 <= 0) {
        this.velocity.reset();
      } else {
        this.velocity.normalize();
        this.velocity.scale(local5);
      }
    }

    public function destroy() : void {
      recycle();
    }
  }
}
