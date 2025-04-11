package projects.tanks.client.entrance.model.entrance.loginbyhash {
  public interface ILoginByHashModelBase {
    function loginByHashFailed() : void;
    function loginBySingleUseHashFailed() : void;
    function rememberAccount(param1:String) : void;
    function rememberUsersHash(param1:String) : void;
  }
}
