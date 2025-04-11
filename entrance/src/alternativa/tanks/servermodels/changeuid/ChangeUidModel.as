package alternativa.tanks.servermodels.changeuid {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.IEntranceClientFacade;
  import projects.tanks.client.entrance.model.entrance.changeuid.ChangeUidModelBase;
  import projects.tanks.client.entrance.model.entrance.changeuid.IChangeUidModelBase;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import services.alertservice.AlertAnswer;

  [ModelInfo]
  public class ChangeUidModel extends ChangeUidModelBase implements IChangeUidModelBase, IChangeUid {
    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var clientFacade:IEntranceClientFacade;

    private var changeUidHash:String;
    private var email:String;
    private var newUid:String;

    public function ChangeUidModel() {
      super();
    }

    public function checkChangeUidHash(param1:String, param2:String) : void {
      this.changeUidHash = param1;
      this.email = param2;
      server.checkChangeUidParams(param1,param2);
    }

    public function changeUidAndPassword(param1:String, param2:String) : void {
      this.newUid = param1;
      if(param2.length > 0) {
        server.changeUidAndPassword(this.email,this.changeUidHash,param1,param2);
      } else {
        server.changeUid(this.email,this.changeUidHash,param1);
      }
    }

    public function changeUid(param1:String) : void {
      server.changeUidViaPartner(param1);
    }

    public function startChangingUid() : void {
      clientFacade.goToChangeUidAndPasswordForm();
    }

    public function startChangingUidViaPartner() : void {
      clientFacade.goToChangeUidForm();
    }

    public function passwordIncorrect() : void {
      clientFacade.changeUidFailedPasswordIsIncorrect();
    }

    public function uidIncorrect() : void {
      clientFacade.callsignIsIncorrect();
    }

    public function parametersIncorrect() : void {
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_LINK_IS_NO_LONGER_VALID_TEXT),Vector.<String>([localeService.getText(AlertAnswer.OK)]));
      alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onAlertButtonPressed);
    }

    private function onAlertButtonPressed(param1:AlertServiceEvent) : void {
      alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,this.onAlertButtonPressed);
      if(param1.typeButton == localeService.getText(AlertAnswer.OK)) {
        clientFacade.goToLoginForm();
      }
    }

    public function uidChanged() : void {
      clientFacade.uidChangedSuccessfully(this.newUid);
    }
  }
}
