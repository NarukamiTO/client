package alternativa.tanks.gui.components.indicators {
  import alternativa.tanks.models.service.ClanNotificationsManager;
  import alternativa.types.Long;

  public class NewCandidateIndicator extends LabelNewIndicator {
    private var userId:Long;
    private var _visible:Boolean = true;

    public function NewCandidateIndicator(param1:Long) {
      super();
      this.userId = param1;
    }

    override public function hide() : void {
      this._visible = false;
    }

    override public function show() : void {
      this._visible = true;
    }

    override public function updateNotifications() : void {
      visible = ClanNotificationsManager.userInIncomingNotifications(this.userId) && this._visible;
    }
  }
}
