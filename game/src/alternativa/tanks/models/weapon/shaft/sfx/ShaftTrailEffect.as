package alternativa.tanks.models.weapon.shaft.sfx {
  import alternativa.engine3d.materials.Material;
  import alternativa.math.Vector3;
  import alternativa.tanks.sfx.GraphicEffect;

  public interface ShaftTrailEffect extends GraphicEffect {
    function init(param1:Vector3, param2:Vector3, param3:Number, param4:Number, param5:Material, param6:int) : void;
  }
}
