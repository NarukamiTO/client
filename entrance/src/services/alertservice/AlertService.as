package services.alertservice {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.display.Sprite;
  import flash.events.EventDispatcher;
  import forms.events.AlertEvent;
  import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
  import platform.client.fp10.core.network.handler.OnConnectionClosedServiceListener;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.DialogWindowsDispatcherServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;

  public class AlertService extends EventDispatcher implements IAlertService, OnConnectionClosedServiceListener {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var blurService:IBlurService;

    [Inject]
    public static var dialogWindowsDispatcherService:IDialogWindowsDispatcherService;

    private var _alert:Alert;
    private var _queue:Vector.<Alert>;

    public function AlertService() {
      super();
      this.init();
    }

    private function init() : void {
      this._alert = new Alert();
      this._alert = null;
      this._queue = new Vector.<Alert>();
    }

    public function showAlert(param1:String, param2:Vector.<String>) : void {
      var local3:Alert = null;
      if(this.isClose()) {
        this._alert = new Alert();
        this._alert.showAlert(param1,param2);
        this.addAlert();
      } else {
        local3 = new Alert();
        local3.showAlert(param1,param2);
        this._queue.push(local3);
      }
    }

    public function showAlertWithCustomButtons(param1:String, param2:Vector.<String>, param3:Vector.<Sprite>) : void {
      var local4:Alert = null;
      if(this.isClose()) {
        this._alert = new Alert();
        this._alert.showAlertWithCustomButtons(param1,param2,param3);
        this.addAlert();
      } else {
        local4 = new Alert();
        local4.showAlertWithCustomButtons(param1,param2,param3);
        this._queue.push(local4);
      }
    }

    public function showOkAlert(param1:String) : void {
      this.showAlert(param1,Vector.<String>([localeService.getText(AlertAnswer.OK)]));
    }

    private function addAlert() : void {
      dialogWindowsDispatcherService.open();
      blurService.blurDialogContent();
      display.noticesLayer.addChild(this._alert);
      this._alert.addEventListener(AlertEvent.ALERT_BUTTON_PRESSED,this.onAlertButtonPressed);
      dialogWindowsDispatcherService.addEventListener(DialogWindowsDispatcherServiceEvent.FORCIBLY_CLOSE,this.onForciblyCloseDialogs);
    }

    public function showAlertById(param1:int) : void {
      if(this.isClose()) {
        this._alert = new Alert(param1);
        this.addAlert();
      } else {
        this._queue.push(new Alert(param1));
      }
    }

    private function onAlertButtonPressed(param1:AlertEvent) : void {
      this.removeAlert();
      dispatchEvent(new AlertServiceEvent(AlertServiceEvent.ALERT_BUTTON_PRESSED,param1.typeButton));
    }

    private function removeAlert() : void {
      dialogWindowsDispatcherService.removeEventListener(DialogWindowsDispatcherServiceEvent.FORCIBLY_CLOSE,this.onForciblyCloseDialogs);
      this._alert.removeEventListener(AlertEvent.ALERT_BUTTON_PRESSED,this.onAlertButtonPressed);
      this._alert = null;
      if(this._queue.length > 0) {
        this._alert = this._queue.shift();
        this.addAlert();
      } else {
        dialogWindowsDispatcherService.close();
        blurService.unblurDialogContent();
      }
    }

    private function onForciblyCloseDialogs(param1:DialogWindowsDispatcherServiceEvent) : void {
      this._alert.simulatePressedCancel();
    }

    public function onConnectionClosed(param1:ConnectionCloseStatus) : void {
      this._queue.length = 0;
      if(Boolean(this._alert)) {
        removeDisplayObject(this._alert);
        this.removeAlert();
      }
    }

    private function isClose() : Boolean {
      return this._alert == null;
    }
  }
}
