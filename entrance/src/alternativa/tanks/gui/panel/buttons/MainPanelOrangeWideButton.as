package alternativa.tanks.gui.panel.buttons {
  import flash.display.Bitmap;

  public class MainPanelOrangeWideButton extends MainPanelWideButton {
    private static const buttonNormal:Class = MainPanelOrangeWideButton_buttonNormal;
    private static const buttonNormalBitmap:Bitmap = new buttonNormal();
    private static const buttonOver:Class = MainPanelOrangeWideButton_buttonOver;
    private static const buttonOverBitmap:Bitmap = new buttonOver();

    public function MainPanelOrangeWideButton(param1:Bitmap, param2:int, param3:int) {
      super(param1,param2,param3,buttonOverBitmap,buttonNormalBitmap);
    }
  }
}
