package alternativa.proplib.objects {
  import alternativa.engine3d.core.Object3D;

  public class PropObject {
    public var object:Object3D;

    private var _type:int;

    public function PropObject(type:int) {
      super();
      this._type = type;
    }

    public function get type() : int {
      return this._type;
    }

    public function traceProp() : void {
      trace(this.object);
    }
  }
}
