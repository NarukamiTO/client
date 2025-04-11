package alternativa.tanks.servermodels.registartion.password {
  [ModelInterface]
  public interface IPasswordRegistration {
    function register(param1:String, param2:String, param3:String, param4:Boolean, param5:String, param6:String, param7:String) : void;
    function checkCallsign(param1:String) : void;
  }
}
