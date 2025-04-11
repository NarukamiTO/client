package alternativa.tanks.models.mapbonuslight {
  import flash.geom.ColorTransform;

  [ModelInterface]
  public interface IMapBonusLight {
    function getBonusLightIntensity() : Number;
    function getHWBonusColorAdjust() : ColorTransform;
    function getSoftBonusColorAdjust() : ColorTransform;
  }
}
