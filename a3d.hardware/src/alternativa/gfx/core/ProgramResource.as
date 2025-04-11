package alternativa.gfx.core {
  import alternativa.gfx.alternativagfx;
  import flash.display3D.Context3D;
  import flash.display3D.Program3D;
  import flash.utils.ByteArray;

  use namespace alternativagfx;

  public class ProgramResource extends Resource {
    alternativagfx var program:Program3D;

    private var _vertexProgram:ByteArray;
    private var _fragmentProgram:ByteArray;

    public function ProgramResource(param1:ByteArray, param2:ByteArray) {
      super();
      this._vertexProgram = param1;
      this._fragmentProgram = param2;
    }

    public function get vertexProgram() : ByteArray {
      return this._vertexProgram;
    }

    public function get fragmentProgram() : ByteArray {
      return this._fragmentProgram;
    }

    override public function dispose() : void {
      super.dispose();
      if(this.alternativagfx::program != null) {
        this.alternativagfx::program.dispose();
        this.alternativagfx::program = null;
      }
      this._vertexProgram = null;
      this._fragmentProgram = null;
    }

    override public function reset() : void {
      super.reset();
      if(this.alternativagfx::program != null) {
        this.alternativagfx::program.dispose();
        this.alternativagfx::program = null;
      }
    }

    override public function get available() : Boolean {
      return this._vertexProgram != null && this._fragmentProgram != null;
    }

    override alternativagfx function create(param1:Context3D) : void {
      super.alternativagfx::create(param1);
      this.alternativagfx::program = param1.createProgram();
    }

    override alternativagfx function upload() : void {
      super.alternativagfx::upload();
      this.alternativagfx::program.upload(this.vertexProgram,this.fragmentProgram);
    }
  }
}
