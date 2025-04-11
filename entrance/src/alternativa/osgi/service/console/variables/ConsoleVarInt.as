package alternativa.osgi.service.console.variables {
  public class ConsoleVarInt extends ConsoleVar {
    public var value:int;

    private var minValue:int;
    private var maxValue:int;

    public function ConsoleVarInt(param1:String, param2:int, param3:int, param4:int, param5:Function = null) {
      super(param1,param5);
      this.value = param2;
      this.minValue = param3;
      this.maxValue = param4;
    }

    override public function acceptInput(param1:String) : String {
      var local2:int = int(param1);
      if(local2 < this.minValue || local2 > this.maxValue) {
        return "Value is out of bounds [" + this.minValue + ", " + this.maxValue + "]";
      }
      this.value = local2;
      if(inputListener != null) {
        inputListener(this.value);
      }
      return null;
    }

    override public function toString() : String {
      return this.value.toString();
    }
  }
}
