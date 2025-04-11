package alternativa.tanks.gui.components.button {
  import alternativa.tanks.gui.IClanNotificationListener;
  import alternativa.tanks.gui.clanmanagement.ClanUsersWindow;
  import alternativa.tanks.models.service.ClanNotificationsManager;
  import projects.tanks.client.clans.clan.permissions.ClanAction;

  public class ClanIncomingRequestsButton extends ClanButtonActionListener implements IClanNotificationListener {
    private static const MARGIN:int = 11;
    private static const FRAME:int = 7;

    private var outgoingButton:ClanButtonActionListener;
    private var usersWindow:ClanUsersWindow;
    private var requestCountIndicator:RequestCountIndicator = new RequestCountIndicator();

    public function ClanIncomingRequestsButton(param1:ClanButtonActionListener, param2:ClanUsersWindow) {
      super(ClanAction.ADDING_TO_CLAN);
      this.outgoingButton = param1;
      this.usersWindow = param2;
      addChild(this.requestCountIndicator);
      this.requestCountIndicator.y = -6;
    }

    override public function set width(param1:Number) : void {
      super.width = param1;
      this.requestCountIndicator.x = width + 3;
    }

    override public function updateActions() : void {
      super.updateActions();
      this.outgoingButton.x = (visible ? x : this.usersWindow.width - MARGIN) - FRAME - this.outgoingButton.width;
    }

    public function updateNotifications() : void {
      var local1:int = ClanNotificationsManager.incomingNotificationsCount();
      this.requestCountIndicator.count = local1;
    }
  }
}
