package projects.tanks.client.entrance.model.entrance.email {
  public interface IEmailRegistrationModelBase {
    function emailDomainIsForbidden() : void;
    function emailIsBusy() : void;
    function emailIsFree() : void;
    function emailIsInvalid() : void;
    function emailWithPasswordSuccessfullySent() : void;
  }
}
