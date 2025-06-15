package forms.userlabel {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.types.Long;
  import base.DiscreteSprite;
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.system.System;
  import forms.ColorConstants;
  import forms.ranks.SmallRankIcon;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.UserClanInfo;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.FriendInfoLabelUpdaterEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendsInfoLabelUpdater;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.group.IGroupInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.BattleUserPremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoLabelUpdater;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.UserInfoLabelUpdaterEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import services.contextmenu.IContextMenuService;

  public class UserLabel extends Sprite {
    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var friendInfoService:IFriendInfoService;

    [Inject]
    public static var contextMenuService:IContextMenuService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var premiumService:PremiumService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var groupInfoService:IGroupInfoService;

    [Inject]
    public static var battlePremiumService:BattleUserPremiumService;

    protected static const RANK_ICON_CONT_WIDTH:int = 20;

    private static const RANK_ICON_CONT_HEIGHT:int = 18;

    protected var shadowContainer:DiscreteSprite = new DiscreteSprite();
    protected var _userId:Long;
    protected var _uid:String;
    protected var _rank:int;
    protected var _friendState:FriendState;
    protected var _friendInfoUpdater:IFriendsInfoLabelUpdater;
    protected var _userInfoUpdater:IUserInfoLabelUpdater;
    protected var _uidLabel:LabelBase;
    protected var _writeInPublicChat:Boolean;
    protected var _writePrivateInChat:Boolean;
    protected var _blockUserEnable:Boolean;
    protected var _forciblySubscribeFriend:Boolean;
    protected var _isInitRank:Boolean;
    protected var _isInitUid:Boolean;
    protected var _focusOnUserEnabled:Boolean;
    protected var _hasPremium:Boolean;

    private var _inviteBattleEnable:Boolean;
    private var _rankIcon:SmallRankIcon;
    private var _online:Boolean;

    protected var _self:Boolean;

    private var _lastUidColor:uint;
    private var _ignoreFriendsColor:Boolean;
    private var _additionalText:String = "";

    protected var _showClanTag:Boolean = true;

    private var _showClanProfile:Boolean = true;
    private var _showInviteToClan:Boolean = true;
    private var inSameGroup:Boolean = false;

    public function UserLabel(param1:Long, param2:Boolean = true) {
      super();
      if(param1 == null) {
        throw Error("UserLabel userId is NULL");
      }
      this._showClanTag = param2;
      this._userId = param1;
      this.init();
    }

    protected function getShadowFilters() : Array {
      return null;
    }

    private function init() : void {
      mouseChildren = false;
      mouseEnabled = true;
      tabEnabled = false;
      tabChildren = false;
      addChild(this.shadowContainer);
      this.shadowContainer.filters = this.getShadowFilters();
      this._lastUidColor = ColorConstants.GREEN_LABEL;
      this.initSelf();
      if(!this._self) {
        buttonMode = useHandCursor = true;
      }
      this.createRankIcon();
      this.createAdditionalIcons();
      this.createUidLabel();
      userInfoService.forciblySubscribe(this._userId);
      this._userInfoUpdater = userInfoService.getOrCreateUpdater(this._userId);
      this._friendInfoUpdater = friendInfoService.getOrCreateUpdater(this._userId);
      this.updateProperties();
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      if(groupInfoService.hasGroups()) {
        this.inSameGroup = groupInfoService.isInSameGroup(this._userId);
        this.refreshFriendState();
      }
    }

    protected function initSelf() : void {
      this._self = userPropertiesService.userId == this._userId;
    }

    protected function createAdditionalIcons() : void {
    }

    protected function updateProperties() : void {
      if(this._userInfoUpdater.hasData()) {
        if(this._self) {
          this.setRank(userPropertiesService.rank);
        } else {
          this.setRank(this._userInfoUpdater.rank);
        }
        this.setUid(this._userInfoUpdater.uid);
        this.updateStatusOnline();
      }
      this.setFriendState(this._friendInfoUpdater.state);
    }

    protected function createUidLabel() : void {
      this._uidLabel = new LabelBase();
      this._uidLabel.x = RANK_ICON_CONT_WIDTH - 2 + this.getAdditionalIconsWidth();
      this.shadowContainer.addChild(this._uidLabel);
      this._uidLabel.visible = false;
    }

    protected function getAdditionalIconsWidth() : Number {
      return 0;
    }

    private function createRankIcon() : void {
      var local1:Sprite = new Sprite();
      local1.graphics.clear();
      local1.graphics.beginFill(65535,0);
      local1.graphics.drawRect(0,0,RANK_ICON_CONT_WIDTH,RANK_ICON_CONT_HEIGHT);
      local1.graphics.endFill();
      this._rankIcon = new SmallRankIcon();
      local1.addChild(this._rankIcon);
      this.shadowContainer.addChild(local1);
      this._rankIcon.visible = false;
    }

    private function onAddedToStage(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      this.setEvent();
      this._userInfoUpdater.incrementVisibleLabelsCounter();
      this._friendInfoUpdater.incrementVisibleLabelsCounter();
    }

    private function onRemoveFromStage(param1:Event) : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      this.removeEvent();
      this._userInfoUpdater.decrementVisibleLabelsCounter();
      this._friendInfoUpdater.decrementVisibleLabelsCounter();
    }

    private function setEvent() : void {
      if(!this.hasEventListener(MouseEvent.CLICK)) {
        this.addEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      this._userInfoUpdater.addEventListener(UserInfoLabelUpdaterEvent.CHANGE_ONLINE,this.onChangeOnline);
      this._userInfoUpdater.addEventListener(UserInfoLabelUpdaterEvent.CHANGE_UID,this.onChangeUid);
      this._userInfoUpdater.addEventListener(UserInfoLabelUpdaterEvent.CHANGE_RANK,this.onChangeRank);
      premiumService.addEventListener(Event.CHANGE,this.onChangePremiumStatus);
      this._friendInfoUpdater.addEventListener(FriendInfoLabelUpdaterEvent.CHANGE_STATE,this.onChangeFriendState);
    }

    private function removeEvent() : void {
      if(this.hasEventListener(MouseEvent.CLICK)) {
        this.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      this._userInfoUpdater.removeEventListener(UserInfoLabelUpdaterEvent.CHANGE_ONLINE,this.onChangeOnline);
      this._userInfoUpdater.removeEventListener(UserInfoLabelUpdaterEvent.CHANGE_UID,this.onChangeUid);
      this._userInfoUpdater.removeEventListener(UserInfoLabelUpdaterEvent.CHANGE_RANK,this.onChangeRank);
      premiumService.removeEventListener(Event.CHANGE,this.onChangePremiumStatus);
      this._friendInfoUpdater.removeEventListener(FriendInfoLabelUpdaterEvent.CHANGE_STATE,this.onChangeFriendState);
    }

    protected function onMouseClick(param1:MouseEvent) : void {
      var local2:Boolean = false;
      var local3:Boolean = false;
      var local4:Boolean = false;
      var local5:Boolean = false;
      if(userPropertiesService.userId == this._userId) {
        return;
      }
      if(!this._isInitRank || !this._isInitUid) {
        return;
      }
      if(param1.ctrlKey) {
        System.setClipboard(this._uid);
      } else {
        switch(this._friendState) {
          case FriendState.ACCEPTED:
            local3 = true;
            break;
          case FriendState.INCOMING:
            local4 = true;
            local5 = true;
            break;
          default:
            local2 = true;
        }
        contextMenuService.show(this._userId,this._rank,this._uid,local2,local3,local4,local5,this._writeInPublicChat,this._writePrivateInChat,this._blockUserEnable,this._inviteBattleEnable,this._focusOnUserEnabled,this._showClanProfile,this._showInviteToClan);
      }
    }

    private function onChangeOnline(param1:UserInfoLabelUpdaterEvent) : void {
      this.updateStatusOnline();
    }

    private function updateStatusOnline() : void {
      this._online = this._userInfoUpdater.online;
    }

    private function onChangeUid(param1:UserInfoLabelUpdaterEvent) : void {
      this.setUid(this._userInfoUpdater.uid);
    }

    protected function setUid(param1:String) : void {
      if(!this._isInitUid) {
        this._isInitUid = true;
        this._uidLabel.visible = true;
      }
      this._uid = param1;
      var local2:String = this.getUidWithClanTag(this._uid);
      var local3:String = local2 + this._additionalText;
      if(this._uidLabel.htmlText == local3) {
        return;
      }
      // Narukami ext-color-names - use HTML text for label
      this._uidLabel.htmlText = local3;
      dispatchEvent(new ChatUpdateEvent(ChatUpdateEvent.UPDATE,true));
    }

    public function getUidWithClanTag(param1:String) : String {
      var local2:UserClanInfo = clanUserInfoService.userClanInfoByUserId(this.userId);
      var local3:String = "";
      if(this._showClanTag && local2 != null && local2.isInClan) {
        local3 = "[" + local2.clanTag + "] ";
      }
      return local3 + param1;
    }

    public function setAdditionalText(param1:String) : void {
      if(this._additionalText == param1) {
        return;
      }
      this._additionalText = param1;
      this.setUid(this._uid);
    }

    private function onChangeRank(param1:UserInfoLabelUpdaterEvent) : void {
      this.setRank(this._userInfoUpdater.rank);
    }

    private function onChangePremiumStatus(param1:Event = null) : void {
      this.updateProperties();
    }

    protected function setRank(param1:int) : void {
      this._rank = param1;
      this.updateStatusPremium();
      if(!this._isInitRank) {
        this._isInitRank = true;
        this._rankIcon.init(this._hasPremium,this._rank);
        this._rankIcon.visible = true;
      } else if(this._hasPremium) {
        this._rankIcon.setPremium(this._rank);
      } else {
        this._rankIcon.setRank(this._rank);
      }
      this.alignRankIcon();
    }

    protected function updateStatusPremium() : void {
      if(this._self) {
        this._hasPremium = premiumService.hasPremium();
      } else {
        this._hasPremium = battlePremiumService.hasUserPremium(this._userId);
      }
    }

    private function alignRankIcon() : void {
      this._rankIcon.x = RANK_ICON_CONT_WIDTH - this._rankIcon.width >> 1;
      this._rankIcon.y = RANK_ICON_CONT_HEIGHT - this._rankIcon.height >> 1;
    }

    private function onChangeFriendState(param1:FriendInfoLabelUpdaterEvent) : void {
      this.setFriendState(this._friendInfoUpdater.state);
    }

    protected function setFriendState(param1:FriendState) : void {
      this._friendState = param1;
      this.refreshFriendState();
    }

    protected function refreshFriendState() : void {
      // Narukami ext-color-names - disable client-side colorization if label contains HTML tags
      if(this._uid != null && this._uid.indexOf("<") != -1) {
        return;
      }
      if(groupInfoService.hasGroups()) {
        if(this.inSameGroup && !this._self) {
          this._uidLabel.color = ColorConstants.FRIEND_COLOR;
        }
        return;
      }
      if(!this._ignoreFriendsColor) {
        if(this._friendState == FriendState.ACCEPTED) {
          this._uidLabel.color = ColorConstants.FRIEND_COLOR;
          return;
        }
        this._uidLabel.color = this._lastUidColor;
      }
    }

    public function setUidColor(param1:uint, param2:Boolean = false) : void {
      // Narukami ext-color-names - disable client-side colorization if label contains HTML tags
      if(this._uid != null && this._uid.indexOf("<") != -1) {
        return;
      }
      this._lastUidColor = param1;
      this._ignoreFriendsColor = param2;
      this._uidLabel.color = param1;
      this.refreshFriendState();
    }

    public function get online() : Boolean {
      return this._online;
    }

    public function get userRank() : int {
      return this._rank;
    }

    public function get self() : Boolean {
      return this._self;
    }

    public function get uid() : String {
      return this._uid;
    }

    public function get userId() : Long {
      return this._userId;
    }

    public function get inviteBattleEnable() : Boolean {
      return this._inviteBattleEnable;
    }

    public function set inviteBattleEnable(param1:Boolean) : void {
      this._inviteBattleEnable = param1;
    }

    public function get premium() : Boolean {
      return this._hasPremium;
    }

    public function get showClanProfile() : Boolean {
      return this._showClanProfile;
    }

    public function set showClanProfile(param1:Boolean) : void {
      this._showClanProfile = param1;
    }

    public function get showInviteToClan() : Boolean {
      return this._showInviteToClan;
    }

    public function set showInviteToClan(param1:Boolean) : void {
      this._showInviteToClan = param1;
    }
  }
}
