package projects.tanks.client.entrance.model.entrance.registration {
  public interface IRegistrationModelBase {
    function anchorRegistration() : void;
    function enteredUidIsBusy(param1:Vector.<String>) : void;
    function enteredUidIsFree() : void;
    function enteredUidIsIncorrect() : void;
    function passwordIsIncorrect() : void;
    function registrationFailed() : void;
  }
}
