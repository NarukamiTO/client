package forms.contextmenu {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.types.Long;
  import controls.TankWindow;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.system.System;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import forms.ColorConstants;
  import forms.ranks.SmallRankIcon;
  import forms.userlabel.UserLabel;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blockuser.IBlockUserService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanFunctionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.UserClanInfo;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen.UserChangeGameScreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.IOnlineNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoLabelUpdater;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.UserInfoLabelUpdaterEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.AlertUtils;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.KeyUpListenerPriority;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.UidUtil;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;
  import services.contextmenu.IContextMenuService;

  public class ContextMenu extends Sprite {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleInviteService:IBattleInviteService;

    [Inject]
    public static var contextMenuService:IContextMenuService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var onlineNotifierService:IOnlineNotifierService;

    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var blockUserService:IBlockUserService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var partnerService:IPartnerService;

    [Inject]
    public static var userChangeGameScreenService:UserChangeGameScreenService;

    [Inject]
    public static var clanFunctionsService:ClanFunctionsService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    private static const WINDOW_MARGIN:int = 11;
    private static const HIDE_DELAY_MS:int = 10000;
    private static const LINE_COLOR:uint = 1723412;

    private var _window:TankWindow;
    private var _windowInner:TankWindowInner;
    private var _uidLabel:LabelBase;
    private var _onlineLabel:LabelBase;
    private var _addToFriendsLabel:ContextMenuLabel;
    private var _acceptRequestLabel:ContextMenuLabel;
    private var _rejectRequestLabel:ContextMenuLabel;
    private var _copyUidLabel:ContextMenuLabel;
    private var _writeInPublicLabel:ContextMenuLabel;
    private var _writeInPrivateLabel:ContextMenuLabel;
    private var _blockUserLabel:ContextMenuLabel;
    private var _unblockUserLabel:ContextMenuLabel;
    private var _inviteBattleLabel:BattleInviteContextMenuLabel;
    private var _focusOnUserLabel:ContextMenuLabel;
    private var _voteUserLabel:ContextMenuLabel;
    private var _inviteToClanLabel:ContextMenuLabel;
    private var _showClanProfileLabel:ContextMenuLabel;
    private var _profileLink:ContextMenuLabel;
    private var _labels:Vector.<ContextMenuLabel>;
    private var _visibleLabels:Vector.<ContextMenuLabel>;
    private var _userId:Long;
    private var _uid:String;
    private var _rank:int;
    private var _rankIcon:SmallRankIcon;
    private var _hideTimeOut:uint;
    private var _setEventTimeOut:uint;
    private var _isOver:Boolean;
    private var _hasEventListener:Boolean;
    private var _isInit:Boolean;
    private var _line:Shape;
    private var _userInfoUpdater:IUserInfoLabelUpdater;
    private var _clanId:Long;
    private var isInviteToGroupEnabled:Boolean;

    public function ContextMenu() {
      super();
    }

    public function show(param1:Long, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean, param11:Boolean, param12:Boolean, param13:Boolean, param14:Boolean = true) : void {
      var local20:Boolean = false;
      var local21:Boolean = false;
      if(!this._isInit) {
        this._isInit = true;
        this.init();
      }
      this.x = display.stage.mouseX;
      this.y = display.stage.mouseY;
      this.isInviteToGroupEnabled = this.isInviteToGroupEnabled;
      this._userId = param1;
      this._uid = param3;
      this._rank = param2;
      this._rankIcon.setDefaultAccount(param2);
      this._uidLabel.text = param3;
      this._uidLabel.color = param5 ? ColorConstants.FRIEND_COLOR : ColorConstants.GREEN_LABEL;
      if(param5) {
        this.updateOnlineStatus();
        this._userInfoUpdater = userInfoService.getOrCreateUpdater(this._userId);
      }
      this._onlineLabel.visible = param5;
      this._addToFriendsLabel.visible = param4;
      this._acceptRequestLabel.visible = param6;
      this._rejectRequestLabel.visible = param7;
      this._writeInPublicLabel.visible = param8;
      this._writeInPrivateLabel.visible = param9;
      if(param10) {
        local20 = Boolean(blockUserService.isBlocked(param3));
        this._blockUserLabel.visible = !local20;
        this._unblockUserLabel.visible = local20;
      } else {
        this._blockUserLabel.visible = false;
        this._unblockUserLabel.visible = false;
      }
      this._inviteBattleLabel.visible = param11 && Boolean(battleInviteService.getAvailabilityInviteBattle(param1));
      this._focusOnUserLabel.visible = param12;
      this._showClanProfileLabel.visible = false;
      this._inviteToClanLabel.visible = false;
      this._voteUserLabel.visible = battleInfoService.isInBattle();
      var local15:UserClanInfo = clanUserInfoService.userClanInfoByUserId(this._userId);
      var local16:UserClanInfo = clanUserInfoService.userClanInfoByUserId(userPropertiesService.userId);
      var local17:Boolean = local16 != null && local16.clanActions.indexOf(ClanAction.INVITE_TO_CLAN) != -1;
      if(local15 != null) {
        local21 = local15.isInClan && local16.clanId != Long.ZERO && Boolean(lobbyLayoutService.inBattle()) && local16.clanId == local15.clanId;
        this._showClanProfileLabel.visible = local15.isInClan && !local21 && param13;
        this._inviteToClanLabel.visible = param14 && (!local15.isInClan && local17) && this._rank >= local16.minRankForJoinClan;
        this._clanId = local15.clanId;
      }
      this._visibleLabels.length = 0;
      var local18:int = int(this._labels.length);
      var local19:int = 0;
      while(local19 < local18) {
        if(this._labels[local19].visible) {
          this._visibleLabels.push(this._labels[local19]);
        }
        local19++;
      }
      this.resize();
      display.noticesLayer.addChild(this);
      clearTimeout(this._hideTimeOut);
      this._hideTimeOut = setTimeout(this.onHideTimeOut,HIDE_DELAY_MS);
      clearTimeout(this._setEventTimeOut);
      this._setEventTimeOut = setTimeout(this.setEvent,0);
    }

    private function updateOnlineStatus() : void {
      var local1:Boolean = Boolean(onlineNotifierService.hasUserOnlineData(this._userId)) && Boolean(onlineNotifierService.getUserOnlineData(this._userId).online);
      this._onlineLabel.color = local1 ? ColorConstants.CHAT_LABEL : ColorConstants.ACCESS_LABEL;
      if(local1) {
        this._uidLabel.color = ColorConstants.FRIEND_COLOR;
        this._onlineLabel.color = ColorConstants.CHAT_LABEL;
        this._onlineLabel.text = localeService.getText(TanksLocale.TEXT_ONLINE_LABEL);
      } else {
        this._uidLabel.color = ColorConstants.ACCESS_LABEL;
        this._onlineLabel.color = ColorConstants.ACCESS_LABEL;
        this._onlineLabel.text = localeService.getText(TanksLocale.TEXT_OFFLINE_LABEL);
      }
      this.updateInviteBattleAvailability(local1);
    }

    private function updateInviteBattleAvailability(param1:Boolean) : void {
      this._inviteBattleLabel.locked = !(param1 && Boolean(battleInfoService.availableRank(this._rank)));
    }

    private function init() : void {
      tabEnabled = false;
      tabChildren = false;
      this._window = new TankWindow();
      addChild(this._window);
      this._windowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      addChild(this._windowInner);
      this._uidLabel = new LabelBase();
      this._uidLabel.mouseEnabled = false;
      addChild(this._uidLabel);
      this._rankIcon = new SmallRankIcon();
      addChild(this._rankIcon);
      this._onlineLabel = new LabelBase();
      addChild(this._onlineLabel);
      this._labels = new Vector.<ContextMenuLabel>();
      this._visibleLabels = new Vector.<ContextMenuLabel>();
      this._addToFriendsLabel = new ContextMenuLabel();
      this._addToFriendsLabel.text = localeService.getText(TanksLocale.TEXT_FRIENDS_ADD);
      addChild(this._addToFriendsLabel);
      this._acceptRequestLabel = new ContextMenuLabel();
      this._acceptRequestLabel.text = localeService.getText(TanksLocale.TEXT_FRIENDS_CONFIRM_REQUEST);
      addChild(this._acceptRequestLabel);
      this._rejectRequestLabel = new ContextMenuLabel();
      this._rejectRequestLabel.text = localeService.getText(TanksLocale.TEXT_FRIENDS_DECLINE_REQUEST);
      addChild(this._rejectRequestLabel);
      this._copyUidLabel = new ContextMenuLabel();
      this._copyUidLabel.text = localeService.getText(TanksLocale.TEXT_FRIENDS_COPY_NAME);
      addChild(this._copyUidLabel);
      this._writeInPublicLabel = new ContextMenuLabel();
      this._writeInPublicLabel.text = localeService.getText(TanksLocale.TEXT_LOBBY_CHAT_WRITE_PUBLICLY);
      addChild(this._writeInPublicLabel);
      this._writeInPrivateLabel = new ContextMenuLabel();
      this._writeInPrivateLabel.text = localeService.getText(TanksLocale.TEXT_LOBBY_CHAT_WRITE_PRIVATELY);
      addChild(this._writeInPrivateLabel);
      this._blockUserLabel = new ContextMenuLabel();
      this._blockUserLabel.text = localeService.getText(TanksLocale.TEXT_BLOCK_USER_CONTEXT_MENU_LABEL);
      addChild(this._blockUserLabel);
      this._unblockUserLabel = new ContextMenuLabel();
      this._unblockUserLabel.text = localeService.getText(TanksLocale.TEXT_UNBLOCK_USER_CONTEXT_MENU_LABEL);
      addChild(this._unblockUserLabel);
      this._inviteBattleLabel = new BattleInviteContextMenuLabel();
      this._inviteBattleLabel.text = localeService.getText(TanksLocale.TEXT_INVITE_TO_BATTLE_LABEL);
      addChild(this._inviteBattleLabel);
      this._focusOnUserLabel = new ContextMenuLabel();
      this._focusOnUserLabel.text = localeService.getText(TanksLocale.TEXT_SPECTATE_TEXT);
      addChild(this._focusOnUserLabel);
      this._inviteToClanLabel = new ContextMenuLabel();
      this._inviteToClanLabel.text = localeService.getText(TanksLocale.TEXT_CLAN_INVITE_TO_CLAN);
      addChild(this._inviteToClanLabel);
      this._showClanProfileLabel = new ContextMenuLabel();
      this._showClanProfileLabel.text = localeService.getText(TanksLocale.TEXT_CLAN_PROFILE);
      addChild(this._showClanProfileLabel);
      this._profileLink = new ContextMenuLabel();
      this._profileLink.text = localeService.getText(TanksLocale.TEXT_PROFILE);
      if(!partnerService.isRunningInsidePartnerEnvironment() || Boolean(partnerService.hasRatings())) {
        addChild(this._profileLink);
      }
      this._voteUserLabel = new ContextMenuLabel();
      this._voteUserLabel.text = localeService.getText(TanksLocale.STRING_VOTE_USER_LABEL);
      addChild(this._voteUserLabel);
      this._labels.push(this._writeInPublicLabel);
      this._labels.push(this._writeInPrivateLabel);
      this._labels.push(this._copyUidLabel);
      this._labels.push(this._addToFriendsLabel);
      this._labels.push(this._acceptRequestLabel);
      this._labels.push(this._rejectRequestLabel);
      this._labels.push(this._inviteBattleLabel);
      this._labels.push(this._blockUserLabel);
      this._labels.push(this._unblockUserLabel);
      this._labels.push(this._focusOnUserLabel);
      this._labels.push(this._profileLink);
      this._labels.push(this._inviteToClanLabel);
      this._labels.push(this._showClanProfileLabel);
      this._labels.push(this._voteUserLabel);
      this._line = new Shape();
      addChild(this._line);
      this.resize();
      display.stage.addEventListener(MouseEvent.CLICK,this.onContextMenuClickStage);
      display.stage.addEventListener(Event.DEACTIVATE,this.onContextMenuDeactivate);
      display.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,KeyUpListenerPriority.CONTEXT_MENU);
    }

    private function resize() : void {
      var local2:int = 0;
      var local6:Number = NaN;
      var local7:ContextMenuLabel = null;
      var local8:int = 0;
      this._rankIcon.x = WINDOW_MARGIN + 7;
      this._rankIcon.y = WINDOW_MARGIN + 8;
      this._uidLabel.x = this._rankIcon.x + this._rankIcon.width;
      this._uidLabel.y = WINDOW_MARGIN + 5;
      this._onlineLabel.x = WINDOW_MARGIN + 5;
      this._onlineLabel.y = this._uidLabel.y + this._uidLabel.height - 1;
      var local1:int = this._uidLabel.x + this._uidLabel.width;
      var local3:int = int(this._visibleLabels.length);
      var local4:int = 0;
      while(local4 < local3) {
        local7 = this._visibleLabels[local4];
        local7.x = WINDOW_MARGIN + 5;
        if(local4 == 0) {
          local7.y = this._onlineLabel.visible ? 59 : 42;
        } else {
          local7.y = this._visibleLabels[local4 - 1].y + 18;
        }
        local2 = local7.y + 18;
        local8 = local7.x + local7.width;
        if(local8 > local1) {
          local1 = local8;
        }
        local4++;
      }
      local3 = int(this._labels.length);
      var local5:int = 0;
      while(local5 < local3) {
        if(!this._labels[local5].visible) {
          this._labels[local5].y = 0;
        }
        local5++;
      }
      this._line.graphics.clear();
      this._line.graphics.beginFill(LINE_COLOR,1);
      if(this._onlineLabel.visible) {
        local6 = this._onlineLabel.y + this._onlineLabel.height + 5;
      } else {
        local6 = this._uidLabel.y + this._uidLabel.height + 4;
      }
      this._line.graphics.drawRect(WINDOW_MARGIN + 7,local6,local1 - WINDOW_MARGIN - 8,1);
      this._line.graphics.endFill();
      this._window.width = local1 + WINDOW_MARGIN + 7;
      this._window.height = local2 + WINDOW_MARGIN + 8;
      this._windowInner.x = WINDOW_MARGIN;
      this._windowInner.y = WINDOW_MARGIN;
      this._windowInner.width = this._window.width - WINDOW_MARGIN * 2;
      this._windowInner.height = this._window.height - WINDOW_MARGIN * 2;
      if(this.x + this._window.width > display.stage.stageWidth) {
        this.x = display.stage.stageWidth - this._window.width;
      }
      if(this.y + this._window.height > display.stage.stageHeight) {
        this.y = display.stage.stageHeight - this._window.height;
      }
    }

    private function onHideTimeOut() : void {
      if(!this._isOver) {
        this.hide();
      }
    }

    private function setEvent() : void {
      if(!this._hasEventListener) {
        this._hasEventListener = true;
        this._addToFriendsLabel.addEventListener(MouseEvent.CLICK,this.onAddToFriendClick);
        this._acceptRequestLabel.addEventListener(MouseEvent.CLICK,this.onAcceptRequestClick);
        this._rejectRequestLabel.addEventListener(MouseEvent.CLICK,this.onRejectRequestClick);
        this._copyUidLabel.addEventListener(MouseEvent.CLICK,this.onCopyUidClick);
        this._writeInPublicLabel.addEventListener(MouseEvent.CLICK,this.onWriteInPublicClick);
        this._writeInPrivateLabel.addEventListener(MouseEvent.CLICK,this.onWriteInPrivateClick);
        this._blockUserLabel.addEventListener(MouseEvent.CLICK,this.onBlockUserClick);
        this._unblockUserLabel.addEventListener(MouseEvent.CLICK,this.onUnblockUserClick);
        this._inviteBattleLabel.addEventListener(MouseEvent.CLICK,this.onInvitationToBattleClick);
        this._focusOnUserLabel.addEventListener(MouseEvent.CLICK,this.onFocusOnUserClick);
        this._profileLink.addEventListener(MouseEvent.CLICK,this.onProfileLinkClick);
        this._inviteToClanLabel.addEventListener(MouseEvent.CLICK,this.onInviteToClanClick);
        this._showClanProfileLabel.addEventListener(MouseEvent.CLICK,this.onShowClanProfile);
        this._voteUserLabel.addEventListener(MouseEvent.CLICK,this.onVoteUser);
        if(this._userInfoUpdater != null) {
          this._userInfoUpdater.addEventListener(UserInfoLabelUpdaterEvent.CHANGE_ONLINE,this.onChangeOnline);
        }
        this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
        this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
    }

    private function onInviteToClanClick(param1:MouseEvent) : void {
      clanFunctionsService.invite(this._userId);
      this.hide();
    }

    private function onShowClanProfile(param1:MouseEvent) : void {
      if(this._clanId != null) {
        contextMenuService.showClan(this._clanId);
      }
      this.hide();
    }

    private function onAddToFriendClick(param1:MouseEvent) : void {
      contextMenuService.addToFriend(this._userId);
      this.hide();
    }

    private function onAcceptRequestClick(param1:MouseEvent) : void {
      contextMenuService.acceptRequest(this._userId,this._uid);
      this.hide();
    }

    private function onRejectRequestClick(param1:MouseEvent) : void {
      contextMenuService.rejectRequest(this._userId,this._uid);
      this.hide();
    }

    private function onProfileLinkClick(param1:MouseEvent) : void {
      userChangeGameScreenService.showUserStatistics();
      var local2:URLRequest = new URLRequest(userPropertiesService.getUserProfileUrl(this._uidLabel.text));
      navigateToURL(local2,"_blank");
    }

    private function onCopyUidClick(param1:MouseEvent) : void {
      System.setClipboard(UidUtil.userNameWithoutClanTag(this._uidLabel.text));
      this.hide();
    }

    private function onWriteInPublicClick(param1:MouseEvent) : void {
      contextMenuService.writeInPublic(this._userId,this._uid);
      this.hide();
    }

    private function onWriteInPrivateClick(param1:MouseEvent) : void {
      contextMenuService.writeInPrivate(this._userId,this._uid);
      this.hide();
    }

    private function onBlockUserClick(param1:MouseEvent) : void {
      blockUserService.blockUser(this._uid);
      this.hide();
    }

    private function onUnblockUserClick(param1:MouseEvent) : void {
      blockUserService.unblockUser(this._uid);
      this.hide();
    }

    private function onInvitationToBattleClick(param1:MouseEvent) : void {
      battleInviteService.invite(this._userId);
      this.hide();
    }

    private function onFocusOnUserClick(param1:MouseEvent) : void {
      contextMenuService.focusOnUser(this._userId,this._uid);
      this.hide();
    }

    private function onVoteUser(param1:MouseEvent) : * {
      contextMenuService.voteUser(this._userId,this._uid);
      this.hide();
    }

    private function onChangeOnline(param1:UserInfoLabelUpdaterEvent) : void {
      this.updateOnlineStatus();
    }

    private function onRollOver(param1:MouseEvent) : void {
      this._isOver = true;
      clearTimeout(this._hideTimeOut);
    }

    private function onRollOut(param1:MouseEvent) : void {
      this._isOver = false;
      clearTimeout(this._hideTimeOut);
      this._hideTimeOut = setTimeout(this.onHideTimeOut,HIDE_DELAY_MS);
    }

    private function onContextMenuClickStage(param1:MouseEvent) : void {
      if(!this._hasEventListener || this._isOver) {
        return;
      }
      var local2:UserLabel = param1.target as UserLabel;
      if(local2 == null || local2.self) {
        this.hide();
      }
    }

    private function onKeyUp(param1:KeyboardEvent) : void {
      if(!this._hasEventListener) {
        return;
      }
      if(AlertUtils.isCancelKey(param1.keyCode)) {
        param1.stopImmediatePropagation();
        this.hide();
      }
    }

    private function onContextMenuDeactivate(param1:Event) : void {
      this.hide();
    }

    private function hide() : void {
      this._userInfoUpdater = null;
      clearTimeout(this._hideTimeOut);
      clearTimeout(this._setEventTimeOut);
      removeDisplayObject(this);
      this.removeEvents();
    }

    private function removeEvents() : void {
      if(this._hasEventListener) {
        this._hasEventListener = false;
        this._addToFriendsLabel.removeEventListener(MouseEvent.CLICK,this.onAddToFriendClick);
        this._acceptRequestLabel.removeEventListener(MouseEvent.CLICK,this.onAcceptRequestClick);
        this._rejectRequestLabel.removeEventListener(MouseEvent.CLICK,this.onRejectRequestClick);
        this._copyUidLabel.removeEventListener(MouseEvent.CLICK,this.onCopyUidClick);
        this._writeInPublicLabel.removeEventListener(MouseEvent.CLICK,this.onWriteInPublicClick);
        this._writeInPrivateLabel.removeEventListener(MouseEvent.CLICK,this.onWriteInPrivateClick);
        this._blockUserLabel.removeEventListener(MouseEvent.CLICK,this.onBlockUserClick);
        this._unblockUserLabel.removeEventListener(MouseEvent.CLICK,this.onUnblockUserClick);
        this._inviteBattleLabel.removeEventListener(MouseEvent.CLICK,this.onInvitationToBattleClick);
        this._focusOnUserLabel.removeEventListener(MouseEvent.CLICK,this.onFocusOnUserClick);
        this._profileLink.removeEventListener(MouseEvent.CLICK,this.onProfileLinkClick);
        this._inviteToClanLabel.removeEventListener(MouseEvent.CLICK,this.onInviteToClanClick);
        this._showClanProfileLabel.removeEventListener(MouseEvent.CLICK,this.onShowClanProfile);
        this._voteUserLabel.removeEventListener(MouseEvent.CLICK,this.onVoteUser);
        if(this._userInfoUpdater != null) {
          this._userInfoUpdater.removeEventListener(UserInfoLabelUpdaterEvent.CHANGE_ONLINE,this.onChangeOnline);
        }
        this.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
        this.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
    }
  }
}
