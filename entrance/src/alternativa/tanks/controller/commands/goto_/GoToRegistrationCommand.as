package alternativa.tanks.controller.commands.goto_ {
  import alternativa.tanks.controller.events.GetNewCaptchaEvent;
  import alternativa.tanks.controller.events.showform.ShowRegistrationFormEvent;
  import alternativa.tanks.model.EntranceServerParamsModel;
  import alternativa.tanks.model.EntranceUrlParamsModel;
  import alternativa.tanks.model.RegistrationBackgroundModel;
  import alternativa.tanks.service.IEntranceServerFacade;
  import alternativa.tanks.tracker.ITrackerService;
  import flash.display.Bitmap;
  import org.robotlegs.mvcs.Command;
  import projects.tanks.client.commons.models.captcha.CaptchaLocation;

  public class GoToRegistrationCommand extends Command {
    [Inject]
    public var backgroundModel:RegistrationBackgroundModel;

    [Inject]
    public var serverParams:EntranceServerParamsModel;

    [Inject]
    public var paramsModel:EntranceUrlParamsModel;

    [Inject]
    public var serverFacade:IEntranceServerFacade;

    [Inject]
    public var trackerService:ITrackerService;

    public function GoToRegistrationCommand() {
      super();
    }

    override public function execute() : void {
      var local1:Bitmap = this.backgroundModel.backgroundImage;
      dispatch(new ShowRegistrationFormEvent(local1,this.serverParams.antiAddictionEnabled,this.serverParams.registrationCaptchaEnabled,this.serverParams.skipRegistrationEnabled,this.paramsModel.tutorialHash == null,this.serverParams.registrationThroughEmail));
      this.trackerService.trackEvent("entrance","showRegistrationForm","");
      if(this.serverParams.registrationCaptchaEnabled) {
        dispatch(new GetNewCaptchaEvent(CaptchaLocation.REGISTER_FORM));
      }
    }
  }
}
