package alternativa.tanks.gui.socialnetwork.ok {
  import alternativa.tanks.gui.socialnetwork.AbstractSNGroupEnteringWindow;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class OkGroupThanksForEnteringWindow extends AbstractSNGroupEnteringWindow {
    private static var thanksForEnteringBitmapDataClass:Class = OkGroupThanksForEnteringWindow_thanksForEnteringBitmapDataClass;

    protected static var thanksForEnteringBitmapData:BitmapData = Bitmap(new thanksForEnteringBitmapDataClass()).bitmapData;

    public function OkGroupThanksForEnteringWindow() {
      super(thanksForEnteringBitmapData,OkGroupReminderWindow.OK_GROUP_RUL,localeService.getText(TanksLocale.TEXT_OK_ENTER_GROUP_BONUS));
    }
  }
}
