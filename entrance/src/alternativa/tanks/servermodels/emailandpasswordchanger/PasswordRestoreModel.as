package alternativa.tanks.servermodels.emailandpasswordchanger {
  import alternativa.tanks.service.IEntranceClientFacade;
  import projects.tanks.client.entrance.model.entrance.passwordchange.IPasswordChangeModelBase;
  import projects.tanks.client.entrance.model.entrance.passwordchange.PasswordChangeModelBase;

  [ModelInfo]
  public class PasswordRestoreModel extends PasswordChangeModelBase implements IPasswordRecovery, IPasswordChangeModelBase {
    [Inject]
    public static var entranceClientFacade:IEntranceClientFacade;

    private var passwordChangeHash:String;

    public function PasswordRestoreModel() {
      super();
    }

    public function sendUsersRestorePasswordLink(param1:String) : void {
      server.sendUsersRestorePasswordLink(param1);
    }

    public function changePasswordAndEmail(param1:String, param2:String) : void {
      server.changePasswordAndEmail(this.passwordChangeHash,param1,param2);
    }

    public function startEmailAndPasswordChangeProcess(param1:String) : void {
      this.passwordChangeHash = param1;
      server.checkPasswordChangeHash(param1);
    }

    public function emailWithRestoreLinkSuccessfullySent() : void {
      entranceClientFacade.emailWithRestoreLinkSuccessfullySent();
    }

    public function emailNotFound() : void {
      entranceClientFacade.emailNotFound();
    }

    public function passwordRecoveryHashCorrect(param1:String) : void {
      entranceClientFacade.goToChangePasswordAndEmailForm(param1);
    }

    public function passwordRecoveryHashWrong() : void {
      entranceClientFacade.recoveryHashIsWrong();
    }

    public function setPasswordChangeResult(param1:Boolean, param2:String) : void {
      entranceClientFacade.setPasswordChangeResult(param1,param2);
    }
  }
}
