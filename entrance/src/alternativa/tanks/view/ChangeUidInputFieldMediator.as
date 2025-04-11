package alternativa.tanks.view {
  import alternativa.tanks.controller.events.CallsignCheckResultEvent;
  import alternativa.tanks.controller.events.CheckCallsignEvent;
  import alternativa.tanks.view.forms.commons.ChangeUidInputField;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.mvcs.Mediator;

  public class ChangeUidInputFieldMediator extends Mediator {
    [Inject]
    public var view:ChangeUidInputField;

    [Inject]
    public var injector:IInjector;

    public function ChangeUidInputFieldMediator() {
      super();
    }

    override public function onRegister() : void {
      this.injector.injectInto(this.view);
      addViewListener(CheckCallsignEvent.CHECK_CALLSIGN,dispatch,CheckCallsignEvent);
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
