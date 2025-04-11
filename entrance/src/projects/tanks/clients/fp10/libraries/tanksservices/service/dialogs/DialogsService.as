package projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.loader.ILoaderWindowService;
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.events.Event;
  import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
  import platform.client.fp10.core.network.handler.OnConnectionClosedServiceListener;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blur.IBlurService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.DialogWindowsDispatcherServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;

  public class DialogsService implements IDialogsService, OnConnectionClosedServiceListener {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var blurService:IBlurService;

    [Inject]
    public static var dialogWindowsDispatcherService:IDialogWindowsDispatcherService;

    [Inject]
    public static var loaderWindowService:ILoaderWindowService;

    private var dialogs:Vector.<DialogWindow> = new Vector.<DialogWindow>();
    private var queue:Vector.<DialogWindow> = new Vector.<DialogWindow>();

    public function DialogsService() {
      super();
    }

    private static function center(param1:DisplayObject) : void {
      param1.x = display.stage.stageWidth - param1.width >> 1;
      param1.y = display.stage.stageHeight - param1.height >> 1;
    }

    public function addDialog(param1:DialogWindow) : void {
      if(this.dialogs.indexOf(param1) > -1) {
        return;
      }
      this.dialogs.unshift(param1);
      if(this.dialogs.length > 1) {
        this.hideDialog(this.dialogs[1],false);
      }
      this.showDialog(param1,this.dialogs.length == 1);
      if(this.dialogs.length == 1) {
        display.stage.addEventListener(Event.RESIZE,this.onResize,false,-1);
      }
    }

    public function centerDialog(param1:DialogWindow) : void {
      center(param1);
    }

    public function enqueueDialog(param1:DialogWindow) : void {
      if(loaderWindowService.isInProgress()) {
        this.queue.unshift(param1);
        return;
      }
      if(this.dialogs.length == 0) {
        this.addDialog(param1);
      } else {
        this.queue.unshift(param1);
      }
    }

    public function removeDialog(param1:DialogWindow) : void {
      var local2:int = this.dialogs.indexOf(param1);
      if(local2 < 0) {
        return;
      }
      this.dialogs.splice(this.dialogs.indexOf(param1),1);
      if(this.dialogs.length == 0 && this.queue.length > 0) {
        this.dialogs.push(this.queue.pop());
      }
      this.hideDialog(param1,this.dialogs.length == 0);
      if(this.dialogs.length > 0) {
        this.showDialog(this.dialogs[0],false);
      } else {
        display.stage.removeEventListener(Event.RESIZE,this.onResize);
      }
    }

    private function showDialog(param1:DialogWindow, param2:Boolean) : void {
      if(param2) {
        blurService.blurGameContent();
      }
      center(param1);
      dialogWindowsDispatcherService.addEventListener(DialogWindowsDispatcherServiceEvent.FORCIBLY_CLOSE,this.onForciblyCloseDialogs);
      dialogWindowsDispatcherService.open();
      this.dialogsLayer.addChild(param1);
      param1.setEventListeners();
    }

    private function hideDialog(param1:DialogWindow, param2:Boolean) : void {
      if(this.dialogsLayer.contains(param1)) {
        param1.removeEventListeners();
        this.dialogsLayer.removeChild(param1);
        dialogWindowsDispatcherService.removeEventListener(DialogWindowsDispatcherServiceEvent.FORCIBLY_CLOSE,this.onForciblyCloseDialogs);
        dialogWindowsDispatcherService.close();
      }
      if(param2) {
        blurService.unblurGameContent();
      }
    }

    private function onResize(param1:Event) : void {
      if(this.dialogs.length > 0) {
        center(this.dialogs[0]);
      }
    }

    private function onForciblyCloseDialogs(param1:DialogWindowsDispatcherServiceEvent) : void {
      var local2:DialogWindow = null;
      for each(local2 in this.dialogs.concat()) {
        local2.forciblyClose();
      }
    }

    private function get dialogsLayer() : DisplayObjectContainer {
      return display.dialogsLayer;
    }

    public function onConnectionClosed(param1:ConnectionCloseStatus) : void {
      if(this.dialogs.length > 0) {
        this.hideDialog(this.dialogs[0],true);
        display.stage.removeEventListener(Event.RESIZE,this.onResize);
      }
      this.dialogs.length = 0;
      this.queue.length = 0;
    }
  }
}
