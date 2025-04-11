package alternativa.tanks.sfx {
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;

  public interface GraphicEffect {
    function addedToScene(param1:Scene3DContainer) : void;
    function play(param1:int, param2:GameCamera) : Boolean;
    function destroy() : void;
    function kill() : void;
  }
}
