package controls.checkbox {
  public class MultilineCheckBox extends CheckBoxBase {
    public function MultilineCheckBox() {
      super();
      labelInfo.y = 0;
      labelInfo.wordWrap = true;
      labelInfo.multiline = true;
    }

    public function set labelWidth(param1:int) : void {
      labelInfo.width = param1;
    }
  }
}
