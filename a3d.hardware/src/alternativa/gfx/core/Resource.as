package alternativa.gfx.core {
  import alternativa.gfx.alternativagfx;
  import flash.display3D.Context3D;

  use namespace alternativagfx;

  public class Resource {
    public var context:Context3D = null;

    public function Resource() {
      super();
    }

    public function dispose() : void {
      this.context = null;
    }

    public function reset() : void {
      this.context = null;
    }

    public function get available() : Boolean {
      return false;
    }

    alternativagfx function create(param1:Context3D) : void {
      this.context = param1;
    }

    alternativagfx function upload() : void {
    }

    public function isCreated(param1:Context3D) : Boolean {
      return this.context != null && this.context == param1;
    }
  }
}
