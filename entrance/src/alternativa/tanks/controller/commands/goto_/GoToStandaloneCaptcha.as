package alternativa.tanks.controller.commands.goto_ {
  import alternativa.tanks.controller.events.ChooseInitialStateEvent;
  import alternativa.tanks.controller.events.GetNewCaptchaEvent;
  import alternativa.tanks.controller.events.showform.ShowFormEvent;
  import alternativa.tanks.model.EntranceServerParamsModel;
  import alternativa.tanks.service.IEntranceServerFacade;
  import org.robotlegs.mvcs.Command;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;

  public class GoToStandaloneCaptcha extends Command {
    [Inject]
    public var serverParamsModel:EntranceServerParamsModel;

    [Inject]
    public var serverFacade:IEntranceServerFacade;

    public function GoToStandaloneCaptcha() {
      super();
    }

    override public function execute() : void {
      if(this.serverParamsModel.standAloneCaptchaEnabled) {
        dispatch(new ShowFormEvent(ShowFormEvent.SHOW_STAND_ALONE_CAPTCHA));
        dispatch(new GetNewCaptchaEvent(CaptchaLocation.CLIENT_STARTUP));
      } else {
        dispatch(new ChooseInitialStateEvent());
      }
    }
  }
}
