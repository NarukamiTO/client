package alternativa.tanks.controller.events.logging {
  import flash.events.Event;
  import projects.tanks.client.entrance.model.entrance.logging.RegistrationUXFormAction;

  public class RegistrationUXFormEvent extends Event {
    public static const FORM_ACTION:String = "RegistrationUXFormEvent";

    private var _action:RegistrationUXFormAction;
    private var _count:int;

    public function RegistrationUXFormEvent(param1:RegistrationUXFormAction, param2:int) {
      this._action = param1;
      this._count = param2;
      super(FORM_ACTION);
    }

    public function get action() : RegistrationUXFormAction {
      return this._action;
    }

    public function get count() : int {
      return this._count;
    }
  }
}
