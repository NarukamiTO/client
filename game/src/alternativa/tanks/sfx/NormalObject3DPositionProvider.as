package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class NormalObject3DPositionProvider extends PooledObject implements Object3DPositionProvider {
    private var normal:Vector3 = new Vector3();
    private var position:Vector3 = new Vector3();
    private var distance:Number;
    private var computedPosition:Vector3 = new Vector3();

    public function NormalObject3DPositionProvider(param1:Pool) {
      super(param1);
    }

    public function init(param1:Vector3, param2:Vector3, param3:Number) : void {
      this.position.copy(param1);
      this.normal.copy(param2);
      this.distance = param3;
      this.normal.normalize();
      this.compute();
    }

    private function compute() : void {
      this.computedPosition.copy(this.normal);
      this.computedPosition.scale(this.distance);
      this.computedPosition.add(this.position);
    }

    public function initPosition(param1:Object3D) : void {
      param1.x = this.computedPosition.x;
      param1.y = this.computedPosition.y;
      param1.z = this.computedPosition.z;
    }

    public function updateObjectPosition(param1:Object3D, param2:GameCamera, param3:int) : void {
      this.initPosition(param1);
    }

    public function destroy() : void {
      recycle();
    }
  }
}
