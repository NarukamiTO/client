package alternativa.tanks.model.matchmaking.invitewindow {
  import alternativa.tanks.controllers.mathmacking.ShowGroupInviteWindowEvent;
  import alternativa.tanks.gui.friends.FriendsWindowState;
  import alternativa.tanks.service.matchmaking.MatchmakingGroupInviteService;
  import alternativa.tanks.view.mainview.groupinvite.GroupInviteWindow;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battleselect.model.matchmaking.group.invitewindow.GroupInviteWindowModelBase;
  import projects.tanks.client.battleselect.model.matchmaking.group.invitewindow.IGroupInviteWindowModelBase;
  import projects.tanks.client.battleselect.model.matchmaking.group.invitewindow.MatchMakingUserInfo;

  [ModelInfo]
  public class GroupInviteWindowModel extends GroupInviteWindowModelBase implements IGroupInviteWindowModelBase, ObjectLoadPostListener, ObjectUnloadListener {
    [Inject]
    public static var inviteService:MatchmakingGroupInviteService;

    [Inject]
    public static var inviteWindowService:InviteWindowService;

    private var window:GroupInviteWindow;

    public function GroupInviteWindowModel() {
      super();
    }

    public function objectLoadedPost() : void {
      this.window = new GroupInviteWindow();
      inviteWindowService.setInviteWindow(this.window);
      inviteService.addEventListener(ShowGroupInviteWindowEvent.TYPE,getFunctionWrapper(this.onShowInviteWindow));
    }

    private function onShowInviteWindow(param1:ShowGroupInviteWindowEvent) : void {
      server.prepareToShow();
    }

    public function show(param1:Vector.<Long>, param2:Vector.<Long>) : void {
      this.window.setAllowedUsers(param1,param2);
      this.window.show(FriendsWindowState.ACCEPTED);
    }

    public function objectUnloaded() : void {
      this.window.destroy();
      inviteWindowService.setInviteWindow(null);
      this.window = null;
      inviteService.removeEventListener(ShowGroupInviteWindowEvent.TYPE,getFunctionWrapper(this.onShowInviteWindow));
    }

    public function setAvailableToInviteUsers(param1:Vector.<MatchMakingUserInfo>) : void {
    }
  }
}
