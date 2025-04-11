package alternativa.tanks.view.mainview.groupinvite {
  import alternativa.tanks.gui.friends.list.dataprovider.FriendsDataProvider;
  import alternativa.tanks.service.socialnetwork.vk.SNFriendsService;
  import alternativa.tanks.service.socialnetwork.vk.SNFriendsServiceData;
  import alternativa.tanks.service.socialnetwork.vk.SNFriendsServiceEvent;
  import alternativa.types.Long;
  import fl.controls.List;
  import flash.display.Sprite;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle.BattleLinkData;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.online.ClientOnlineNotifierData;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.matchmakinggroup.MatchmakingGroupService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.IBattleNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.LeaveBattleNotifierServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle.SetBattleNotifierServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.IOnlineNotifierService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.online.OnlineNotifierServiceEvent;
  import utils.ScrollStyleUtils;

  public class InviteToGroupList extends Sprite {
    [Inject]
    public static var friendInfoService:IFriendInfoService;

    [Inject]
    public static var onlineNotifierService:IOnlineNotifierService;

    [Inject]
    public static var battleNotifierService:IBattleNotifierService;

    [Inject]
    public static var snFriendsService:SNFriendsService;

    [Inject]
    public static var matchmakingGroupService:MatchmakingGroupService;

    protected var header:InviteHeader;
    protected var list:List;
    protected var dataProvider:FriendsDataProvider;
    protected var listWidth:Number;
    protected var listHeight:Number;

    public function InviteToGroupList() {
      super();
      this.header = new InviteHeader();
      addChild(this.header);
      this.dataProvider = new FriendsDataProvider();
      this.dataProvider.sortOn([FriendsDataProvider.ONLINE,FriendsDataProvider.UID],[Array.NUMERIC | Array.DESCENDING,Array.CASEINSENSITIVE]);
      this.list = new List();
      this.list.rowHeight = 20;
      this.list.setStyle("cellRenderer",GroupInviteListRenderer);
      this.list.focusEnabled = true;
      this.list.selectable = false;
      this.list.dataProvider = this.dataProvider;
      ScrollStyleUtils.setGreenStyle(this.list);
      addChild(this.list);
    }

    protected function onInviteUser(param1:InviteUserEvent) : void {
      matchmakingGroupService.inviteUserToGroup(param1.getUserId());
    }

    public function init() : void {
      this.list.addEventListener(InviteUserEvent.TYPE,this.onInviteUser);
      snFriendsService.addEventListener(SNFriendsServiceEvent.GET_FRIENDS_COMPLETED,this.onGetFriends);
      onlineNotifierService.addEventListener(OnlineNotifierServiceEvent.SET_ONLINE,this.onSetOnline);
      battleNotifierService.addEventListener(SetBattleNotifierServiceEvent.SET_BATTLE,this.onSetBattle);
      battleNotifierService.addEventListener(LeaveBattleNotifierServiceEvent.LEAVE,this.onLeaveBattle);
      snFriendsService.requestFriends();
    }

    private function onGetFriends(param1:SNFriendsServiceEvent) : void {
      var local4:Object = null;
      var local2:SNFriendsServiceData = param1.getResult();
      var local3:int = 0;
      while(local3 < this.dataProvider.length) {
        local4 = this.dataProvider.getItemAt(local3);
        if(local4.snUid != "") {
          this.dataProvider.setPropertiesById(local4.id,"isSNFriend",local2.areFriends(local4.snUid));
        }
        local3++;
      }
    }

    public function resize(param1:Number, param2:Number) : void {
      this.listWidth = param1;
      this.listHeight = param2;
      this.header.width = this.listWidth;
      this.list.y = 20;
      var local3:Boolean = this.list.verticalScrollBar.visible;
      this.list.width = local3 ? this.listWidth + 6 : this.listWidth;
      this.list.height = this.listHeight - 20;
    }

    public function filter(param1:String, param2:String) : void {
      this.filterByProperty(param1,param2);
    }

    protected function onSetOnline(param1:OnlineNotifierServiceEvent) : void {
      var local6:int = 0;
      var local2:Boolean = false;
      var local3:Vector.<ClientOnlineNotifierData> = param1.users;
      var local4:int = int(local3.length);
      var local5:int = 0;
      while(local5 < local4) {
        local6 = this.dataProvider.setOnlineUser(local3[local5],false);
        local2 ||= local6 != -1;
        local5++;
      }
      if(local2) {
        this.dataProvider.reSort();
      }
    }

    protected function onSetBattle(param1:SetBattleNotifierServiceEvent) : void {
      var local6:int = 0;
      var local2:Boolean = false;
      var local3:Vector.<BattleLinkData> = param1.users;
      var local4:int = int(local3.length);
      var local5:int = 0;
      while(local5 < local4) {
        local6 = this.dataProvider.setBattleUser(local3[local5],false);
        local2 ||= local6 != -1;
        local5++;
      }
      if(local2 > 0) {
        this.dataProvider.reSort();
      }
    }

    protected function onLeaveBattle(param1:LeaveBattleNotifierServiceEvent) : void {
      this.dataProvider.clearBattleUser(param1.userId);
    }

    protected function filterByProperty(param1:String, param2:String) : void {
      this.dataProvider.setFilter(param1,param2);
      this.resize(this.listWidth,this.listHeight);
    }

    public function hide() : void {
      this.list.removeEventListener(InviteUserEvent.TYPE,this.onInviteUser);
      snFriendsService.removeEventListener(SNFriendsServiceEvent.GET_FRIENDS_COMPLETED,this.onGetFriends);
      onlineNotifierService.removeEventListener(OnlineNotifierServiceEvent.SET_ONLINE,this.onSetOnline);
      battleNotifierService.removeEventListener(SetBattleNotifierServiceEvent.SET_BATTLE,this.onSetBattle);
      battleNotifierService.removeEventListener(LeaveBattleNotifierServiceEvent.LEAVE,this.onLeaveBattle);
      if(parent != null && parent.contains(this)) {
        parent.removeChild(this);
        this.dataProvider.removeAll();
      }
    }

    public function fillList(param1:Vector.<Long>) : void {
      var local2:Long = null;
      this.dataProvider.removeAll();
      this.dataProvider.resetFilter(false);
      for each(local2 in param1) {
        this.dataProvider.addUser(local2,false);
      }
      this.dataProvider.refresh();
    }

    public function removeUser(param1:Long) : void {
      this.dataProvider.removeUser(param1);
    }
  }
}
