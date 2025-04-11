package projects.tanks.client.entrance.model.entrance.passwordchange {
  public interface IPasswordChangeModelBase {
    function emailNotFound() : void;
    function emailWithRestoreLinkSuccessfullySent() : void;
    function passwordRecoveryHashCorrect(param1:String) : void;
    function passwordRecoveryHashWrong() : void;
    function setPasswordChangeResult(param1:Boolean, param2:String) : void;
  }
}
