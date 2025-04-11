package alternativa.tanks.servermodels.invite {
  import alternativa.tanks.service.IEntranceClientFacade;
  import platform.client.fp10.core.model.IObjectLoadListener;
  import projects.tanks.client.entrance.model.entrance.invite.IInviteEntranceModelBase;
  import projects.tanks.client.entrance.model.entrance.invite.InviteEntranceModelBase;

  [ModelInfo]
  public class InviteModel extends InviteEntranceModelBase implements IInviteEntranceModelBase, IInvite, IObjectLoadListener {
    [Inject]
    public static var clientFacade:IEntranceClientFacade;

    public function InviteModel() {
      super();
    }

    public function objectLoaded() : void {
      clientFacade.inviteEnabled = getInitParam().enabled;
    }

    public function inviteNotFound() : void {
      clientFacade.inviteNotFound();
    }

    public function inviteFree() : void {
      clientFacade.inviteIsFree();
    }

    public function inviteAlreadyActivated(param1:String) : void {
      clientFacade.inviteAlreadyActivated(param1);
    }

    public function checkInvite(param1:String) : void {
      server.activateInvite(param1);
    }

    public function objectLoadedPost() : void {
    }

    public function objectUnloaded() : void {
    }

    public function objectUnloadedPost() : void {
    }
  }
}
