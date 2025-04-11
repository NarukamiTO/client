package alternativa.tanks.battle {
  public class Color {
    public var r:int;
    public var g:int;
    public var b:int;

    public function Color(param1:int) {
      super();
      this.setColor(param1);
    }

    private static function clamp(param1:int) : int {
      return param1 < 0 ? 0 : param1;
    }

    private static function lastByte(param1:int) : int {
      return param1 & 0xFF;
    }

    public function setColor(param1:int) : void {
      this.r = lastByte(param1 >> 16);
      this.g = lastByte(param1 >> 8);
      this.b = lastByte(param1);
    }

    public function getColor() : int {
      return this.r << 16 | this.g << 8 | this.b;
    }

    public function subtract(param1:Color) : void {
      this.r = clamp(this.r - param1.r);
      this.g = clamp(this.g - param1.g);
      this.b = clamp(this.b - param1.b);
    }
  }
}
