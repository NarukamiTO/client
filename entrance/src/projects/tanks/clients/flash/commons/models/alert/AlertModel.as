package projects.tanks.clients.flash.commons.models.alert {
  import alternativa.osgi.service.locale.ILocaleService;
  import projects.tanks.client.commons.models.alert.AlertModelBase;
  import projects.tanks.client.commons.models.alert.IAlertModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import services.alertservice.AlertAnswer;

  [ModelInfo]
  public class AlertModel extends AlertModelBase implements IAlertModelBase {
    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    public function AlertModel() {
      super();
    }

    public function show(param1:String) : void {
      alertService.showAlert(param1,Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }
  }
}
