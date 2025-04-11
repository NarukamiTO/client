package alternativa.tanks.camera {
  import alternativa.math.Vector3;

  public interface ICameraStateModifier {
    function update(param1:int, param2:int, param3:Vector3, param4:Vector3) : Boolean;
    function onAddedToController(param1:IFollowCameraController) : void;
    function destroy() : void;
  }
}
