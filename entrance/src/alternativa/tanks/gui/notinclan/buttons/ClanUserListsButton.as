package alternativa.tanks.gui.notinclan.buttons {
  import alternativa.tanks.gui.IClanNotificationListener;
  import alternativa.tanks.models.service.ClanUserNotificationsManager;
  import controls.base.ThreeLineBigButton;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class ClanUserListsButton extends ThreeLineBigButton implements IClanNotificationListener {
    public static var attentionIconClass:Class = ClanUserListsButton_attentionIconClass;

    private static var attentionIconBitmapData:BitmapData = Bitmap(new attentionIconClass()).bitmapData;

    private var _attentionIcon:Bitmap = new Bitmap(attentionIconBitmapData);

    public function ClanUserListsButton() {
      super();
      addChild(this._attentionIcon);
      this._attentionIcon.y = -6;
      ClanUserNotificationsManager.addIncomingIndicatorListener(this);
    }

    override public function set width(param1:Number) : void {
      super.width = param1;
      this._attentionIcon.x = width - this._attentionIcon.width / 2;
    }

    public function updateNotifications() : void {
      this._attentionIcon.visible = ClanUserNotificationsManager.getIncomingNotificationsCount() > 0;
    }

    public function destroy() : void {
      ClanUserNotificationsManager.removeIncomingIndicatorListener(this);
    }
  }
}
