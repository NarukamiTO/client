package alternativa.tanks.camera.controllers.spectator {
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;

  public interface MovementMethod {
    function getDisplacement(param1:UserInput, param2:GameCamera, param3:Number) : Vector3;
    function invertAcceleration() : void;
    function setAccelerationInverted(param1:Boolean) : void;
    function accelerationInverted() : Boolean;
  }
}
