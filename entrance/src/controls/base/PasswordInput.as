package controls.base {
  import flash.utils.setTimeout;
  import forms.ColorConstants;

  public class PasswordInput extends TankInputBase {
    public function PasswordInput() {
      super();
    }

    override public function set enable(param1:Boolean) : void {
      super.enable = param1;
      setTimeout(this.setTextColor,0);
    }

    private function setTextColor() : void {
      textField.textColor = textField.selectable ? ColorConstants.WHITE : ColorConstants.INPUT_DISABLED;
    }
  }
}
