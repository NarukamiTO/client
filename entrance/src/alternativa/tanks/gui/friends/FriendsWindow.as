package alternativa.tanks.gui.friends {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.friends.list.AcceptedList;
  import alternativa.tanks.gui.friends.list.ClanMembersList;
  import alternativa.tanks.gui.friends.list.IncomingList;
  import alternativa.tanks.gui.friends.list.refferals.ReferralForm;
  import alternativa.tanks.service.referrals.notification.NewReferralsNotifierService;
  import alternativa.tanks.service.referrals.notification.NewReferralsNotifierServiceEvent;
  import controls.TankWindowInner;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import forms.TankWindowWithHeader;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.BattleLinkActivatorServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.activator.IBattleLinkActivatorService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.UserClanInfo;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendActionService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.NewFriendEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;

  public class FriendsWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var battleLinkActivatorService:IBattleLinkActivatorService;

    [Inject]
    public static var friendInfoService:IFriendInfoService;

    [Inject]
    public static var friendsActionService:IFriendActionService;

    [Inject]
    public static var blurService:IBlurService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var userChangeGameScreenService:UserChangeGameScreenService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var newReferralsNotifierService:NewReferralsNotifierService;

    [Inject]
    public static var partnerService:IPartnerService;

    public static const WINDOW_MARGIN:int = 12;
    public static const DEFAULT_BUTTON_WIDTH:int = 100;
    public static const BUTTON_WITH_ICON_WIDTH:int = 115;
    public static const WINDOW_WIDTH:int = 468 + WINDOW_MARGIN * 2 + 4;

    private static const WINDOW_HEIGHT:int = 485;

    private var window:TankWindowWithHeader;
    private var windowInner:TankWindowInner;
    private var windowSize:Point;
    private var incomingButton:FriendsWindowStateSmallButton;
    private var acceptedFriendButton:FriendsWindowStateBigButton;
    private var referralsButton:FriendsWindowStateBigButton;
    private var clanMembersButton:FriendsWindowStateBigButton;
    private var closeButton:FriendWindowButton;
    private var rejectAllIncomingButton:RejectAllIncomingButton;
    private var acceptedList:AcceptedList;
    private var incomingList:IncomingList;
    private var referralsForm:ReferralForm;
    private var clanList:ClanMembersList;
    private var currentList:IFriendsListState;
    private var addRequestView:AddRequestView;

    public function FriendsWindow() {
      super();
      this.initWindow();
      this.initButtons();
      this.initLists();
      this.addFriendRequestView();
      this.initOthers();
      this.resize();
      addEventListener(Event.ADDED_TO_STAGE,this.added);
    }

    private function added(param1:Event) : void {
      this.updateClanButton();
    }

    public function updateClanButton() : void {
      var local1:UserClanInfo = clanUserInfoService.userClanInfoByUserId(userInfoService.getCurrentUserId());
      this.clanMembersButton.visible = local1 != null && local1.isInClan;
      if(!this.clanMembersButton.visible && stage && friendInfoService.newIncomingFriendsLength == 0) {
        this.show(FriendsWindowState.ACCEPTED);
      }
    }

    private function initWindow() : void {
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_FRIENDS);
      addChild(this.window);
      this.windowSize = new Point(WINDOW_WIDTH,WINDOW_HEIGHT);
      this.windowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      addChild(this.windowInner);
    }

    private function initButtons() : void {
      this.acceptedFriendButton = new FriendsWindowStateBigButton(FriendsWindowState.ACCEPTED);
      this.acceptedFriendButton.text = localeService.getText(TanksLocale.TEXT_FRIENDS);
      this.acceptedFriendButton.addEventListener(MouseEvent.CLICK,this.onChangeState);
      addChild(this.acceptedFriendButton);
      this.referralsButton = new FriendsWindowStateBigButton(FriendsWindowState.REFERRALS);
      this.referralsButton.text = localeService.getText(TanksLocale.TEXT_REFERRALS_BUTTON_LABEL);
      this.referralsButton.addEventListener(MouseEvent.CLICK,this.onChangeState);
      addChild(this.referralsButton);
      this.referralsButton.visible = this.isReferralsButtonNeed();
      this.incomingButton = new FriendsWindowStateSmallButton(FriendsWindowState.INCOMING);
      this.incomingButton.addEventListener(MouseEvent.CLICK,this.onChangeState);
      addChild(this.incomingButton);
      this.clanMembersButton = new FriendsWindowStateBigButton(FriendsWindowState.CLAN_MEMBERS);
      this.clanMembersButton.text = localeService.getText(TanksLocale.TEXT_CLAN_MY_CLAN);
      this.clanMembersButton.addEventListener(MouseEvent.CLICK,this.onChangeState);
      addChild(this.clanMembersButton);
      this.rejectAllIncomingButton = new RejectAllIncomingButton();
      this.rejectAllIncomingButton.label = localeService.getText(TanksLocale.TEXT_FRIENDS_DECLINE_ALL_BUTTON);
      this.rejectAllIncomingButton.addEventListener(MouseEvent.CLICK,this.onClickRejectAllIncoming);
      addChild(this.rejectAllIncomingButton);
      this.closeButton = new FriendWindowButton();
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_FRIENDS_CLOSE);
      addChild(this.closeButton);
    }

    private function isReferralsButtonNeed() : Boolean {
      return !partnerService.isRunningInsidePartnerEnvironment() || Boolean(partnerService.hasSocialFunction());
    }

    private function initLists() : void {
      this.acceptedList = new AcceptedList();
      this.incomingList = new IncomingList(this.rejectAllIncomingButton);
      this.referralsForm = new ReferralForm();
      this.clanList = new ClanMembersList();
    }

    private function initOthers() : void {
      battleLinkActivatorService.addEventListener(BattleLinkActivatorServiceEvent.ACTIVATE_LINK,this.onBattleLinkClick);
      newReferralsNotifierService.addEventListener(NewReferralsNotifierServiceEvent.NEW_REFERRALS_COUNT_UPDATED,this.onUpdateNewReferralsCount);
      newReferralsNotifierService.addEventListener(NewReferralsNotifierServiceEvent.REFERRAL_ADDED,this.onReferralAdded);
    }

    private function addFriendRequestView() : void {
      this.addRequestView = new AddRequestView();
      addChild(this.addRequestView);
      this.addRequestView.show();
    }

    private function onReferralAdded(param1:NewReferralsNotifierServiceEvent) : void {
      this.updateNewReferralsCount();
    }

    private function onUpdateNewReferralsCount(param1:NewReferralsNotifierServiceEvent) : void {
      this.updateNewReferralsCount();
    }

    private function updateNewReferralsCount() : void {
      this.referralsButton.newRequestCount = newReferralsNotifierService.getNewReferralsCount();
    }

    private function onClickRejectAllIncoming(param1:MouseEvent) : void {
      var local2:String = localeService.getText(TanksLocale.TEXT_FRIENDS_DECLINE_ALL_REQUESTS_ALERT);
      alertService.showAlert(local2,Vector.<String>([localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_YES),localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_NO)]));
      alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onConfirmRejectAllIncoming);
    }

    private function onConfirmRejectAllIncoming(param1:AlertServiceEvent) : void {
      alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onConfirmRejectAllIncoming);
      if(param1.typeButton == localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_YES)) {
        friendsActionService.rejectAllIncoming();
      }
    }

    private function onBattleLinkClick(param1:BattleLinkActivatorServiceEvent) : void {
      this.hide();
    }

    private function resize() : void {
      this.window.width = this.windowSize.x;
      this.window.height = this.windowSize.y;
      this.acceptedFriendButton.x = WINDOW_MARGIN;
      this.acceptedFriendButton.width = BUTTON_WITH_ICON_WIDTH;
      this.acceptedFriendButton.y = WINDOW_MARGIN;
      this.referralsButton.x = this.acceptedFriendButton.x + this.acceptedFriendButton.width + 6;
      this.referralsButton.width = BUTTON_WITH_ICON_WIDTH;
      this.referralsButton.y = WINDOW_MARGIN;
      this.incomingButton.x = this.windowSize.x - WINDOW_MARGIN - this.incomingButton.width;
      this.incomingButton.y = WINDOW_MARGIN;
      this.clanMembersButton.x = this.referralsButton.visible ? this.referralsButton.x + this.referralsButton.width + 6 : this.referralsButton.x;
      this.clanMembersButton.width = BUTTON_WITH_ICON_WIDTH;
      this.clanMembersButton.y = WINDOW_MARGIN;
      this.closeButton.width = DEFAULT_BUTTON_WIDTH;
      this.closeButton.x = this.windowSize.x - this.closeButton.width - WINDOW_MARGIN;
      this.closeButton.y = this.windowSize.y - this.closeButton.height - WINDOW_MARGIN;
      this.rejectAllIncomingButton.width = DEFAULT_BUTTON_WIDTH;
      this.rejectAllIncomingButton.x = this.closeButton.x - this.rejectAllIncomingButton.width - 6;
      this.rejectAllIncomingButton.y = this.windowSize.y - this.rejectAllIncomingButton.height - WINDOW_MARGIN;
      this.windowInner.x = WINDOW_MARGIN;
      this.windowInner.y = this.acceptedFriendButton.y + this.acceptedFriendButton.height + 1;
      this.windowInner.width = this.windowSize.x - WINDOW_MARGIN * 2;
      this.windowInner.height = this.windowSize.y - this.windowInner.y - this.closeButton.height - 18;
      var local1:int = 4;
      var local2:int = this.windowInner.x + local1;
      var local3:int = this.windowInner.y + local1;
      var local4:int = this.windowInner.width - local1 * 2 + 2;
      var local5:int = this.windowInner.height - local1 * 2;
      this.acceptedList.resize(local4,local5);
      this.acceptedList.x = local2;
      this.acceptedList.y = local3;
      this.clanList.resize(local4,local5);
      this.clanList.x = local2;
      this.clanList.y = local3;
      this.incomingList.resize(local4,local5);
      this.incomingList.x = local2;
      this.incomingList.y = local3;
      this.referralsForm.x = local2 - 4;
      this.referralsForm.y = local3;
      this.referralsForm.resize(local4 + 6,local5);
      this.addRequestView.y = this.windowSize.y - this.addRequestView.height - WINDOW_MARGIN;
    }

    private function onChangeState(param1:MouseEvent) : void {
      this.show(FriendsWindowButtonType(param1.currentTarget).getType());
    }

    public function destroy() : void {
      this.acceptedFriendButton.removeEventListener(MouseEvent.CLICK,this.onChangeState);
      this.incomingButton.removeEventListener(MouseEvent.CLICK,this.onChangeState);
      this.referralsButton.removeEventListener(MouseEvent.CLICK,this.onChangeState);
      this.clanMembersButton.removeEventListener(MouseEvent.CLICK,this.onChangeState);
      battleLinkActivatorService.removeEventListener(BattleLinkActivatorServiceEvent.ACTIVATE_LINK,this.onBattleLinkClick);
      newReferralsNotifierService.removeEventListener(NewReferralsNotifierServiceEvent.REFERRAL_ADDED,this.onReferralAdded);
      newReferralsNotifierService.removeEventListener(NewReferralsNotifierServiceEvent.NEW_REFERRALS_COUNT_UPDATED,this.onUpdateNewReferralsCount);
      this.rejectAllIncomingButton.removeEventListener(MouseEvent.CLICK,this.onClickRejectAllIncoming);
      this.hide();
    }

    private function hide() : void {
      dialogService.removeDialog(this);
      if(this.closeButton.hasEventListener(MouseEvent.CLICK)) {
        this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      }
      if(this.currentList != null) {
        this.currentList.hide();
        this.currentList = null;
      }
      friendInfoService.removeEventListener(NewFriendEvent.ACCEPTED_CHANGE,this.onUpdateAcceptedCounter);
      friendInfoService.removeEventListener(NewFriendEvent.INCOMING_CHANGE,this.onUpdateIncomingCounter);
      this.addRequestView.hide();
    }

    private function onUpdateIncomingCounter(param1:NewFriendEvent) : void {
      this.updateIncomingCounter();
    }

    private function onUpdateAcceptedCounter(param1:NewFriendEvent) : void {
      this.updateAcceptedCounter();
    }

    private function updateIncomingCounter() : void {
      this.incomingButton.setRequestCount(friendInfoService.incomingFriendsLength,friendInfoService.newIncomingFriendsLength);
    }

    private function updateAcceptedCounter() : void {
      this.acceptedFriendButton.setRequestCount(friendInfoService.acceptedFriendsLength,friendInfoService.newAcceptedFriendsLength);
    }

    public function show(param1:FriendsWindowState) : void {
      this.updateAcceptedCounter();
      this.updateIncomingCounter();
      if(param1 != FriendsWindowState.REFERRALS) {
        this.updateReferralsCounter();
      }
      friendInfoService.addEventListener(NewFriendEvent.ACCEPTED_CHANGE,this.onUpdateAcceptedCounter);
      friendInfoService.addEventListener(NewFriendEvent.INCOMING_CHANGE,this.onUpdateIncomingCounter);
      var local2:IFriendsListState = this.getFriendsListByState(param1);
      this.updateState(param1);
      local2.initList();
      addChild(Sprite(local2));
      this.currentList = local2;
      this.currentList.resetFilter();
    }

    private function getFriendsListByState(param1:FriendsWindowState) : IFriendsListState {
      switch(param1) {
        case FriendsWindowState.ACCEPTED:
          return this.acceptedList;
        case FriendsWindowState.INCOMING:
          return this.incomingList;
        case FriendsWindowState.CLAN_MEMBERS:
          return this.clanList;
        default:
          return this.referralsForm;
      }
    }

    private function updateReferralsCounter() : void {
      newReferralsNotifierService.requestNewReferralsCount();
    }

    private function updateState(param1:FriendsWindowState) : void {
      this.currentState = param1;
      if(this.currentList != null) {
        this.currentList.hide();
        this.currentList = null;
      }
      dialogService.addDialog(this);
      if(!this.closeButton.hasEventListener(MouseEvent.CLICK)) {
        this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      }
    }

    private function onCloseButtonClick(param1:MouseEvent = null) : void {
      this.closeWindow();
    }

    private function closeWindow() : void {
      userChangeGameScreenService.friendWindowClosed();
      display.stage.focus = null;
      this.hide();
    }

    public function set currentState(param1:FriendsWindowState) : void {
      switch(param1) {
        case FriendsWindowState.ACCEPTED:
          this.acceptedFriendButton.enable = false;
          this.referralsButton.enable = true;
          this.clanMembersButton.enable = true;
          this.incomingButton.isPressed = false;
          this.rejectAllIncomingButton.visible = false;
          this.windowInner.visible = true;
          this.addRequestView.show();
          break;
        case FriendsWindowState.INCOMING:
          this.acceptedFriendButton.enable = true;
          this.referralsButton.enable = true;
          this.clanMembersButton.enable = true;
          this.incomingButton.isPressed = true;
          this.rejectAllIncomingButton.visible = true;
          this.windowInner.visible = true;
          this.addRequestView.hide();
          break;
        case FriendsWindowState.REFERRALS:
          this.acceptedFriendButton.enable = true;
          this.referralsButton.enable = false;
          this.clanMembersButton.enable = true;
          this.incomingButton.isPressed = false;
          this.rejectAllIncomingButton.visible = false;
          this.windowInner.visible = false;
          this.addRequestView.hide();
          break;
        case FriendsWindowState.CLAN_MEMBERS:
          this.acceptedFriendButton.enable = true;
          this.referralsButton.enable = true;
          this.clanMembersButton.enable = false;
          this.incomingButton.isPressed = false;
          this.rejectAllIncomingButton.visible = false;
          this.windowInner.visible = true;
          this.addRequestView.hide();
      }
    }

    override protected function cancelKeyPressed() : void {
      this.onCloseButtonClick();
    }
  }
}
