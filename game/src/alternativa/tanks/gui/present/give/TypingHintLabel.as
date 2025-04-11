package alternativa.tanks.gui.present.give {
  import controls.base.LabelBase;
  import flash.events.FocusEvent;
  import flash.text.TextField;
  import forms.ColorConstants;

  public class TypingHintLabel extends LabelBase {
    private var input:TextField;

    public function TypingHintLabel(param1:TextField) {
      super();
      this.input = param1;
      param1.addEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
      param1.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
      mouseEnabled = false;
      color = ColorConstants.LIST_LABEL_HINT;
    }

    private function onFocusIn(param1:FocusEvent) : void {
      visible = false;
    }

    private function onFocusOut(param1:FocusEvent) : void {
      if(this.input.text.length == 0) {
        visible = true;
      }
    }
  }
}
