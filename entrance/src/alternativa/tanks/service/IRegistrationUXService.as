package alternativa.tanks.service {
  import flash.events.IEventDispatcher;
  import projects.tanks.client.entrance.model.entrance.logging.RegistrationUXFormAction;
  import projects.tanks.client.entrance.model.entrance.logging.RegistrationUXScreen;

  public interface IRegistrationUXService extends IEventDispatcher {
    function logFormAction(param1:RegistrationUXFormAction) : void;
    function logCountableFormAction(param1:RegistrationUXFormAction, param2:int) : void;
    function logNavigationStart(param1:RegistrationUXScreen) : void;
    function logNavigationFinish() : void;
  }
}
