package alternativa.tanks.gui.clanmanagement {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.members.ClanMembersList;
  import alternativa.tanks.gui.components.button.ClanButtonActionListener;
  import alternativa.tanks.gui.components.button.ClanIncomingRequestsButton;
  import alternativa.tanks.models.clan.ClanModel;
  import alternativa.tanks.models.clan.accepted.IClanAcceptedModel;
  import alternativa.tanks.models.clan.membersdata.ClanMembersDataService;
  import alternativa.tanks.models.service.ClanNotificationsManager;
  import alternativa.tanks.models.service.ClanService;
  import alternativa.tanks.service.clan.ClanMembersListEvent;
  import alternativa.types.Long;
  import base.DiscreteSprite;
  import controls.TankWindow;
  import controls.windowinner.WindowInner;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanFunctionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;

  public class ClanUsersWindow extends DiscreteSprite {
    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var clanService:ClanService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var clanFunctionsService:ClanFunctionsService;

    [Inject]
    public static var clanMembersData:ClanMembersDataService;

    private static var currentUserId:Long;
    private static var userIdToExclude:Long;

    private static const MARGIN:int = 11;
    private static const FRAME:int = 7;
    private static const BUTTON_HEIGHT:int = 30;

    private var usersInner:WindowInner;
    private var usersWindow:TankWindow;
    private var list:ClanMembersList;
    private var outgoingButton:ClanButtonActionListener;
    private var incomingButton:ClanIncomingRequestsButton;
    private var _width:int;
    private var _height:int;
    private var clanObject:IGameObject;

    public function ClanUsersWindow(param1:IGameObject) {
      var local4:Long = null;
      super();
      this.clanObject = param1;
      this.usersWindow = new TankWindow();
      addChild(this.usersWindow);
      this.usersInner = new WindowInner(this._width,this._height,WindowInner.GREEN);
      this.usersInner.showBlink = true;
      this.usersWindow.addChild(this.usersInner);
      var local2:IClanAcceptedModel = IClanAcceptedModel(param1.adapt(IClanAcceptedModel));
      this.list = new ClanMembersList();
      var local3:Vector.<Object> = new Vector.<Object>();
      for each(local4 in local2.getAcceptedUsers()) {
        local3.push(clanMembersData.getClanMemberData(local4));
      }
      this.list.fillData(local3);
      this.list.addEventListener(ClanMembersListEvent.REMOVE_USER,this.onRemoveUser);
      this.usersInner.addChild(this.list);
      this.outgoingButton = new ClanButtonActionListener(ClanAction.INVITE_TO_CLAN);
      this.incomingButton = new ClanIncomingRequestsButton(this.outgoingButton,this);
      this.outgoingButton.width = 120;
      this.incomingButton.width = 120;
      ClanActionsManager.addActionsUpdateListener(this.outgoingButton);
      this.outgoingButton.label = localeService.getText(TanksLocale.TEXT_CLAN_INVITE);
      this.outgoingButton.updateActions();
      this.outgoingButton.addEventListener(MouseEvent.CLICK,this.onClickOutgoingButton);
      addChild(this.outgoingButton);
      ClanActionsManager.addActionsUpdateListener(this.incomingButton);
      ClanNotificationsManager.addIncomingIndicatorListener(this.incomingButton);
      this.incomingButton.label = localeService.getText(TanksLocale.TEXT_CLAN_INCOMING);
      this.incomingButton.updateActions();
      this.incomingButton.updateNotifications();
      this.incomingButton.addEventListener(MouseEvent.CLICK,this.onClickIncomingButton);
      addChild(this.incomingButton);
      addEventListener(Event.ADDED_TO_STAGE,this.onAddResizeListener);
    }

    private static function getCurrentUserId() : Long {
      if(currentUserId == null) {
        currentUserId = userInfoService.getCurrentUserId();
      }
      return currentUserId;
    }

    private function onClickIncomingButton(param1:MouseEvent) : void {
      new ClanIncomingRequestsDialog(this.clanObject);
    }

    private function onClickOutgoingButton(param1:MouseEvent) : void {
      new ClanOutgoingRequestsDialog(this.clanObject);
    }

    private function onRemoveUser(param1:ClanMembersListEvent) : void {
      if(param1.userId == getCurrentUserId()) {
        alertService.showAlert(localeService.getText(TanksLocale.TEXT_CLAN_ALERT_LEAVE_CLAN),Vector.<String>([localeService.getText(TanksLocale.TEXT_FRIENDS_YES),localeService.getText(TanksLocale.TEXT_FRIENDS_CANCEL_BUTTON_TEXT)]));
        alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onClanLeavingConfirm);
      } else {
        alertService.showAlert(localeService.getText(TanksLocale.TEXT_CLAN_ALERT_REMOVE_PLAYER).replace(ClanModel.USER_NAME_PATTERN,param1.userUid),Vector.<String>([localeService.getText(TanksLocale.TEXT_FRIENDS_YES),localeService.getText(TanksLocale.TEXT_FRIENDS_CANCEL_BUTTON_TEXT)]));
        alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onExpelConfirm);
        userIdToExclude = param1.userId;
      }
    }

    private function onClanLeavingConfirm(param1:AlertServiceEvent) : void {
      alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onClanLeavingConfirm);
      if(param1.typeButton == localeService.getText(TanksLocale.TEXT_FRIENDS_YES)) {
        clanFunctionsService.leave();
      }
    }

    private function onExpelConfirm(param1:AlertServiceEvent) : void {
      alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onExpelConfirm);
      if(param1.typeButton == localeService.getText(TanksLocale.TEXT_FRIENDS_YES) && userIdToExclude != null) {
        clanFunctionsService.exclude(userIdToExclude);
        userIdToExclude = null;
      }
    }

    private function onAddResizeListener(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.onAddResizeListener);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      stage.addEventListener(Event.RESIZE,this.onResize);
      this.onResize();
    }

    private function onRemoveFromStage(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.onRemoveFromStage);
      stage.removeEventListener(Event.RESIZE,this.onResize);
      addEventListener(Event.ADDED_TO_STAGE,this.onAddResizeListener);
    }

    private function onResize(param1:Event = null) : void {
      this.usersWindow.y = ClanTopManagementPanel.HEIGHT + MARGIN - 3;
      this.usersWindow.width = this.width;
      this.usersWindow.height = this.height - this.usersWindow.y;
      this.usersInner.x = MARGIN;
      this.usersInner.y = MARGIN;
      this.usersInner.width = this.usersWindow.width - 2 * MARGIN;
      this.usersInner.height = this.usersWindow.height - 2 * MARGIN - FRAME - BUTTON_HEIGHT;
      this.list.x = 3;
      this.list.y = 3;
      this.list.width = this.usersInner.width - 6;
      this.list.height = this.usersInner.height - 4;
      this.incomingButton.x = this.width - this.incomingButton.width - MARGIN;
      this.incomingButton.y = this.height - this.outgoingButton.height - MARGIN - 1;
      this.outgoingButton.x = (this.incomingButton.visible ? this.incomingButton.x : this.width - MARGIN) - FRAME - this.outgoingButton.width;
      this.outgoingButton.y = this.incomingButton.y;
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this.onResize();
    }

    override public function get height() : Number {
      return this._height;
    }

    override public function set height(param1:Number) : void {
      this._height = param1;
      this.onResize();
    }

    public function addUser(param1:Long) : void {
      this.list.addUser(clanMembersData.getClanMemberData(param1));
    }

    public function removeUser(param1:Long) : void {
      this.list.removeUser(param1);
    }

    public function maxMembers() : void {
      alertService.showOkAlert(localeService.getText(TanksLocale.TEXT_CLAN_ALERT_CLAN_FULL));
    }
  }
}
