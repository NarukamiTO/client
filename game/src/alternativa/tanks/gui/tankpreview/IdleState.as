package alternativa.tanks.gui.tankpreview {
  import flash.events.IEventDispatcher;
  import flash.events.MouseEvent;
  import flash.utils.getTimer;

  public class IdleState implements TankPreviewState {
    private static const AUTO_ROTATION_DELAY_MS:int = 10000;

    private var stateMachine:TankPreviewStateMachine;
    private var eventSource:IEventDispatcher;
    private var exitTime:int;

    public function IdleState(param1:TankPreviewStateMachine, param2:IEventDispatcher) {
      super();
      this.stateMachine = param1;
      this.eventSource = param2;
    }

    public function enter() : void {
      this.eventSource.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      this.exitTime = getTimer() + AUTO_ROTATION_DELAY_MS;
    }

    public function update() : void {
      if(getTimer() >= this.exitTime) {
        this.stateMachine.handleEvent(this,TankPreviewEvent.IDLE_STATE_TIMEOUT);
      }
    }

    public function exit() : void {
      this.eventSource.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
    }

    private function onMouseDown(param1:MouseEvent) : void {
      this.stateMachine.handleEvent(this,TankPreviewEvent.MOUSE_DOWN);
    }
  }
}
