package alternativa.tanks.view {
  import alternativa.tanks.controller.events.CallsignCheckResultEvent;
  import alternativa.tanks.controller.events.CheckCallsignEvent;
  import alternativa.tanks.controller.events.PartnersEvent;
  import alternativa.tanks.controller.events.RegistrationBackgroundLoadedEvent;
  import alternativa.tanks.controller.events.partners.FinishPartnerRegisterEvent;
  import alternativa.tanks.view.forms.PartnersRegistrationForm;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.mvcs.Mediator;

  public class PartnersRegistrationFormMediator extends Mediator {
    [Inject]
    public var view:PartnersRegistrationForm;

    [Inject]
    public var injector:IInjector;

    public function PartnersRegistrationFormMediator() {
      super();
    }

    override public function onRegister() : void {
      this.injector.injectInto(this.view);
      addViewListener(CheckCallsignEvent.CHECK_CALLSIGN,dispatch,CheckCallsignEvent);
      addViewListener(FinishPartnerRegisterEvent.FINISH_REGISTRATION,dispatch,FinishPartnerRegisterEvent);
      addViewListener(PartnersEvent.START_LOGIN,dispatch,PartnersEvent);
      addContextListener(RegistrationBackgroundLoadedEvent.LOADED,this.onBackgroundLoaded);
      addContextListener(CallsignCheckResultEvent.CALLSIGN_IS_BUSY,this.onCallsignBusy);
      addContextListener(CallsignCheckResultEvent.CALLSIGN_IS_FREE,this.onCallsignFree);
      addContextListener(CallsignCheckResultEvent.CALLSIGN_IS_INCORRECT,this.onCallsignIncorrect);
    }

    private function onBackgroundLoaded(param1:RegistrationBackgroundLoadedEvent) : void {
      this.view.setBackground(param1.backgroundImage);
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
