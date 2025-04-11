package alternativa.tanks.servermodels.emailconfirm {
  import alternativa.tanks.service.IEntranceClientFacade;
  import projects.tanks.client.entrance.model.entrance.emailconfirm.ConfirmEmailStatus;
  import projects.tanks.client.entrance.model.entrance.emailconfirm.EmailConfirmModelBase;
  import projects.tanks.client.entrance.model.entrance.emailconfirm.IEmailConfirmModelBase;

  [ModelInfo]
  public class EmailConfirmModel extends EmailConfirmModelBase implements IEmailConfirmModelBase, IEmailConfirm {
    [Inject]
    public static var clientFacade:IEntranceClientFacade;

    public function EmailConfirmModel() {
      super();
    }

    public function confirmEmailStatus(param1:ConfirmEmailStatus) : void {
      clientFacade.confirmEmailStatus(param1);
    }

    public function startEmailConfirm(param1:String, param2:String) : void {
      server.confirmEmail(param2,param1);
    }
  }
}
