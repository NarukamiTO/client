package alternativa.tanks.service.impl {
  import alternativa.tanks.controller.events.logging.RegistrationUXFormEvent;
  import alternativa.tanks.controller.events.logging.RegistrationUXNavigationFinishEvent;
  import alternativa.tanks.controller.events.logging.RegistrationUXNavigationStartEvent;
  import alternativa.tanks.service.IRegistrationUXService;
  import flash.events.EventDispatcher;
  import projects.tanks.client.entrance.model.entrance.logging.RegistrationUXFormAction;
  import projects.tanks.client.entrance.model.entrance.logging.RegistrationUXScreen;

  public class RegistrationUXService extends EventDispatcher implements IRegistrationUXService {
    public function RegistrationUXService() {
      super();
    }

    public function logFormAction(param1:RegistrationUXFormAction) : void {
      dispatchEvent(new RegistrationUXFormEvent(param1,1));
    }

    public function logCountableFormAction(param1:RegistrationUXFormAction, param2:int) : void {
      if(param2 > 0) {
        dispatchEvent(new RegistrationUXFormEvent(param1,param2));
      }
    }

    public function logNavigationStart(param1:RegistrationUXScreen) : void {
      dispatchEvent(new RegistrationUXNavigationStartEvent(param1));
    }

    public function logNavigationFinish() : void {
      dispatchEvent(new RegistrationUXNavigationFinishEvent());
    }
  }
}
