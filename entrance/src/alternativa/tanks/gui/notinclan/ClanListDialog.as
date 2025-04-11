package alternativa.tanks.gui.notinclan {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.notinclan.buttons.ClanUserIncomingRequestButton;
  import alternativa.tanks.gui.notinclan.dialogs.ClanDialog;
  import alternativa.tanks.gui.notinclan.dialogs.requests.UserIncomingRequestsDialog;
  import alternativa.tanks.gui.notinclan.dialogs.requests.UserOutgoingRequestsDialog;
  import alternativa.tanks.models.service.ClanUserNotificationsManager;
  import controls.base.TankDefaultButton;
  import flash.events.MouseEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ClanListDialog extends ClanDialog {
    [Inject]
    public static var localeService:ILocaleService;

    public static const WIDTH:Number = 900;
    public static const HEIGHT:Number = 500;

    private var _incomingListButton:ClanUserIncomingRequestButton = new ClanUserIncomingRequestButton();
    private var _outgoingListButton:TankDefaultButton = new TankDefaultButton();
    private var _incomingPanel:UserIncomingRequestsDialog;
    private var _outgoingPanel:UserOutgoingRequestsDialog;

    public function ClanListDialog() {
      super();
      this._incomingListButton.width = 120;
      this._incomingListButton.x = WIDTH - this._incomingListButton.width - MARGIN;
      this._incomingListButton.y = MARGIN;
      this._incomingListButton.label = localeService.getText(TanksLocale.TEXT_CLAN_INCOMING);
      this._incomingListButton.addEventListener(MouseEvent.CLICK,this.onShowIncomingList);
      addChild(this._incomingListButton);
      this._outgoingListButton.width = 120;
      this._outgoingListButton.x = this._incomingListButton.x - this._outgoingListButton.width - MARGIN;
      this._outgoingListButton.y = MARGIN;
      this._outgoingListButton.label = localeService.getText(TanksLocale.TEXT_CLAN_OUTGOUNG);
      this._outgoingListButton.addEventListener(MouseEvent.CLICK,this.onShowOutgoingList);
      addChild(this._outgoingListButton);
      if(ClanUserNotificationsManager.getIncomingNotificationsCount() > 0) {
        this.onShowIncomingList();
      } else {
        this.onShowOutgoingList();
      }
    }

    private function onShowOutgoingList(param1:MouseEvent = null) : void {
      this.destroyIncomingList();
      this._outgoingPanel = new UserOutgoingRequestsDialog(closeButton.width);
      this._outgoingPanel.x = 0;
      this._outgoingPanel.y = this._incomingListButton.y + this._incomingListButton.height + 3 * MARGIN;
      this._outgoingPanel.width = WIDTH;
      this._outgoingPanel.height = HEIGHT - this._outgoingListButton.y - this._outgoingListButton.height - 3 * MARGIN;
      addChild(this._outgoingPanel);
      this._outgoingListButton.enable = false;
      this._incomingListButton.enable = true;
    }

    private function onShowIncomingList(param1:MouseEvent = null) : void {
      this.destroyOutgoingList();
      this._incomingPanel = new UserIncomingRequestsDialog(closeButton.width);
      this._incomingPanel.x = 0;
      this._incomingPanel.y = this._incomingListButton.y + this._incomingListButton.height + 3 * MARGIN;
      this._incomingPanel.width = WIDTH;
      this._incomingPanel.height = HEIGHT - this._outgoingListButton.y - this._outgoingListButton.height - 3 * MARGIN;
      addChild(this._incomingPanel);
      this._outgoingListButton.enable = true;
      this._incomingListButton.enable = false;
    }

    override public function destroy() : void {
      this._incomingListButton.removeEventListener(MouseEvent.CLICK,this.onShowIncomingList);
      this._outgoingListButton.removeEventListener(MouseEvent.CLICK,this.onShowOutgoingList);
      this.destroyIncomingList();
      this.destroyOutgoingList();
      this._incomingListButton.destroy();
      super.destroy();
    }

    private function destroyOutgoingList() : void {
      if(this._outgoingPanel != null) {
        if(contains(this._outgoingPanel)) {
          removeChild(this._outgoingPanel);
        }
        this._outgoingPanel.destroy();
        this._outgoingPanel = null;
      }
    }

    private function destroyIncomingList() : void {
      if(this._incomingPanel != null) {
        if(contains(this._incomingPanel)) {
          removeChild(this._incomingPanel);
        }
        this._incomingPanel.destroy();
        this._incomingPanel = null;
      }
    }

    override public function get height() : Number {
      return HEIGHT;
    }

    override public function get width() : Number {
      return WIDTH;
    }

    override protected function getImageHeaderId() : String {
      return TanksLocale.TEXT_HEADER_CLAN_MANAGMENT;
    }
  }
}
