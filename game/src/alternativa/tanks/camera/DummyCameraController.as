package alternativa.tanks.camera {
  public class DummyCameraController implements CameraController {
    public static const INSTANCE:DummyCameraController = new DummyCameraController();

    public function DummyCameraController() {
      super();
    }

    public function update(param1:GameCamera, param2:int, param3:int) : void {
    }

    public function deactivate() : void {
    }

    public function activate(param1:GameCamera) : void {
    }
  }
}
