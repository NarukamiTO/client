package controls.base {
  import controls.BigButton;
  import utils.FontParamsUtil;

  public class BigButtonBase extends BigButton {
    public function BigButtonBase() {
      super();
      _label.sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
      _label.thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
      _info.sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
      _info.thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
    }
  }
}
