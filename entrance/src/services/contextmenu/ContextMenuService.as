package services.contextmenu {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import forms.contextmenu.ContextMenu;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendActionService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.UidUtil;

  public class ContextMenuService extends EventDispatcher implements IContextMenuService {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var friendsActionService:IFriendActionService;

    private var _contextMenu:ContextMenu;
    private var _removeFromFriendsUserId:Long;
    private var _removeFromFriendsUid:String;

    public function ContextMenuService() {
      super();
      this._contextMenu = new ContextMenu();
    }

    public function show(param1:Long, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean, param11:Boolean, param12:Boolean = false, param13:Boolean = true, param14:Boolean = true) : void {
      this._contextMenu.show(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14);
    }

    public function writeInPublic(param1:Long, param2:String) : void {
      dispatchEvent(new ContextMenuServiceEvent(ContextMenuServiceEvent.WRITE_IN_PUBLIC,param1,UidUtil.userNameWithoutClanTag(param2)));
    }

    public function writeInPrivate(param1:Long, param2:String) : void {
      dispatchEvent(new ContextMenuServiceEvent(ContextMenuServiceEvent.WRITE_IN_PRIVATE,param1,UidUtil.userNameWithoutClanTag(param2)));
    }

    public function removeFromFriends(param1:Long, param2:String) : void {
      this._removeFromFriendsUserId = param1;
      this._removeFromFriendsUid = param2;
      var local3:String = localeService.getText(TanksLocale.TEXT_FRIENDS_REMOVE_USER).replace("%USERNAME%",param2);
      alertService.showAlert(local3,Vector.<String>([localeService.getText(TanksLocale.TEXT_FRIENDS_YES),localeService.getText(TanksLocale.TEXT_FRIENDS_NO)]));
      alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onConfirmRemoveFromFriends);
    }

    private function onConfirmRemoveFromFriends(param1:AlertServiceEvent) : void {
      alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onConfirmRemoveFromFriends);
      if(param1.typeButton == localeService.getText(TanksLocale.TEXT_FRIENDS_YES)) {
        friendsActionService.breakItOff(this._removeFromFriendsUserId);
        dispatchEvent(new ContextMenuServiceEvent(ContextMenuServiceEvent.REMOVE_FROM_FRIENDS,this._removeFromFriendsUserId,this._removeFromFriendsUid));
      }
    }

    public function rejectRequest(param1:Long, param2:String) : void {
      friendsActionService.reject(param1);
      dispatchEvent(new ContextMenuServiceEvent(ContextMenuServiceEvent.REJECT_REQUEST,param1,param2));
    }

    public function acceptRequest(param1:Long, param2:String) : void {
      friendsActionService.accept(param1);
    }

    public function addToFriend(param1:Long) : void {
      friendsActionService.add(param1);
    }

    public function focusOnUser(param1:Long, param2:String) : void {
      dispatchEvent(new ContextMenuServiceEvent(ContextMenuServiceEvent.FOCUS_ON_USER,param1,param2));
    }

    public function showClan(param1:Long) : void {
      dispatchEvent(new ContextMenuServiceEvent(ContextMenuServiceEvent.SHOW_CLAN,null,null,param1));
    }

    public function voteUser(param1:Long, param2:String) : void {
      dispatchEvent(new ContextMenuServiceEvent(ContextMenuServiceEvent.VOTE_USER,param1,param2));
    }
  }
}
