package alternativa.tanks.gui.payment.controls.exchange {
  import controls.numeric.NumericEditorEvent;

  public class PresetedExchangeGroup extends ExchangeGroup {
    private var inputValues:Vector.<int>;
    private var outputValues:Vector.<Number>;
    private var bonusValues:Vector.<int>;
    private var inputValuesIndex:int;
    private var inputValuesDefaultIndex:int;

    public function PresetedExchangeGroup(param1:Vector.<int>, param2:Vector.<Number>, param3:Vector.<int>, param4:int) {
      super(true,false);
      this.inputValuesArray = param1;
      this.outputValues = param2;
      this.bonusValues = param3;
      this.inputValuesDefaultIndex = param4;
      input.setStep(1);
      input.setValue(param4);
      output.setMaxValue(0);
      output.setMaxValue(param1.length);
      this.resetValue();
    }

    override public function resetValue() : void {
      this.inputValuesIndex = this.inputValuesDefaultIndex;
      this.setIndex(this.inputValuesIndex);
    }

    public function get currentIndex() : int {
      return input.getValue();
    }

    override public function set inputValue(param1:int) : void {
    }

    override public function get inputValue() : int {
      return this.inputValues[this.inputValuesIndex];
    }

    override public function get outputValue() : Number {
      return this.outputValues[this.inputValuesIndex];
    }

    override public function set outputValue(param1:Number) : void {
    }

    public function set inputValuesArray(param1:Vector.<int>) : void {
      this.inputValues = param1;
      input.setMinValue(0);
      input.setMaxValue(this.inputValues.length - 1);
    }

    public function set outputValuesArray(param1:Vector.<Number>) : void {
      this.outputValues = param1;
    }

    public function set bonusValuesArray(param1:Vector.<int>) : void {
      this.bonusValues = param1;
    }

    public function set defaultIndex(param1:int) : void {
      this.inputValuesDefaultIndex = param1;
      this.setIndex(param1);
    }

    public function setIndex(param1:int) : void {
      input.setValue(param1,false);
      output.setValue(param1,false);
      output.tf.value = "" + this.outputValues[param1];
      input.tf.value = "" + this.inputValues[param1];
      bonus = this.bonusValues[param1];
      premiumDuration = Boolean(calculator) ? int(calculator.calculatePremiumDuration(this.outputValues[param1])) : 0;
    }

    override protected function onInputChange(param1:NumericEditorEvent) : void {
      if(param1.isChangedByUser() && param1.isValid()) {
        this.inputValuesIndex = input.intValue;
        this.setIndex(this.inputValuesIndex);
      }
    }
  }
}
