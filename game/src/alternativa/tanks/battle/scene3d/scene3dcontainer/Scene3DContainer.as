package alternativa.tanks.battle.scene3d.scene3dcontainer {
  import alternativa.engine3d.core.Object3D;

  public interface Scene3DContainer {
    function addChild(param1:Object3D) : void;
    function addChildAt(param1:Object3D, param2:int) : void;
    function addChildren(param1:Vector.<Object3D>) : void;
    function removeChild(param1:Object3D) : void;
  }
}
