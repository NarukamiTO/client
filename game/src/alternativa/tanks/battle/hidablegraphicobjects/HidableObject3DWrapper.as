package alternativa.tanks.battle.hidablegraphicobjects {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;

  public class HidableObject3DWrapper implements HidableGraphicObject {
    private var object:Object3D;

    public function HidableObject3DWrapper(param1:Object3D) {
      super();
      this.object = param1;
    }

    public function readPosition(param1:Vector3) : void {
      param1.x = this.object.x;
      param1.y = this.object.y;
      param1.z = this.object.z;
    }

    public function setAlphaMultiplier(param1:Number) : void {
      this.object.alpha = param1;
    }
  }
}
