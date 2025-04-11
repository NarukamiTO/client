package alternativa.osgi.service.console.variables {
  public class ConsoleVarFloat extends ConsoleVar {
    public var value:Number;

    private var minValue:Number;
    private var maxValue:Number;

    public function ConsoleVarFloat(param1:String, param2:Number, param3:Number, param4:Number, param5:Function = null) {
      super(param1,param5);
      this.value = param2;
      this.minValue = param3;
      this.maxValue = param4;
    }

    override public function acceptInput(param1:String) : String {
      var local2:Number = Number(param1);
      if(isNaN(local2)) {
        return "Incorrect number";
      }
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
