package alternativa.tanks.gui.components.indicators {
  import alternativa.tanks.models.service.ClanNotificationsManager;
  import alternativa.types.Long;

  public class NewClanMemberIndicator extends LabelNewIndicator {
    private var userId:Long;
    private var data:Object;

    public function NewClanMemberIndicator(param1:Long, param2:Object) {
      super();
      this.userId = param1;
      this.data = param2;
    }

    override public function updateNotifications() : void {
      visible = ClanNotificationsManager.userInAcceptedNotifications(this.userId) || this.isNew;
      if(visible && Boolean(stage)) {
        ClanNotificationsManager.removeAcceptedNotification(this.userId);
        this.isNew = true;
      }
    }

    public function get isNew() : Boolean {
      return this.data.isNew;
    }

    public function set isNew(param1:Boolean) : void {
      this.data.isNew = param1;
      visible = param1;
    }
  }
}
