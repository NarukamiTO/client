package controls.numeric {
  public interface INumericStepper {
    function getValue() : Number;
    function setValue(param1:Number, param2:Boolean = false) : void;
    function getButtonStatus() : int;
  }
}
