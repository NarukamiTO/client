package alternativa.tanks.view {
  import alternativa.tanks.controller.events.ChangeUidResultEvent;
  import alternativa.tanks.view.events.SendChangeUidAndPasswordEvent;
  import alternativa.tanks.view.events.SendChangeUidEvent;
  import alternativa.tanks.view.forms.ChangeUidForm;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.mvcs.Mediator;

  public class ChangeUidFormMediator extends Mediator {
    [Inject]
    public var view:ChangeUidForm;

    [Inject]
    public var injector:IInjector;

    public function ChangeUidFormMediator() {
      super();
    }

    override public function onRegister() : void {
      this.injector.injectInto(this.view);
      addViewListener(SendChangeUidAndPasswordEvent.EVENT_TYPE,dispatch,SendChangeUidAndPasswordEvent);
      addViewListener(SendChangeUidEvent.EVENT_TYPE,dispatch,SendChangeUidEvent);
      addContextListener(ChangeUidResultEvent.PASSWORD_IS_INCORRECT,this.onPasswordIsIncorrect,ChangeUidResultEvent);
    }

    private function onPasswordIsIncorrect(param1:ChangeUidResultEvent) : void {
      this.view.showAlertPasswordIsIncorrect();
    }
  }
}
