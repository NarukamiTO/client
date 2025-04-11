package alternativa.tanks.sfx {
  import alternativa.math.Vector3;
  import alternativa.tanks.camera.GameCamera;

  public interface ISound3DEffect {
    function play(param1:int, param2:GameCamera) : void;
    function destroy() : void;
    function kill() : void;
    function set enabled(param1:Boolean) : void;
    function readPosition(param1:Vector3) : void;
    function get numSounds() : int;
  }
}
