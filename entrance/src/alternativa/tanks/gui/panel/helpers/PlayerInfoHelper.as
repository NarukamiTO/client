package alternativa.tanks.gui.panel.helpers {
  import controls.Label;
  import utils.FontParamsUtil;

  public class PlayerInfoHelper {
    public function PlayerInfoHelper() {
      super();
    }

    public static function setDefaultSharpnessAndThickness(param1:Label) : void {
      param1.sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
      param1.thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
    }
  }
}
