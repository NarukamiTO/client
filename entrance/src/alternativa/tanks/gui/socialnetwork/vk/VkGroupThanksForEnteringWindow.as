package alternativa.tanks.gui.socialnetwork.vk {
  import alternativa.tanks.gui.socialnetwork.AbstractSNGroupEnteringWindow;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class VkGroupThanksForEnteringWindow extends AbstractSNGroupEnteringWindow {
    private static var thanksForEnteringBitmapDataClass:Class = VkGroupThanksForEnteringWindow_thanksForEnteringBitmapDataClass;

    protected static var thanksForEnteringBitmapData:BitmapData = Bitmap(new thanksForEnteringBitmapDataClass()).bitmapData;

    public function VkGroupThanksForEnteringWindow() {
      super(thanksForEnteringBitmapData,VkGroupReminderWindow.SN_GROUP_URL,localeService.getText(TanksLocale.TEXT_VK_ENTER_GROUP_BONUS));
    }
  }
}
