package alternativa.tanks.gui.socialnetwork.ok {
  import alternativa.tanks.gui.socialnetwork.AbstractSNGroupEnteringWindow;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class OkGroupReminderWindow extends AbstractSNGroupEnteringWindow {
    public static var OK_GROUP_RUL:String = "https://ok.ru/group/53061641699507";

    private static var OkGroupEnteringReminderBitmapDataClass:Class = OkGroupReminderWindow_OkGroupEnteringReminderBitmapDataClass;
    private static var okGroupEnteringReminderBitmapData:BitmapData = Bitmap(new OkGroupEnteringReminderBitmapDataClass()).bitmapData;

    public function OkGroupReminderWindow() {
      super(okGroupEnteringReminderBitmapData,OK_GROUP_RUL,localeService.getText(TanksLocale.TEXT_OK_ENTER_GROUP_REMINDER));
    }
  }
}
