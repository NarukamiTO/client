package alternativa.tanks.model.payment.modes.sms {
  import alternativa.tanks.gui.payment.events.SMSformEvent;
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.SMSForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.CrystalsOnlyPaymentMode;
  import alternativa.tanks.model.payment.modes.PayModeDescription;
  import alternativa.tanks.model.payment.modes.description.PayModeBottomDescriptionInternal;
  import flash.net.SharedObject;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.payment.modes.sms.ISMSPayModeModelBase;
  import projects.tanks.client.panel.model.payment.modes.sms.SMSPayModeModelBase;
  import projects.tanks.client.panel.model.payment.modes.sms.types.Country;
  import projects.tanks.client.panel.model.payment.modes.sms.types.SMSNumber;
  import projects.tanks.client.panel.model.payment.modes.sms.types.SMSOperator;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  [ModelInfo]
  public class SMSPayModeModel extends SMSPayModeModelBase implements ISMSPayModeModelBase, SMSPayMode, PayModeDescription, PayModeView, ObjectLoadListener, ObjectUnloadListener, CrystalsOnlyPaymentMode {
    [Inject]
    public static var storageService:IStorageService;

    public function SMSPayModeModel() {
      super();
    }

    public function getCountries() : Vector.<Country> {
      return getInitParam().countries;
    }

    public function setOperators(param1:Vector.<SMSOperator>) : void {
      this.view().setOperators(param1);
    }

    public function setNumbers(param1:Vector.<SMSNumber>) : void {
      this.view().setNumbers(param1);
    }

    public function getDescription() : String {
      var local1:String = this.view().getDescription();
      if(this.view().selectedCountry == "IT") {
        local1 += "\n" + "<font color=\'#00ff0b\'><u><a href=\'http://smshelp.me/tankionline/\' target=\'_blank\'>Dettagli di aquisto</a></u></font>\n" + "Supporto tecnico:\n" + "+390689970531\n\n" + "<font color=\'#00ff0b\'><u><a href=\'http://www.parlamento.it/parlam/leggi/deleghe/03196dl.htm\' target=\'_blank\'>Decreto196/2003</a></u></font>\n";
      }
      return local1;
    }

    public function rewriteCategoryDescription() : Boolean {
      return true;
    }

    private function view() : SMSForm {
      return SMSForm(this.getView());
    }

    public function getView() : PayModeForm {
      return PayModeForm(getData(PayModeForm));
    }

    public function objectLoaded() : void {
      this.createView();
    }

    public function objectUnloaded() : void {
      this.getView().destroy();
      clearData(PayModeForm);
    }

    private function createView() : void {
      var local1:SMSForm = new SMSForm(object);
      local1.addEventListener(SMSformEvent.SELECT_COUNTRY,getFunctionWrapper(this.onSMSformCountrySelected));
      local1.addEventListener(SMSformEvent.SELECT_OPERATOR,getFunctionWrapper(this.onSMSformOperatorSelected));
      putData(PayModeForm,local1);
    }

    private function onSMSformCountrySelected(param1:SMSformEvent) : void {
      var local2:SMSForm = param1.form;
      var local3:SharedObject = storageService.getStorage();
      var local4:String = String(getData(String));
      var local5:String = local2.selectedCountry;
      if(local5 != "" && local5 != local4) {
        putData(String,local5);
        local3.data.userCountryId = local5;
        local3.flush();
        server.getOperators(local5);
      }
      var local6:PayModeBottomDescriptionInternal = PayModeBottomDescriptionInternal(object.adapt(PayModeBottomDescriptionInternal));
      local6.setEnabled(local5 == "FR");
    }

    private function onSMSformOperatorSelected(param1:SMSformEvent) : void {
      var local2:SMSForm = param1.form;
      var local3:SharedObject = storageService.getStorage();
      var local4:int = local2.selectedOperator;
      if(local4 != -1) {
        local3.data.userOperatorId = local4;
        local3.flush();
        server.getNumbers(local4);
      }
    }
  }
}
