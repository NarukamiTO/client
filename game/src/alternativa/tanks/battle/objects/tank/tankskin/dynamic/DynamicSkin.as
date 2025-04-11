package alternativa.tanks.battle.objects.tank.tankskin.dynamic {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.materials.Material;

  public interface DynamicSkin {
    function addFace(param1:Face) : void;
    function init() : void;
    function rotate(param1:Number) : void;
    function reset() : void;
    function setMaterial(param1:Material) : void;
  }
}
