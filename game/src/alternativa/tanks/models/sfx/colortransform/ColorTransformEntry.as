package alternativa.tanks.models.sfx.colortransform {
  import projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.struct.ColorTransformStruct;

  public class ColorTransformEntry {
    public var t:Number;
    public var redMultiplier:Number;
    public var greenMultiplier:Number;
    public var blueMultiplier:Number;
    public var alphaMultiplier:Number;
    public var redOffset:int;
    public var greenOffset:int;
    public var blueOffset:int;
    public var alphaOffset:int;

    public function ColorTransformEntry(param1:ColorTransformStruct) {
      super();
      this.t = param1.t;
      this.redMultiplier = param1.redMultiplier;
      this.greenMultiplier = param1.greenMultiplier;
      this.blueMultiplier = param1.blueMultiplier;
      this.alphaMultiplier = param1.alphaMultiplier;
      this.redOffset = param1.redOffset;
      this.greenOffset = param1.greenOffset;
      this.blueOffset = param1.blueOffset;
      this.alphaOffset = param1.alphaOffset;
    }
  }
}
