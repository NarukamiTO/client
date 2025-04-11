package alternativa.tanks.model.donationalert {
  import alternativa.osgi.OSGi;
  import alternativa.tanks.gui.EmailBlockRequestEvent;
  import alternativa.tanks.gui.ThanksForPurchaseWindow;
  import alternativa.tanks.service.paymentcomplete.PaymentCompleteService;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.types.Long;
  import flash.display.BitmapData;
  import flash.events.Event;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.client.panel.model.donationalert.DonationAlertModelBase;
  import projects.tanks.client.panel.model.donationalert.IDonationAlertModelBase;
  import projects.tanks.client.panel.model.donationalert.types.DonationData;
  import projects.tanks.client.panel.model.donationalert.types.GoodInfoData;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  [ModelInfo]
  public class DonationAlertModel extends DonationAlertModelBase implements IDonationAlertModelBase, ObjectLoadListener, ObjectUnloadListener, ThanksForDonationFormService {
    [Inject]
    public static var settingsService:ISettingsService;

    [Inject]
    public static var paymentCompleteService:PaymentCompleteService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    private var window:ThanksForPurchaseWindow = null;
    private var time:Long = null;
    private var confirmTime:Long;
    private var goods:Vector.<GoodInfoData> = new Vector.<GoodInfoData>();
    private var showEmailBlock:Boolean = false;
    private var currentObject:IGameObject;

    public function DonationAlertModel() {
      super();
    }

    public function objectLoaded() : void {
      this.currentObject = object;
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,getFunctionWrapper(this.onEndLayoutSwitch));
      OSGi.getInstance().registerService(ThanksForDonationFormService,this);
    }

    private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
      if(param1.state != LayoutState.BATTLE) {
        this.showAlertIfPossible();
      }
    }

    public function objectUnloaded() : void {
      OSGi.getInstance().unregisterService(ThanksForDonationFormService);
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,getFunctionWrapper(this.onEndLayoutSwitch));
      this.currentObject = null;
    }

    private function showAlertIfPossible() : void {
      if(this.window == null && this.goods.length > 0 && lobbyLayoutService.getCurrentState() != LayoutState.BATTLE && !lobbyLayoutService.isSwitchInProgress()) {
        this.window = this.createForm(this.goods,this.showEmailBlock);
        this.confirmTime = this.time;
        this.goods.length = 0;
        this.show();
      }
      paymentCompleteService.paymentCompleted();
    }

    public function showDonationAlert(param1:DonationData) : void {
      this.updateData(param1);
      this.showAlertIfPossible();
    }

    public function showDonationAlertWithEmailBlock(param1:DonationData) : void {
      this.showEmailBlock = true;
      this.updateData(param1);
      this.showAlertIfPossible();
    }

    public function getThanksForPurchaseForm(param1:Vector.<GoodInfoData>, param2:Boolean) : ThanksForPurchaseWindow {
      var form:ThanksForPurchaseWindow = null;
      var items:Vector.<GoodInfoData> = param1;
      var requiredEmail:Boolean = param2;
      try {
        object = this.currentObject;
        form = this.createForm(items,requiredEmail);
      }
      finally {
        popObject();
      }
      return form;
    }

    private function createForm(param1:Vector.<GoodInfoData>, param2:Boolean) : ThanksForPurchaseWindow {
      var local3:BitmapData = null;
      if(param2) {
        local3 = getInitParam().imageWithEmail.data;
      } else {
        local3 = getInitParam().imageWithoutEmail.data;
      }
      return new ThanksForPurchaseWindow(local3,param1,param2);
    }

    private function updateData(param1:DonationData) : void {
      var local2:GoodInfoData = null;
      var local3:GoodInfoData = null;
      this.time = param1.time;
      for each(local2 in param1.goods) {
        local3 = this.findGood(local2.name);
        if(local3 == null) {
          this.goods.push(local2);
        } else {
          local3.count += local2.count;
        }
      }
    }

    private function findGood(param1:String) : GoodInfoData {
      var local2:GoodInfoData = null;
      for each(local2 in this.goods) {
        if(param1 == local2.name) {
          return local2;
        }
      }
      return null;
    }

    public function showEmailIsBusy(param1:String) : void {
      this.window.showEmailIsBusy(param1);
    }

    public function showEmailIsForbidden(param1:String) : void {
      this.window.showEmailIsForbidden(param1);
    }

    public function showEmailIsFree(param1:String) : void {
      this.window.showEmailIsFree(param1);
    }

    private function onClose(param1:Event) : void {
      this.window.removeEventListener(Event.CANCEL,getFunctionWrapper(this.onClose));
      this.window.removeEventListener(EmailBlockRequestEvent.SEND_VALIDATE_EMAIL_REQUEST_EVENT,getFunctionWrapper(this.onValidateEmail));
      if(this.window.hasEmailBlock) {
        server.confirmWithEmail(this.confirmTime,this.window.email);
        settingsService.setEmail(this.window.email,false);
      } else {
        server.confirm(this.confirmTime);
      }
      this.window.destroy();
      this.window = null;
      this.showEmailBlock = false;
      if(this.goods.length > 0) {
        setTimeout(getFunctionWrapper(this.showAlertIfPossible),1000);
      }
    }

    private function show() : void {
      this.window.addInDialogLayer();
      this.window.addEventListener(Event.CANCEL,getFunctionWrapper(this.onClose));
      this.window.addEventListener(EmailBlockRequestEvent.SEND_VALIDATE_EMAIL_REQUEST_EVENT,getFunctionWrapper(this.onValidateEmail));
    }

    private function onValidateEmail(param1:EmailBlockRequestEvent) : void {
      server.validateEmail(param1.email);
    }
  }
}
