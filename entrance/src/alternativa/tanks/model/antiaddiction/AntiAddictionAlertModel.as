package alternativa.tanks.model.antiaddiction {
  import alternativa.tanks.gui.AntiAddictionWindow;
  import alternativa.tanks.service.panel.IPanelView;
  import flash.events.Event;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import forms.AntiAddictionAlert;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.panel.model.antiaddictionalert.AntiAddictionAlertModelBase;
  import projects.tanks.client.panel.model.antiaddictionalert.IAntiAddictionAlertModelBase;

  [ModelInfo]
  public class AntiAddictionAlertModel extends AntiAddictionAlertModelBase implements IAntiAddictionAlertModelBase, IAntiAddictionAlert, ObjectLoadListener {
    [Inject]
    public static var panelView:IPanelView;

    private var alertShowTimer:Timer;
    private var antiAddictionWindow:AntiAddictionWindow;
    private var antiAddictionAlert:AntiAddictionAlert;

    public function AntiAddictionAlertModel() {
      super();
    }

    public function objectLoaded() : void {
      this.createAlertShowTimer();
    }

    private function createAlertShowTimer() : void {
      this.alertShowTimer = new Timer(60 * 1000,1);
      this.alertShowTimer.addEventListener(TimerEvent.TIMER_COMPLETE,getFunctionWrapper(this.onShowAlertTimerComplete));
    }

    private function onShowAlertTimerComplete(param1:TimerEvent) : void {
      if(this.antiAddictionAlert != null) {
        this.antiAddictionAlert.removeFormDialog();
      }
    }

    public function showAntiAddictionAlert(param1:int, param2:Boolean) : void {
      this.showAntiAddictionWindow(param1,param2);
    }

    private function showAntiAddictionWindow(param1:int, param2:Boolean) : void {
      var local3:String = null;
      if(param1 >= 210) {
        if(this.antiAddictionWindow != null) {
          this.antiAddictionWindow.removeDialog();
        }
        this.antiAddictionWindow = new AntiAddictionWindow(param1,param2);
        this.antiAddictionWindow.addEventListener(Event.COMPLETE,getFunctionWrapper(this.onIDCardEntered));
      } else {
        local3 = "";
        if(param1 >= 180) {
          local3 = "您累计在线时间已满3小时，请您下线休息，做适当身体活动。";
        } else if(param1 >= 120) {
          local3 = "您累计在线时间已满2小时。";
        } else if(param1 >= 60) {
          local3 = "您累计在线时间已满1小时。";
        }
        if(this.antiAddictionAlert != null) {
          this.antiAddictionAlert.removeFormDialog();
        }
        this.antiAddictionAlert = new AntiAddictionAlert(local3);
        if(this.alertShowTimer == null) {
          this.createAlertShowTimer();
        }
        this.alertShowTimer.reset();
        this.alertShowTimer.start();
      }
    }

    private function onIDCardEntered(param1:Event) : void {
      this.setIdNumberAndRealName(this.antiAddictionWindow.realNameInput.value,this.antiAddictionWindow.idCardInput.value);
      this.antiAddictionWindow.disableButtons();
    }

    public function setIdNumberAndRealName(param1:String, param2:String) : void {
      server.setRealNameAndIDNumber(param1,param2);
    }

    public function realNameAndIDNumberSetSuccesfully(param1:String) : void {
      panelView.showAlert(param1);
      if(this.antiAddictionWindow != null) {
        this.antiAddictionWindow.removeDialog();
      }
    }

    public function realNameAndIDNumberSetError(param1:String) : void {
      panelView.showAlert(param1);
      if(this.antiAddictionWindow != null) {
        this.antiAddictionWindow.enableButtons();
      }
    }
  }
}
