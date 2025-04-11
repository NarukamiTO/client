package alternativa.tanks.camera {
  public interface CameraController {
    function deactivate() : void;
    function activate(param1:GameCamera) : void;
    function update(param1:GameCamera, param2:int, param3:int) : void;
  }
}
