package alternativa.tanks.gui.tankpreview {
  import alternativa.engine3d.core.Object3D;
  import flash.events.IEventDispatcher;
  import flash.events.MouseEvent;
  import flash.utils.getTimer;

  public class AutoRotationState implements TankPreviewState {
    private static const MAX_ANGULAR_SPEED:Number = Math.PI * 5 / 180;
    private static const ANGULAR_ACCELERATION:Number = Math.PI * 5 / 180;

    private var stateMachine:TankPreviewStateMachine;
    private var eventSource:IEventDispatcher;
    private var angularSpeed:Number = 0;
    private var lastTime:int;
    private var cameraContainer:Object3D;

    public function AutoRotationState(param1:TankPreviewStateMachine, param2:IEventDispatcher, param3:Object3D) {
      super();
      this.stateMachine = param1;
      this.eventSource = param2;
      this.cameraContainer = param3;
    }

    public function enter() : void {
      this.eventSource.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      this.lastTime = getTimer();
      this.angularSpeed = 0;
    }

    public function update() : void {
      var local1:Number = this.updateLastTimeAndGetTimeDelta();
      this.calculateAngularSpeed(local1);
      this.cameraContainer.rotationZ += this.angularSpeed * local1;
    }

    private function updateLastTimeAndGetTimeDelta() : Number {
      var local1:int = getTimer();
      var local2:Number = (local1 - this.lastTime) / 1000;
      this.lastTime = local1;
      if(local2 == 0) {
        local2 = 0.1;
      }
      return local2;
    }

    private function calculateAngularSpeed(param1:Number) : void {
      if(this.angularSpeed < MAX_ANGULAR_SPEED) {
        this.angularSpeed += ANGULAR_ACCELERATION * param1;
        if(this.angularSpeed > MAX_ANGULAR_SPEED) {
          this.angularSpeed = MAX_ANGULAR_SPEED;
        }
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
