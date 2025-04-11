package alternativa.tanks.gui.friends.list {
  import alternativa.tanks.gui.friends.IFriendsListState;
  import alternativa.tanks.gui.friends.list.dataprovider.FriendsDataProvider;
  import alternativa.tanks.gui.friends.list.renderer.ClanMembersListRenderer;
  import alternativa.tanks.gui.friends.list.renderer.HeaderAcceptedList;
  import alternativa.tanks.service.clan.ClanFriendsService;
  import alternativa.tanks.service.clan.ClanMembersListEvent;
  import alternativa.types.Long;
  import fl.controls.List;
  import flash.display.Sprite;
  import flash.utils.Dictionary;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle.BattleLinkData;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.online.ClientOnlineNotifierData;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.BattleInfoServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.BattleInviteServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.IBattleNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.LeaveBattleNotifierServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.SetBattleNotifierServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.IOnlineNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.OnlineNotifierServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import services.contextmenu.ContextMenuServiceEvent;
  import services.contextmenu.IContextMenuService;
  import utils.ScrollStyleUtils;

  public class ClanMembersList extends Sprite implements IFriendsListState {
    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var contextMenuService:IContextMenuService;

    [Inject]
    public static var onlineNotifierService:IOnlineNotifierService;

    [Inject]
    public static var battleNotifierService:IBattleNotifierService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var battleInviteService:IBattleInviteService;

    [Inject]
    public static var clanFriendsService:ClanFriendsService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;
    public static var scrollOn:Boolean;

    private var _header:HeaderAcceptedList;

    protected var _dataProvider:FriendsDataProvider;
    protected var _list:List;
    protected var _width:Number;
    protected var _height:Number;
    protected var _viewed:Dictionary;

    public function ClanMembersList() {
      super();
      this.init(ClanMembersListRenderer);
      this._dataProvider.getItemAtHandler = this.markAsViewed;
      this._header = new HeaderAcceptedList();
      addChild(this._header);
    }

    public function initList() : void {
      clanFriendsService.addEventListener(ClanMembersListEvent.ACCEPTED_USER,this.onClanMemberAccepted);
      clanFriendsService.addEventListener(ClanMembersListEvent.REMOVE_USER,this.onClanMemberRemoved);
      contextMenuService.addEventListener(ContextMenuServiceEvent.REMOVE_FROM_FRIENDS,this.onRemoveFromFriends);
      onlineNotifierService.addEventListener(OnlineNotifierServiceEvent.SET_ONLINE,this.onSetOnline);
      battleNotifierService.addEventListener(SetBattleNotifierServiceEvent.SET_BATTLE,this.onSetBattle);
      battleNotifierService.addEventListener(LeaveBattleNotifierServiceEvent.LEAVE,this.onLeaveBattle);
      battleInfoService.addEventListener(BattleInfoServiceEvent.SELECTION_BATTLE,this.onSelectBattleInfo);
      battleInfoService.addEventListener(BattleInfoServiceEvent.RESET_SELECTION_BATTLE,this.onResetSelectBattleInfo);
      battleInviteService.addEventListener(BattleInviteServiceEvent.REMOVE_INVITE,this.onRemoveInvite);
      this._dataProvider.sortOn([FriendsDataProvider.IS_NEW,FriendsDataProvider.ONLINE,FriendsDataProvider.IS_BATTLE,FriendsDataProvider.UID],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING,Array.CASEINSENSITIVE]);
      this.fillMembersList();
      this._list.scrollToIndex(0);
      this.resize(this._width,this._height);
    }

    private function onClanMemberAccepted(param1:ClanMembersListEvent) : void {
      this._dataProvider.addUser(param1.userId);
      this.resize(this._width,this._height);
    }

    private function onClanMemberRemoved(param1:ClanMembersListEvent) : void {
      if(this._dataProvider.getItemIndexByProperty("id",param1.userId,true) != -1) {
        this._dataProvider.removeUser(param1.userId);
        this.resize(this._width,this._height);
      }
    }

    private function onRemoveFromFriends(param1:ContextMenuServiceEvent) : void {
      this._dataProvider.removeUser(param1.userId);
      this.resize(this._width,this._height);
    }

    private function onSetOnline(param1:OnlineNotifierServiceEvent) : void {
      var local6:int = 0;
      var local2:Boolean = false;
      var local3:Vector.<ClientOnlineNotifierData> = param1.users;
      var local4:int = int(local3.length);
      var local5:int = 0;
      while(local5 < local4) {
        local6 = this._dataProvider.setOnlineUser(local3[local5],false);
        local2 ||= local6 != -1;
        local5++;
      }
      if(local2) {
        this._dataProvider.reSort();
      }
    }

    private function onSetBattle(param1:SetBattleNotifierServiceEvent) : void {
      var local6:int = 0;
      var local2:Boolean = false;
      var local3:Vector.<BattleLinkData> = param1.users;
      var local4:int = int(local3.length);
      var local5:int = 0;
      while(local5 < local4) {
        local6 = this._dataProvider.setBattleUser(local3[local5],false);
        local2 ||= local6 != -1;
        local5++;
      }
      if(local2 > 0) {
        this._dataProvider.reSort();
      }
    }

    private function onLeaveBattle(param1:LeaveBattleNotifierServiceEvent) : void {
      this._dataProvider.clearBattleUser(param1.userId);
    }

    private function onResetSelectBattleInfo(param1:BattleInfoServiceEvent) : void {
      this._dataProvider.updatePropertyAvailableInvite();
    }

    private function onSelectBattleInfo(param1:BattleInfoServiceEvent) : void {
      this._dataProvider.updatePropertyAvailableInvite();
    }

    private function onRemoveInvite(param1:BattleInviteServiceEvent) : void {
      this._dataProvider.updatePropertyAvailableInviteById(param1.userId);
    }

    public function resize(param1:Number, param2:Number) : void {
      this._width = param1;
      this._height = param2;
      this._header.width = this._width;
      this._list.y = 20;
      scrollOn = this._list.verticalScrollBar.visible;
      this._list.width = scrollOn ? this._width + 6 : this._width;
      this._list.height = this._height - 20;
    }

    public function hide() : void {
      clanFriendsService.removeEventListener(ClanMembersListEvent.ACCEPTED_USER,this.onClanMemberAccepted);
      clanFriendsService.removeEventListener(ClanMembersListEvent.REMOVE_USER,this.onClanMemberRemoved);
      contextMenuService.removeEventListener(ContextMenuServiceEvent.REMOVE_FROM_FRIENDS,this.onRemoveFromFriends);
      onlineNotifierService.removeEventListener(OnlineNotifierServiceEvent.SET_ONLINE,this.onSetOnline);
      battleNotifierService.removeEventListener(SetBattleNotifierServiceEvent.SET_BATTLE,this.onSetBattle);
      battleNotifierService.removeEventListener(LeaveBattleNotifierServiceEvent.LEAVE,this.onLeaveBattle);
      battleInfoService.removeEventListener(BattleInfoServiceEvent.SELECTION_BATTLE,this.onSelectBattleInfo);
      battleInfoService.removeEventListener(BattleInfoServiceEvent.RESET_SELECTION_BATTLE,this.onResetSelectBattleInfo);
      battleInviteService.removeEventListener(BattleInviteServiceEvent.REMOVE_INVITE,this.onRemoveInvite);
      if(parent != null && parent.contains(this)) {
        parent.removeChild(this);
        this._dataProvider.removeAll();
      }
    }

    public function filter(param1:String, param2:String) : void {
      this.filterByProperty(param1,param2);
      this.resize(this._width,this._height);
    }

    public function resetFilter() : void {
      this._dataProvider.resetFilter();
      this.resize(this._width,this._height);
    }

    private function init(param1:Object) : void {
      this._viewed = new Dictionary();
      this._list = new List();
      this._list.rowHeight = 20;
      this._list.setStyle("cellRenderer",param1);
      this._list.focusEnabled = true;
      this._list.selectable = false;
      ScrollStyleUtils.setGreenStyle(this._list);
      this._dataProvider = new FriendsDataProvider();
      this._list.dataProvider = this._dataProvider;
      addChild(this._list);
      ScrollStyleUtils.setGreenStyle(this._list);
    }

    private function isViewed(param1:Object) : Boolean {
      return param1 in this._viewed;
    }

    private function setAsViewed(param1:Object) : void {
      this._viewed[param1] = true;
    }

    private function fillMembersList() : void {
      var local1:Long = null;
      this._dataProvider.removeAll();
      this._dataProvider.resetFilter(false);
      for each(local1 in clanFriendsService.clanMembers) {
        if(local1 != userPropertiesService.userId) {
          this._dataProvider.addUser(local1,false);
        }
      }
      this._dataProvider.refresh();
    }

    private function filterByProperty(param1:String, param2:String) : void {
      this._dataProvider.setFilter(param1,param2);
      this.resize(this._width,this._height);
    }

    private function markAsViewed(param1:Object) : void {
      if(!this.isViewed(param1) && Boolean(param1.isNew)) {
        this.setAsViewed(param1);
      }
    }
  }
}
