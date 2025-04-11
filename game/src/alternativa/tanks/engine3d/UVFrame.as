package alternativa.tanks.engine3d {
  public class UVFrame {
    public var topLeftU:Number;
    public var topLeftV:Number;
    public var bottomRightU:Number;
    public var bottomRightV:Number;

    public function UVFrame(param1:Number, param2:Number, param3:Number, param4:Number) {
      super();
      this.topLeftU = param1;
      this.topLeftV = param2;
      this.bottomRightU = param3;
      this.bottomRightV = param4;
    }
  }
}
