package controls.base {
  import utils.FontParamsUtil;

  public class TankDefaultButton extends TankColorButton {
    public function TankDefaultButton() {
      super();
      setStyle(DEFAULT);
      _label.sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
      _label.thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
    }
  }
}
