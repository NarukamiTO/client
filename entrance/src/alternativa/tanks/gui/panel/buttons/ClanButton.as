package alternativa.tanks.gui.panel.buttons {
  import alternativa.tanks.service.clan.ClanPanelNotificationEvent;
  import alternativa.tanks.service.clan.ClanPanelNotificationService;
  import controls.base.MainPanelClanButtonBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.Event;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.RestrictionJoinClanEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class ClanButton extends MainPanelClanButtonBase {
    [Inject]
    public static var clanPanelNotificationService:ClanPanelNotificationService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;
    public static var attentionIconClass:Class = ClanButton_attentionIconClass;

    private static var attentionIconBitmapData:BitmapData = Bitmap(new attentionIconClass()).bitmapData;

    private var _attentionIcon:Bitmap = new Bitmap(attentionIconBitmapData);

    public function ClanButton() {
      super();
      clanPanelNotificationService.addEventListener(ClanPanelNotificationEvent.UPDATE,this.update);
      clanPanelNotificationService.addEventListener(RestrictionJoinClanEvent.UPDATE,this.update);
      this._attentionIcon.x = 72;
      this._attentionIcon.y = -4;
      addChild(this._attentionIcon);
      this.update();
      setIconCoords(8,3);
    }

    override public function set enable(param1:Boolean) : void {
      if(lobbyLayoutService.getCurrentState() == LayoutState.CLAN && !clanUserInfoService.selfClan) {
        param1 = true;
      }
      super.enable = param1;
      this.update();
    }

    public function update(param1:Event = null) : void {
      if(enable) {
        this._attentionIcon.visible = clanPanelNotificationService.numberNotification() > 0;
      } else {
        this._attentionIcon.visible = false;
      }
    }
  }
}
