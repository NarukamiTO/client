package alternativa.gfx.agal {
  public class RelativeRegister extends CommonRegister {
    public function RelativeRegister(param1:int, param2:int) {
      super(param1,param2);
    }

    public function rel(param1:Register, param2:uint) : CommonRegister {
      relate(param1,param2);
      return this;
    }
  }
}
