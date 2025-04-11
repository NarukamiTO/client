package alternativa.tanks.servermodels.registartion.email {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.IEntranceClientFacade;
  import projects.tanks.client.entrance.model.entrance.email.EmailRegistrationModelBase;
  import projects.tanks.client.entrance.model.entrance.email.IEmailRegistrationModelBase;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import services.alertservice.AlertAnswer;

  [ModelInfo]
  public class EmailRegistrationModel extends EmailRegistrationModelBase implements IEmailRegistrationModelBase, IEmailRegistration {
    [Inject]
    public static var facade:IEntranceClientFacade;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    public function EmailRegistrationModel() {
      super();
    }

    public function emailDomainIsForbidden() : void {
      facade.emailDomainIsForbidden();
    }

    public function emailIsInvalid() : void {
      facade.emailIsInvalid();
    }

    public function emailIsBusy() : void {
      facade.emailIsBusy();
    }

    public function emailIsFree() : void {
      facade.emailIsFree();
    }

    public function emailWithPasswordSuccessfullySent() : void {
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_ALERT_EMAIL_REGISTRATION),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
      var local1:String = String(getData(String));
      facade.emailWithPasswordSuccessfullySent(local1);
    }

    public function checkEmail(param1:String) : void {
      server.checkEmail(param1);
    }

    public function register(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void {
      putData(String,param1);
      server.registerUserRequiredEmail(param1,param2,param3,param4,param5,param6);
    }
  }
}
