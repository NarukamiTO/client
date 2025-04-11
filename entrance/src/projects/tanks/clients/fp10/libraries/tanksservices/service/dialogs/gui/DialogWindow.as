package projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui {
  import alternativa.osgi.service.display.IDisplay;
  import base.DiscreteSprite;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.AlertUtils;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.KeyUpListenerPriority;

  public class DialogWindow extends DiscreteSprite {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var dialogService:IDialogsService;

    public function DialogWindow() {
      super();
    }

    public function setEventListeners() : void {
      display.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,KeyUpListenerPriority.DIALOG);
      addEventListener(DialogEvent.CLOSE,this.onClose,true);
    }

    private function onClose(param1:Event) : void {
      this.forciblyClose();
    }

    protected function onKeyUp(param1:KeyboardEvent) : void {
      if(AlertUtils.isCancelKey(param1.keyCode)) {
        param1.stopImmediatePropagation();
        this.cancelKeyPressed();
      }
      if(AlertUtils.isConfirmationKey(param1.keyCode)) {
        param1.stopImmediatePropagation();
        this.confirmationKeyPressed();
      }
    }

    protected function cancelKeyPressed() : void {
    }

    protected function confirmationKeyPressed() : void {
    }

    public function removeEventListeners() : void {
      display.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
    }

    public function forciblyClose() : void {
      this.cancelKeyPressed();
    }
  }
}
