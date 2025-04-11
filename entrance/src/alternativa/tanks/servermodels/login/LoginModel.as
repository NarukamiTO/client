package alternativa.tanks.servermodels.login {
  import alternativa.tanks.service.IEntranceClientFacade;
  import projects.tanks.client.entrance.model.entrance.login.ILoginModelBase;
  import projects.tanks.client.entrance.model.entrance.login.LoginModelBase;
  import projects.tanks.client.entrance.model.entrance.login.LoginModelServer;

  [ModelInfo]
  public class LoginModel extends LoginModelBase implements ILogin, ILoginModelBase {
    [Inject]
    public static var entranceClientFacade:IEntranceClientFacade;

    public function LoginModel() {
      super();
    }

    public function wrongPassword() : void {
      entranceClientFacade.wrongPassword();
    }

    public function get serverInterface() : LoginModelServer {
      return server;
    }

    public function login(param1:String, param2:String, param3:Boolean) : void {
      server.login(param1,param2,param3);
    }
  }
}
