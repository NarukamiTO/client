package alternativa.tanks.view.mainview.groupinvite {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.friends.FriendWindowButton;
  import alternativa.tanks.gui.friends.FriendsWindowState;
  import alternativa.tanks.gui.friends.FriendsWindowStateBigButton;
  import alternativa.types.Long;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import controls.base.TankInputBase;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import forms.ColorConstants;
  import forms.TankWindowWithHeader;
  import forms.events.LoginFormEvent;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.UserClanInfo;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;

  public class GroupInviteWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var partnerService:IPartnerService;

    public static const WINDOW_MARGIN:int = 12;
    public static const DEFAULT_BUTTON_WIDTH:int = 100;
    public static const BUTTON_WITH_ICON_WIDTH:int = 115;
    public static const WINDOW_WIDTH:int = 468 + WINDOW_MARGIN * 2 + 4;

    private static const WINDOW_HEIGHT:int = 485;
    private static const SEARCH_TIMEOUT:int = 600;

    private var window:TankWindowWithHeader;
    private var windowInner:TankWindowInner;
    private var windowSize:Point;
    private var acceptedFriendButton:FriendsWindowStateBigButton;
    private var clanMembersButton:FriendsWindowStateBigButton;
    private var closeButton:FriendWindowButton;
    private var searchInListTextInput:TankInputBase;
    private var searchInListLabel:LabelBase;
    private var searchInListTimeOut:uint;
    private var acceptedList:InviteToGroupList;
    private var clanList:InviteClanMembersList;

    public function GroupInviteWindow() {
      super();
      this.initWindow();
      this.initButtons();
      this.initLists();
      this.initSearchControl();
      this.resize();
      addEventListener(Event.ADDED_TO_STAGE,this.added);
    }

    private function initWindow() : void {
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_FRIENDS);
      addChild(this.window);
      this.windowSize = new Point(WINDOW_WIDTH,WINDOW_HEIGHT);
      this.windowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      addChild(this.windowInner);
    }

    public function setAllowedUsers(param1:Vector.<Long>, param2:Vector.<Long>) : void {
      this.acceptedList.fillList(param1);
      this.clanList.fillList(param2);
    }

    private function initButtons() : void {
      this.acceptedFriendButton = new FriendsWindowStateBigButton(FriendsWindowState.ACCEPTED);
      this.acceptedFriendButton.text = localeService.getText(TanksLocale.TEXT_FRIENDS);
      this.acceptedFriendButton.addEventListener(MouseEvent.CLICK,this.onShowFriends);
      addChild(this.acceptedFriendButton);
      this.clanMembersButton = new FriendsWindowStateBigButton(FriendsWindowState.CLAN_MEMBERS);
      this.clanMembersButton.text = localeService.getText(TanksLocale.TEXT_CLAN_MY_CLAN);
      this.clanMembersButton.addEventListener(MouseEvent.CLICK,this.onShowClanMembers);
      addChild(this.clanMembersButton);
      this.closeButton = new FriendWindowButton();
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_FRIENDS_CLOSE);
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      addChild(this.closeButton);
    }

    public function removeUser(param1:Long) : void {
      this.acceptedList.removeUser(param1);
      this.clanList.removeUser(param1);
    }

    private function onShowFriends(param1:MouseEvent) : void {
      this.show(FriendsWindowState.ACCEPTED);
    }

    private function onShowClanMembers(param1:MouseEvent) : void {
      this.show(FriendsWindowState.CLAN_MEMBERS);
    }

    private function initLists() : void {
      this.acceptedList = new InviteToGroupList();
      this.clanList = new InviteClanMembersList();
    }

    private function initSearchControl() : void {
      this.searchInListTextInput = new TankInputBase();
      this.searchInListTextInput.maxChars = 20;
      this.searchInListTextInput.restrict = "0-9.a-zA-z_\\-*";
      this.searchInListTextInput.addEventListener(FocusEvent.FOCUS_IN,this.onFocusInSearchInList);
      this.searchInListTextInput.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOutSearchInList);
      this.searchInListTextInput.addEventListener(LoginFormEvent.TEXT_CHANGED,this.onTextChangeSearchInList);
      addChild(this.searchInListTextInput);
      this.searchInListLabel = new LabelBase();
      this.searchInListLabel.mouseEnabled = false;
      this.searchInListLabel.color = ColorConstants.LIST_LABEL_HINT;
      this.searchInListLabel.text = localeService.getText(TanksLocale.TEXT_FRIENDS_FIND_IN_LIST_HINT);
      addChild(this.searchInListLabel);
    }

    private function added(param1:Event) : void {
      var local2:UserClanInfo = clanUserInfoService.userClanInfoByUserId(userInfoService.getCurrentUserId());
      this.clanMembersButton.visible = local2 != null && local2.isInClan;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      this.show(FriendsWindowState.ACCEPTED);
    }

    private function onTextChangeSearchInList(param1:LoginFormEvent) : void {
      if(this.searchInListTextInput.value.length > 0) {
        this.searchInListLabel.visible = false;
      }
      clearTimeout(this.searchInListTimeOut);
      this.searchInListTimeOut = setTimeout(this.acceptedList.filter,SEARCH_TIMEOUT,"uid",this.searchInListTextInput.value);
      this.updateVisibleSearchInListLabel();
    }

    private function onFocusInSearchInList(param1:FocusEvent) : void {
      this.searchInListLabel.visible = false;
    }

    private function onFocusOutSearchInList(param1:FocusEvent) : void {
      this.updateVisibleSearchInListLabel();
    }

    private function updateVisibleSearchInListLabel() : void {
      if(this.searchInListTextInput.value.length == 0 && display.stage.focus != this.searchInListTextInput.textField) {
        this.searchInListLabel.visible = true;
      }
    }

    private function resize() : void {
      this.window.width = this.windowSize.x;
      this.window.height = this.windowSize.y;
      this.acceptedFriendButton.x = WINDOW_MARGIN;
      this.acceptedFriendButton.width = BUTTON_WITH_ICON_WIDTH;
      this.acceptedFriendButton.y = WINDOW_MARGIN;
      this.clanMembersButton.x = this.acceptedFriendButton.x + BUTTON_WITH_ICON_WIDTH + WINDOW_MARGIN;
      this.clanMembersButton.width = BUTTON_WITH_ICON_WIDTH;
      this.clanMembersButton.y = WINDOW_MARGIN;
      this.closeButton.width = DEFAULT_BUTTON_WIDTH;
      this.closeButton.x = this.windowSize.x - this.closeButton.width - WINDOW_MARGIN;
      this.closeButton.y = this.windowSize.y - this.closeButton.height - WINDOW_MARGIN;
      this.windowInner.x = WINDOW_MARGIN;
      this.windowInner.y = this.acceptedFriendButton.y + this.acceptedFriendButton.height + 1;
      this.windowInner.width = this.windowSize.x - WINDOW_MARGIN * 2;
      this.windowInner.height = this.windowSize.y - this.windowInner.y - this.closeButton.height - 18;
      var local1:int = 4;
      var local2:int = this.windowInner.x + local1;
      var local3:int = this.windowInner.y + local1;
      var local4:int = this.windowInner.width - local1 * 2;
      var local5:int = this.windowInner.height - local1 * 2;
      this.acceptedList.resize(local4,local5);
      this.acceptedList.x = local2;
      this.acceptedList.y = local3;
      this.clanList.resize(local4,local5);
      this.clanList.x = local2;
      this.clanList.y = local3;
      this.searchInListTextInput.width = 235;
      this.searchInListTextInput.x = WINDOW_MARGIN;
      this.searchInListTextInput.y = this.windowSize.y - this.searchInListTextInput.height - WINDOW_MARGIN;
      this.searchInListLabel.x = this.searchInListTextInput.x + 3;
      this.searchInListLabel.y = this.searchInListTextInput.y + 7;
    }

    public function destroy() : void {
      this.acceptedFriendButton.removeEventListener(MouseEvent.CLICK,this.onShowFriends);
      this.clanMembersButton.removeEventListener(MouseEvent.CLICK,this.onShowClanMembers);
      this.searchInListTextInput.removeEventListener(FocusEvent.FOCUS_IN,this.onFocusInSearchInList);
      this.searchInListTextInput.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusOutSearchInList);
      this.hide();
    }

    private function hide() : void {
      dialogService.removeDialog(this);
      this.acceptedList.hide();
      this.clanList.hide();
      clearTimeout(this.searchInListTimeOut);
    }

    public function show(param1:FriendsWindowState) : void {
      switch(param1) {
        case FriendsWindowState.ACCEPTED:
          this.acceptedFriendButton.enable = false;
          this.clanMembersButton.enable = true;
          this.windowInner.addChild(this.acceptedList);
          this.searchInListTextInput.value = "";
          this.searchInListTextInput.visible = true;
          this.searchInListLabel.visible = true;
          this.acceptedList.init();
          this.clanList.hide();
          addChild(this.acceptedList);
          break;
        case FriendsWindowState.CLAN_MEMBERS:
          this.acceptedFriendButton.enable = true;
          this.clanMembersButton.enable = false;
          this.windowInner.addChild(this.clanList);
          this.searchInListTextInput.visible = false;
          this.searchInListLabel.visible = false;
          this.clanList.init();
          this.acceptedList.hide();
          addChild(this.clanList);
      }
      dialogService.addDialog(this);
    }

    private function onCloseButtonClick(param1:MouseEvent = null) : void {
      this.closeWindow();
    }

    private function closeWindow() : void {
      this.searchInListTextInput.value = "";
      this.updateVisibleSearchInListLabel();
      display.stage.focus = null;
      this.hide();
    }

    override protected function cancelKeyPressed() : void {
      this.onCloseButtonClick();
    }
  }
}
