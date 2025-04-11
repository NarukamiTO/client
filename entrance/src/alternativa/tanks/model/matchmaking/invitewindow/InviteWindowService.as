package alternativa.tanks.model.matchmaking.invitewindow {
  import alternativa.tanks.view.mainview.groupinvite.GroupInviteWindow;

  public interface InviteWindowService {
    function getInviteWindow() : GroupInviteWindow;
    function setInviteWindow(param1:GroupInviteWindow) : void;
  }
}
