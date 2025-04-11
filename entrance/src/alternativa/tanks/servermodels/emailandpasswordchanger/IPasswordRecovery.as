package alternativa.tanks.servermodels.emailandpasswordchanger {
  [ModelInterface]
  public interface IPasswordRecovery {
    function startEmailAndPasswordChangeProcess(param1:String) : void;
    function sendUsersRestorePasswordLink(param1:String) : void;
    function changePasswordAndEmail(param1:String, param2:String) : void;
  }
}
