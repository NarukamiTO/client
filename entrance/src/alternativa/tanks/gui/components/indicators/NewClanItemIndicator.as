package alternativa.tanks.gui.components.indicators {
  import alternativa.tanks.models.service.ClanUserNotificationsManager;
  import alternativa.types.Long;

  public class NewClanItemIndicator extends LabelNewIndicator {
    private var clanId:Long;

    public function NewClanItemIndicator(param1:Long) {
      super();
      this.clanId = param1;
    }

    override public function updateNotifications() : void {
      visible = ClanUserNotificationsManager.clanInIncomingNotifications(this.clanId);
    }
  }
}
