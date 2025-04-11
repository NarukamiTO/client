package alternativa.tanks.gui.panel.buttons {
  import flash.display.Bitmap;

  public class MainPanelGrayWideButton extends MainPanelWideButton {
    private static const buttonNormal:Class = MainPanelGrayWideButton_buttonNormal;
    private static const buttonNormalBitmap:Bitmap = new buttonNormal();
    private static const buttonOver:Class = MainPanelGrayWideButton_buttonOver;
    private static const buttonOverBitmap:Bitmap = new buttonOver();

    public function MainPanelGrayWideButton(param1:Bitmap, param2:int, param3:int) {
      super(param1,param2,param3,buttonOverBitmap,buttonNormalBitmap);
    }
  }
}
