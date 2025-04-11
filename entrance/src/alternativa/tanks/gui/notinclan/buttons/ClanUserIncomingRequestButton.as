package alternativa.tanks.gui.notinclan.buttons {
  import alternativa.tanks.gui.IClanNotificationListener;
  import alternativa.tanks.gui.components.button.RequestCountIndicator;
  import alternativa.tanks.models.service.ClanUserNotificationsManager;
  import controls.base.TankDefaultButton;

  public class ClanUserIncomingRequestButton extends TankDefaultButton implements IClanNotificationListener {
    private var requestCountIndicator:RequestCountIndicator = new RequestCountIndicator();

    public function ClanUserIncomingRequestButton() {
      super();
      ClanUserNotificationsManager.addIncomingIndicatorListener(this);
      addChild(this.requestCountIndicator);
      this.requestCountIndicator.y = -6;
    }

    override public function set width(param1:Number) : void {
      super.width = param1;
      this.requestCountIndicator.x = width + 3;
    }

    override public function set enable(param1:Boolean) : void {
      super.enable = param1;
      this.requestCountIndicator.visible = param1 && ClanUserNotificationsManager.getIncomingNotificationsCount() > 0;
    }

    public function updateNotifications() : void {
      var local1:int = ClanUserNotificationsManager.getIncomingNotificationsCount();
      this.requestCountIndicator.count = local1;
    }

    public function destroy() : void {
      ClanUserNotificationsManager.removeIncomingIndicatorListener(this);
    }
  }
}
