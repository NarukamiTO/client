package alternativa.tanks.servermodels.loginbyhash {
  [ModelInterface]
  public interface ILoginByHash {
    function loginByHash(param1:String) : void;
    function loginBySingleUseHash(param1:String) : void;
  }
}
