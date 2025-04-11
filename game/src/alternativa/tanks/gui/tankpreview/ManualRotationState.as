package alternativa.tanks.gui.tankpreview {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Object3D;
  import flash.display.Stage;
  import flash.events.MouseEvent;
  import flash.utils.getTimer;

  public class ManualRotationState implements TankPreviewState {
    private var stateMachine:TankPreviewStateMachine;
    private var stage:Stage;
    private var context:TankPreviewContext;
    private var camera:Camera3D;
    private var startingRotatonZ:Number;
    private var startingMouseX:Number;
    private var times:Vector.<int> = new Vector.<int>(2);
    private var rotations:Vector.<Number> = new Vector.<Number>(2);
    private var cameraContainer:Object3D;

    public function ManualRotationState(param1:TankPreviewStateMachine, param2:Stage, param3:TankPreviewContext, param4:Camera3D, param5:Object3D) {
      super();
      this.stateMachine = param1;
      this.stage = param2;
      this.context = param3;
      this.camera = param4;
      this.cameraContainer = param5;
    }

    public function enter() : void {
      this.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
      this.startingRotatonZ = this.cameraContainer.rotationZ;
      this.startingMouseX = this.stage.mouseX;
      this.times[0] = getTimer();
      this.times[1] = this.times[0];
      this.rotations[0] = this.cameraContainer.rotationZ;
      this.rotations[1] = this.rotations[0];
    }

    public function update() : void {
      this.cameraContainer.rotationZ = this.getRotationZ();
      this.times[1] = this.times[0];
      this.times[0] = getTimer();
      this.rotations[1] = this.rotations[0];
      this.rotations[0] = this.cameraContainer.rotationZ;
    }

    public function exit() : void {
      this.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
    }

    private function onStageMouseUp(param1:MouseEvent) : void {
      this.cameraContainer.rotationZ = this.getRotationZ();
      var local2:Number = (getTimer() - this.times[1]) / 1000;
      if(local2 == 0) {
        local2 = 0.1;
      }
      this.context.angularSpeed = (this.cameraContainer.rotationZ - this.rotations[1]) / local2;
      this.stateMachine.handleEvent(this,TankPreviewEvent.STOP_MANUAL_ROTATION);
    }

    private function getRotationZ() : Number {
      var local1:Number = 2 * Math.PI / this.camera.view.width;
      return this.startingRotatonZ + (this.startingMouseX - this.stage.mouseX) * local1;
    }
  }
}
