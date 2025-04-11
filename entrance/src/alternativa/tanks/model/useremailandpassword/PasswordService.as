package alternativa.tanks.model.useremailandpassword {
  [ModelInterface]
  public interface PasswordService {
    function checkIsPasswordSet(param1:Function) : void;
    function checkPassword(param1:String, param2:Function) : void;
    function setPassword(param1:String) : void;
    function updatePassword(param1:String, param2:String) : void;
  }
}
