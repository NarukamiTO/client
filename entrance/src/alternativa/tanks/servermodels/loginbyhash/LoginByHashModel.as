package alternativa.tanks.servermodels.loginbyhash {
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.tanks.service.IEntranceClientFacade;
  import flash.net.SharedObject;
  import mx.utils.StringUtil;
  import projects.tanks.client.entrance.model.entrance.loginbyhash.ILoginByHashModelBase;
  import projects.tanks.client.entrance.model.entrance.loginbyhash.LoginByHashModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  [ModelInfo]
  public class LoginByHashModel extends LoginByHashModelBase implements ILoginByHash, ILoginByHashModelBase {
    [Inject]
    public static var clientFacade:IEntranceClientFacade;

    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var launcherParams:ILauncherParams;

    public function LoginByHashModel() {
      super();
    }

    public function loginBySingleUseHash(param1:String) : void {
      launcherParams.removeParameter("singleUseHash");
      server.loginBySingleUseHash(param1);
    }

    public function loginByHash(param1:String) : void {
      server.loginByHash(param1);
    }

    public function loginBySingleUseHashFailed() : void {
      this.goToLoginHashFailed();
    }

    public function loginByHashFailed() : void {
      this.goToLoginHashFailed();
    }

    private function goToLoginHashFailed() : void {
      var local1:SharedObject = storageService.getStorage();
      var local2:SharedObject = storageService.getAccountsStorage();
      if(Boolean(local2.data[local1.data.userName])) {
        delete local2.data[local1.data.userName];
        local2.flush();
      }
      local1.data.userHash = null;
      clientFacade.goToLoginFormWithHashError();
    }

    public function rememberUsersHash(param1:String) : void {
      var local2:SharedObject = storageService.getStorage();
      local2.data.userHash = param1;
      local2.flush();
    }

    public function rememberAccount(param1:String) : void {
      var local5:String = null;
      this.rememberUsersHash(param1);
      var local2:SharedObject = storageService.getStorage();
      if(StringUtil.trim(local2.data.userName).length == 0) {
        return;
      }
      var local3:SharedObject = storageService.getAccountsStorage();
      var local4:Object = {};
      for(local5 in local2.data) {
        local4[local5] = local2.data[local5];
      }
      local3.data[local2.data.userName] = local4;
      local3.flush();
    }
  }
}
