package alternativa.tanks.gui.friends.list {
  import alternativa.tanks.gui.friends.IFriendsListState;
  import alternativa.tanks.gui.friends.IRejectAllIncomingButtonEnabled;
  import alternativa.tanks.gui.friends.list.renderer.FriendsIncomingListRenderer;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.FriendActionServiceUidEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.FriendStateChangeEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendActionService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.NewFriendEvent;
  import services.contextmenu.ContextMenuServiceEvent;
  import services.contextmenu.IContextMenuService;

  public class IncomingList extends FriendsList implements IFriendsListState {
    [Inject]
    public static var friendInfoService:IFriendInfoService;

    [Inject]
    public static var contextMenuService:IContextMenuService;

    [Inject]
    public static var friendActionService:IFriendActionService;

    private var _rejectAllIncomingButton:IRejectAllIncomingButtonEnabled;

    public function IncomingList(param1:IRejectAllIncomingButtonEnabled) {
      super();
      this._rejectAllIncomingButton = param1;
      init(FriendsIncomingListRenderer);
      _dataProvider.getItemAtHandler = this.markAsViewed;
    }

    public function initList() : void {
      friendActionService.addEventListener(FriendActionServiceUidEvent.REQUEST_ACCEPTED,this.onRequestAccepted);
      friendInfoService.addEventListener(FriendStateChangeEvent.CHANGE,this.onChangeFriendState);
      friendInfoService.addEventListener(NewFriendEvent.INCOMING_CHANGE,this.onNewFriendChange);
      contextMenuService.addEventListener(ContextMenuServiceEvent.REJECT_REQUEST,this.onRejectRequest);
      _dataProvider.sortOn(["isNew","uid"],[Array.NUMERIC | Array.DESCENDING,Array.CASEINSENSITIVE]);
      fillFriendsList(FriendState.INCOMING);
      this.updateEnableRejectButton();
      _list.scrollToIndex(0);
      resize(_width,_height);
    }

    private function updateEnableRejectButton() : void {
      this._rejectAllIncomingButton.setEnable(_dataProvider.length != 0);
    }

    private function onNewFriendChange(param1:NewFriendEvent) : void {
      _dataProvider.setUserAsNew(param1.userId);
    }

    private function markAsViewed(param1:Object) : void {
      if(!isViewed(param1) && Boolean(param1.isNew)) {
        friendInfoService.removeNewIncomingFriend(param1.id);
        setAsViewed(param1);
      }
    }

    private function onChangeFriendState(param1:FriendStateChangeEvent) : void {
      if(param1.state != FriendState.INCOMING) {
        _dataProvider.removeUser(param1.userId);
        this.updateEnableRejectButton();
        resize(_width,_height);
        return;
      }
      if(_dataProvider.getItemIndexByProperty("id",param1.userId,true) == -1) {
        _dataProvider.addUser(param1.userId);
        this.updateEnableRejectButton();
        resize(_width,_height);
      }
    }

    private function onRequestAccepted(param1:FriendActionServiceUidEvent) : * {
      _dataProvider.removeUser(param1.userId);
      this.updateEnableRejectButton();
      resize(_width,_height);
    }

    private function onRejectRequest(param1:ContextMenuServiceEvent) : void {
      _dataProvider.removeUser(param1.userId);
      this.updateEnableRejectButton();
      resize(_width,_height);
    }

    public function hide() : void {
      friendActionService.removeEventListener(FriendActionServiceUidEvent.REQUEST_ACCEPTED,this.onRequestAccepted);
      contextMenuService.removeEventListener(ContextMenuServiceEvent.REJECT_REQUEST,this.onRejectRequest);
      friendInfoService.removeEventListener(FriendStateChangeEvent.CHANGE,this.onChangeFriendState);
      friendInfoService.removeEventListener(NewFriendEvent.INCOMING_CHANGE,this.onNewFriendChange);
      if(parent.contains(this)) {
        parent.removeChild(this);
        _dataProvider.removeAll();
      }
    }

    public function filter(param1:String, param2:String) : void {
      filterByProperty(param1,param2);
      resize(_width,_height);
    }

    public function resetFilter() : void {
      _dataProvider.resetFilter();
      resize(_width,_height);
    }
  }
}
