package projects.tanks.client.panel.model.profile.useremailpassword {
  public interface IUserEmailAndPasswordModelBase {
    function activateMessage(param1:String) : void;
    function emailAlreadyUsed() : void;
    function emailConfirmed(param1:String) : void;
    function incorrectEmail() : void;
    function notifyCorrectPassword() : void;
    function notifyIncorrectPassword() : void;
    function notifyPasswordIsNotSet() : void;
    function notifyPasswordIsSet() : void;
    function passwordChanged() : void;
    function updatePasswordError() : void;
  }
}
