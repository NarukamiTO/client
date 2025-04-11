package alternativa.tanks.servermodels.socialnetwork {
  [ModelInterface]
  public interface IExternalEntranceModel {
    function startExternalRegisterUser(param1:String, param2:Boolean, param3:String) : void;
    function startExternalLoginUser(param1:String, param2:Boolean, param3:String) : void;
    function finishExternalRegisterUser(param1:String, param2:String) : void;
    function login(param1:String, param2:String) : void;
  }
}
