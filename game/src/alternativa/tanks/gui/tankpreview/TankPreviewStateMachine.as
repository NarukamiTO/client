package alternativa.tanks.gui.tankpreview {
  import flash.utils.Dictionary;

  public class TankPreviewStateMachine {
    private var eventTransitions:Dictionary = new Dictionary();
    private var currentState:TankPreviewState;

    public function TankPreviewStateMachine() {
      super();
    }

    public function addTransition(param1:TankPreviewEvent, param2:TankPreviewState, param3:TankPreviewState) : void {
      var local4:Dictionary = this.eventTransitions[param1];
      if(local4 == null) {
        local4 = new Dictionary();
        this.eventTransitions[param1] = local4;
      }
      local4[param2] = param3;
    }

    public function handleEvent(param1:TankPreviewState, param2:TankPreviewEvent) : void {
      var local3:Dictionary = this.eventTransitions[param2];
      if(local3 == null) {
        throw new NoTransitionsFoundError();
      }
      var local4:TankPreviewState = local3[param1];
      if(local4 == null) {
        throw new NewStateMissingError();
      }
      param1.exit();
      local4.enter();
      this.currentState = local4;
    }

    public function setCurrentState(param1:TankPreviewState) : void {
      this.currentState = param1;
      this.currentState.enter();
    }

    public function updateCurrentState() : void {
      this.currentState.update();
    }
  }
}
