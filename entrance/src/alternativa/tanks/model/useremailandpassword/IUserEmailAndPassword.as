package alternativa.tanks.model.useremailandpassword {
  [ModelInterface]
  public interface IUserEmailAndPassword {
    function changeEmail(param1:String) : void;
    function getEmail() : String;
    function sendChangeInstruction() : void;
  }
}
