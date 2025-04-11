package alternativa.gfx.agal {
  public class SamplerOption {
    public var mask:uint;
    public var flag:uint;

    public function SamplerOption(param1:uint, param2:uint) {
      super();
      this.mask = param1;
      this.flag = param2;
    }

    public function apply(param1:int) : int {
      param1 &= ~(15 << this.flag);
      return param1 | this.mask << this.flag;
    }
  }
}
