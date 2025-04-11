package alternativa.tanks.view {
  import alternativa.tanks.controller.events.CallsignCheckResultEvent;
  import alternativa.tanks.controller.events.CheckCallsignEvent;
  import alternativa.tanks.controller.events.NavigationEvent;
  import alternativa.tanks.controller.events.socialnetwork.FinishExternalRegisterEvent;
  import alternativa.tanks.view.forms.ExternalRegistrationForm;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.mvcs.Mediator;

  public class ExternalRegistrationFormMediator extends Mediator {
    [Inject]
    public var view:ExternalRegistrationForm;

    [Inject]
    public var injector:IInjector;

    public function ExternalRegistrationFormMediator() {
      super();
    }

    override public function onRegister() : void {
      this.injector.injectInto(this.view);
      addViewListener(CheckCallsignEvent.CHECK_CALLSIGN,dispatch,CheckCallsignEvent);
      addViewListener(FinishExternalRegisterEvent.FINISH_REGISTRATION,dispatch,FinishExternalRegisterEvent);
      addViewListener(NavigationEvent.GO_TO_REGISTRATION_FORM,dispatch,NavigationEvent);
      addContextListener(CallsignCheckResultEvent.CALLSIGN_IS_BUSY,this.onCallsignBusy);
      addContextListener(CallsignCheckResultEvent.CALLSIGN_IS_FREE,this.onCallsignFree);
      addContextListener(CallsignCheckResultEvent.CALLSIGN_IS_INCORRECT,this.onCallsignIncorrect);
    }

    private function onCallsignFree(param1:CallsignCheckResultEvent) : void {
      this.view.alertAboutFreeUid();
    }

    private function onCallsignBusy(param1:CallsignCheckResultEvent) : void {
      this.view.alertAboutBusyUid(param1.freeUids);
    }

    private function onCallsignIncorrect(param1:CallsignCheckResultEvent) : void {
      this.view.alertAboutIncorrectUid();
    }
  }
}
