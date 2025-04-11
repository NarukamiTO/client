package alternativa.tanks.model.payment.modes.errors {
  import projects.tanks.client.panel.model.payment.modes.errors.ErrorsDescriptionModelBase;
  import projects.tanks.client.panel.model.payment.modes.errors.IErrorsDescriptionModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;

  [ModelInfo]
  public class ErrorsDescriptionModel extends ErrorsDescriptionModelBase implements IErrorsDescriptionModelBase {
    [Inject]
    public static var alertService:IAlertService;

    public function ErrorsDescriptionModel() {
      super();
    }

    public function showError(param1:String) : void {
      alertService.showOkAlert(param1);
    }
  }
}
