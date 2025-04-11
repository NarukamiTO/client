package alternativa.tanks.view {
  import alternativa.tanks.controller.events.InviteCheckResultEvent;
  import alternativa.tanks.controller.events.InviteCodeEnteredEvent;
  import alternativa.tanks.view.events.InviteFormOkButtonEvent;
  import alternativa.tanks.view.forms.InviteForm;
  import org.robotlegs.mvcs.Mediator;

  public class InviteFormMediator extends Mediator {
    [Inject]
    public var view:InviteForm;

    public function InviteFormMediator() {
      super();
    }

    override public function onRegister() : void {
      addViewListener(InviteFormOkButtonEvent.OK_BUTTON_CLICKED,this.onInviteEntered,InviteFormOkButtonEvent);
      addContextListener(InviteCheckResultEvent.INVITE_CODE_DOES_NOT_EXIST,this.onWrongInviteCode,InviteCheckResultEvent);
    }

    private function onWrongInviteCode(param1:InviteCheckResultEvent) : void {
      this.view.showInviteError();
    }

    private function onInviteEntered(param1:InviteFormOkButtonEvent) : void {
      dispatch(new InviteCodeEnteredEvent(this.view.code));
    }
  }
}
