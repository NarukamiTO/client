package alternativa.tanks.model.friends.loader {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.gui.friends.FriendsWindow;
  import alternativa.tanks.gui.friends.FriendsWindowState;
  import forms.events.MainButtonBarEvents;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.friends.FriendsLoaderModelBase;
  import projects.tanks.client.panel.model.friends.IFriendsLoaderModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.IFriends;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.IFriendInfoService;
  import services.buttonbar.IButtonBarService;

  [ModelInfo]
  public class FriendsLoaderModel extends FriendsLoaderModelBase implements IFriendsLoaderModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var friendInfoService:IFriendInfoService;

    [Inject]
    public static var buttonBarService:IButtonBarService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    private var friendsWindow:FriendsWindow;

    public function FriendsLoaderModel() {
      super();
    }

    public function objectLoadedPost() : void {
      if(!IFriends(object.adapt(IFriends)).isLocal()) {
        return;
      }
      if(this.friendsWindow == null) {
        this.friendsWindow = new FriendsWindow();
      }
      clanUserInfoService.updateFriendsClanButtonFunction = this.friendsWindow.updateClanButton;
      buttonBarService.addEventListener(MainButtonBarEvents.PANEL_BUTTON_PRESSED,getFunctionWrapper(this.onButtonBarButtonClick));
    }

    private function onButtonBarButtonClick(param1:MainButtonBarEvents) : void {
      if(param1.typeButton == MainButtonBarEvents.FRIENDS) {
        server.show();
      }
    }

    public function objectUnloaded() : void {
      if(!IFriends(object.adapt(IFriends)).isLocal()) {
        return;
      }
      if(this.friendsWindow != null) {
        this.friendsWindow.destroy();
        this.friendsWindow = null;
      }
      buttonBarService.removeEventListener(MainButtonBarEvents.PANEL_BUTTON_PRESSED,getFunctionWrapper(this.onButtonBarButtonClick));
    }

    public function onUsersLoaded() : void {
      if(friendInfoService.newIncomingFriendsLength > 0) {
        this.friendsWindow.show(FriendsWindowState.INCOMING);
      } else {
        this.friendsWindow.show(FriendsWindowState.ACCEPTED);
      }
    }
  }
}
