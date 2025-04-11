package alternativa.tanks.gui.socialnetwork.vk {
  import alternativa.tanks.gui.socialnetwork.AbstractSNGroupEnteringWindow;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class VkGroupReminderWindow extends AbstractSNGroupEnteringWindow {
    public static const SN_GROUP_URL:String = "https://vk.com/tankionline";

    private static var VkGroupEnteringReminderBitmapDataClass:Class = VkGroupReminderWindow_VkGroupEnteringReminderBitmapDataClass;
    private static var VkGroupEnteringReminderBitmapData:BitmapData = Bitmap(new VkGroupEnteringReminderBitmapDataClass()).bitmapData;

    public function VkGroupReminderWindow() {
      super(VkGroupEnteringReminderBitmapData,SN_GROUP_URL,localeService.getText(TanksLocale.TEXT_VK_ENTER_GROUP_REMINDER));
    }
  }
}
