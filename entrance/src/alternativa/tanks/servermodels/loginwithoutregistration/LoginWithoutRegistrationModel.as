package alternativa.tanks.servermodels.loginwithoutregistration {
  import projects.tanks.client.entrance.model.entrance.loginwithoutregistration.ILoginWithoutRegistrationModelBase;
  import projects.tanks.client.entrance.model.entrance.loginwithoutregistration.LoginWithoutRegistrationModelBase;

  [ModelInfo]
  public class LoginWithoutRegistrationModel extends LoginWithoutRegistrationModelBase implements ILoginWithoutRegistration, ILoginWithoutRegistrationModelBase {
    public function LoginWithoutRegistrationModel() {
      super();
    }

    public function passToFirstBattle() : void {
      server.loginWithoutRegistration();
    }
  }
}
