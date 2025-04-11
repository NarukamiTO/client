package alternativa.tanks.view {
  import alternativa.tanks.controller.events.CheckCaptchaAnswerEvent;
  import alternativa.tanks.controller.events.ChooseInitialStateEvent;
  import alternativa.tanks.controller.events.GetNewCaptchaEvent;
  import flash.events.MouseEvent;
  import org.robotlegs.mvcs.Mediator;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;
  import projects.tanks.clients.flash.commons.models.captcha.RefreshCaptchaClickedEvent;

  public class StandAloneCaptchaMediator extends Mediator {
    [Inject]
    public var view:StandAloneCaptchaForm;

    public function StandAloneCaptchaMediator() {
      super();
    }

    override public function onRegister() : void {
      addViewListener(RefreshCaptchaClickedEvent.CLICKED,this.onRefreshCaptcha,RefreshCaptchaClickedEvent);
      eventMap.mapListener(this.view.playButton,MouseEvent.CLICK,this.onPlayClicked);
    }

    private function onRefreshCaptcha(param1:RefreshCaptchaClickedEvent) : void {
      dispatch(new GetNewCaptchaEvent(CaptchaLocation.CLIENT_STARTUP));
    }

    private function onPlayClicked(param1:MouseEvent) : void {
      dispatch(new CheckCaptchaAnswerEvent(this.view.captchaAnswer,CaptchaLocation.CLIENT_STARTUP,new ChooseInitialStateEvent()));
    }
  }
}
