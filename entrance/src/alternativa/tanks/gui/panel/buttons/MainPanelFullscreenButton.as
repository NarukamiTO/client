package alternativa.tanks.gui.panel.buttons {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class MainPanelFullscreenButton extends MainPanelSmallButton {
    private static const activateFullscreenClass:Class = MainPanelFullscreenButton_activateFullscreenClass;
    private static const activateFullscreen:BitmapData = Bitmap(new activateFullscreenClass()).bitmapData;
    private static const deactivateFullscreenClass:Class = MainPanelFullscreenButton_deactivateFullscreenClass;
    private static const deactivateFullscreen:BitmapData = Bitmap(new deactivateFullscreenClass()).bitmapData;

    public function MainPanelFullscreenButton() {
      super(activateFullscreen,3,4);
    }

    public function set isActivateFullscreen(param1:Boolean) : void {
      _icon.bitmapData = param1 ? activateFullscreen : deactivateFullscreen;
    }

    public function hide() : void {
      width = 0;
      enable = false;
    }
  }
}
