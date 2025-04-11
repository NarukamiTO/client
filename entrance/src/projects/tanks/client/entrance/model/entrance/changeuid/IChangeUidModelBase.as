package projects.tanks.client.entrance.model.entrance.changeuid {
  public interface IChangeUidModelBase {
    function parametersIncorrect() : void;
    function passwordIncorrect() : void;
    function startChangingUid() : void;
    function startChangingUidViaPartner() : void;
    function uidChanged() : void;
    function uidIncorrect() : void;
  }
}
