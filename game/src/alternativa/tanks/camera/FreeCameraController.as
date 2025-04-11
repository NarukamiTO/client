package alternativa.tanks.camera {
  import alternativa.engine3d.controllers.SimpleObjectController;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.osgi.service.command.FormattedOutput;
  import flash.display.InteractiveObject;

  public class FreeCameraController implements CameraController {
    private var simpleController:SimpleObjectController;

    public function FreeCameraController(param1:InteractiveObject, param2:Camera3D) {
      super();
      this.simpleController = new SimpleObjectController(param1,param2,500,10);
      this.simpleController.disable();
      this.simpleController.setDefaultBindings();
    }

    public function activate(param1:GameCamera) : void {
      this.simpleController.updateObjectTransform();
      this.simpleController.enable();
    }

    public function deactivate() : void {
      this.simpleController.disable();
    }

    public function update(param1:GameCamera, param2:int, param3:int) : void {
      this.simpleController.update();
    }

    private function registerDebugCommands() : void {
    }

    private function showCameraPosition(param1:FormattedOutput) : void {
    }

    private function setCameraPosition(param1:FormattedOutput, param2:Number, param3:Number, param4:Number) : void {
    }

    private function lookAt(param1:FormattedOutput, param2:Number, param3:Number, param4:Number) : void {
    }
  }
}
