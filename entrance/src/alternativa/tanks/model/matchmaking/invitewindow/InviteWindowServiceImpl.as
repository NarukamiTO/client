package alternativa.tanks.model.matchmaking.invitewindow {
  import alternativa.tanks.view.mainview.groupinvite.GroupInviteWindow;

  public class InviteWindowServiceImpl implements InviteWindowService {
    private var window:GroupInviteWindow;

    public function InviteWindowServiceImpl() {
      super();
    }

    public function setInviteWindow(param1:GroupInviteWindow) : void {
      this.window = param1;
    }

    public function getInviteWindow() : GroupInviteWindow {
      return this.window;
    }
  }
}
