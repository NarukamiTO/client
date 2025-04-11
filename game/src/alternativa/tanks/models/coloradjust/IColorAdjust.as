package alternativa.tanks.models.coloradjust {
  import flash.geom.ColorTransform;

  [ModelInterface]
  public interface IColorAdjust {
    function getHWHeat() : ColorTransform;
    function getHWFrost() : ColorTransform;
    function getSoftHeat() : ColorTransform;
    function getSoftFrost() : ColorTransform;
  }
}
