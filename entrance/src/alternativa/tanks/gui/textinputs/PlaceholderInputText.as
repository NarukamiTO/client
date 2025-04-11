package alternativa.tanks.gui.textinputs {
  import controls.base.TankInput;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import forms.ColorConstants;

  public class PlaceholderInputText extends TankInput {
    private var placeholderText:String;

    private const placeholderColor:uint = 8421504;

    public function PlaceholderInputText(param1:String) {
      super();
      this.placeholderText = param1;
      value = param1;
      textField.textColor = this.placeholderColor;
      textField.displayAsPassword = false;
      addEventListener(FocusEvent.FOCUS_IN,this.focusIn);
      addEventListener(FocusEvent.FOCUS_OUT,this.focusOut);
    }

    public function focusIn(param1:Event) : void {
      if(value == this.placeholderText) {
        textField.textColor = ColorConstants.WHITE;
        value = "";
        textField.displayAsPassword = this.hidden;
      }
    }

    public function focusOut(param1:Event) : void {
      if(value == "") {
        textField.textColor = this.placeholderColor;
        value = this.placeholderText;
        textField.displayAsPassword = false;
      }
    }

    public function setValue(param1:String) : void {
      this.value = param1;
      textField.textColor = ColorConstants.WHITE;
    }

    override public function set hidden(param1:Boolean) : void {
      super.hidden = param1;
      textField.displayAsPassword = false;
    }
  }
}
