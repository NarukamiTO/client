package controls.base {
  import controls.ColorButton;
  import utils.FontParamsUtil;

  public class ColorButtonBase extends ColorButton {
    public function ColorButtonBase() {
      super();
    }

    override public function configUI() : void {
      super.configUI();
      _label.sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
      _label.thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
    }
  }
}
