package projects.tanks.client.entrance.model.entrance.partners {
  import platform.client.fp10.core.type.IGameObject;

  public interface ICompositePartnerModelBase {
    function linkAlreadyExists() : void;
    function loginFailed() : void;
    function setPartnerObject(param1:IGameObject) : void;
    function showTutorial() : void;
    function startPartnerRegistration() : void;
    function wrongPassword() : void;
  }
}
