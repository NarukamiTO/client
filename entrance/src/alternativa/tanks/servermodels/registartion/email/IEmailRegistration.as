package alternativa.tanks.servermodels.registartion.email {
  [ModelInterface]
  public interface IEmailRegistration {
    function checkEmail(param1:String) : void;
    function register(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void;
  }
}
