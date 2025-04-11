package controls.base {
  import controls.DefaultButton;
  import utils.FontParamsUtil;

  public class DefaultButtonBase extends DefaultButton {
    public function DefaultButtonBase() {
      super();
      _label.sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
      _label.thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
    }
  }
}
