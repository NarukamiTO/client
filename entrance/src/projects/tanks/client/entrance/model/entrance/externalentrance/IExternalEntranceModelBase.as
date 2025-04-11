package projects.tanks.client.entrance.model.entrance.externalentrance {
  public interface IExternalEntranceModelBase {
    function linkAlreadyExists() : void;
    function validationFailed() : void;
    function validationSuccess() : void;
    function wrongPassword() : void;
  }
}
