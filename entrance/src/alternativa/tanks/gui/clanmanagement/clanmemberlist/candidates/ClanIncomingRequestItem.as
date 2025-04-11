package alternativa.tanks.gui.clanmanagement.clanmemberlist.candidates {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.ClanUserItem;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.DeleteIndicator;
  import alternativa.tanks.gui.components.indicators.LabelNewIndicator;
  import alternativa.tanks.gui.components.indicators.NewCandidateIndicator;
  import alternativa.tanks.gui.icons.AcceptedIndicator;
  import alternativa.tanks.models.service.ClanNotificationsManager;
  import alternativa.tanks.models.service.ClanService;
  import alternativa.tanks.service.clan.ClanMembersListEvent;
  import alternativa.types.Long;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import forms.ColorConstants;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ClanIncomingRequestItem extends ClanUserItem {
    [Inject]
    public static var clanService:ClanService;

    [Inject]
    public static var localeService:ILocaleService;

    public var newIndicator:LabelNewIndicator;

    private var userId:Long;

    public function ClanIncomingRequestItem(param1:Long) {
      super();
      this.userId = param1;
      userContainer = createUserLabel(param1);
      addChild(userContainer);
      _deleteIndicator = new DeleteIndicator();
      addChild(_deleteIndicator);
      _deleteIndicator.visible = false;
      _acceptedIndicator = new AcceptedIndicator();
      addChild(_acceptedIndicator);
      _acceptedIndicator.visible = false;
      _deleteIndicator.addEventListener(MouseEvent.CLICK,this.onClickDelete,false,0,true);
      _acceptedIndicator.addEventListener(MouseEvent.CLICK,this.onClickAccepted,false,0,true);
      this.newIndicator = this.createNewIndicator();
      ClanNotificationsManager.addIncomingIndicatorListener(this.newIndicator);
      this.newIndicator.updateNotifications();
      addChild(this.newIndicator);
      this.onResize();
    }

    private function createNewIndicator() : NewCandidateIndicator {
      var local1:NewCandidateIndicator = new NewCandidateIndicator(this.userId);
      local1.autoSize = TextFieldAutoSize.LEFT;
      local1.align = TextFormatAlign.LEFT;
      local1.color = ColorConstants.GREEN_LABEL;
      local1.text = localeService.getText(TanksLocale.TEXT_FRIENDS_NEW);
      local1.mouseEnabled = false;
      return local1;
    }

    private function onClickAccepted(param1:MouseEvent) : void {
      dispatchEvent(new ClanMembersListEvent(ClanMembersListEvent.ACCEPTED_USER,_userLabel.userId,_userLabel.uid,true,true));
    }

    private function onClickDelete(param1:MouseEvent) : void {
      ClanNotificationsManager.removeIncomingNotification(_userLabel.userId);
      dispatchEvent(new ClanMembersListEvent(ClanMembersListEvent.REJECT_USER,_userLabel.userId,_userLabel.uid,true,true));
    }

    override protected function onResize(param1:Event = null) : void {
      userContainer.x = MARGIN;
      userContainer.y = 1;
      userContainer.width = width - 2 * MARGIN;
      _deleteIndicator.x = width - _deleteIndicator.width - 6;
      _deleteIndicator.y = 1;
      _acceptedIndicator.x = _deleteIndicator.x - _acceptedIndicator.width - 2;
      _acceptedIndicator.y = 1;
      this.newIndicator.x = width - this.newIndicator.width - 8;
      redrawBackground();
    }
  }
}
