package projects.tanks.client.battlefield.models.tankparts.sfx.colortransform {
  import projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.struct.ColorTransformStruct;

  public class ColorTransformCC {
    private var _colorTransforms:Vector.<ColorTransformStruct>;

    public function ColorTransformCC(param1:Vector.<ColorTransformStruct> = null) {
      super();
      this._colorTransforms = param1;
    }

    public function get colorTransforms() : Vector.<ColorTransformStruct> {
      return this._colorTransforms;
    }

    public function set colorTransforms(param1:Vector.<ColorTransformStruct>) : void {
      this._colorTransforms = param1;
    }

    public function toString() : String {
      var local1:String = "ColorTransformCC [";
      local1 += "colorTransforms = " + this.colorTransforms + " ";
      return local1 + "]";
    }
  }
}
