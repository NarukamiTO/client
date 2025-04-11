package alternativa.tanks.services.colortransform {
  import flash.geom.ColorTransform;

  public interface ColorTransformService {
    function setColorTransform(param1:ColorTransform) : void;
    function getColorTransform() : ColorTransform;
    function addColorTransformer(param1:ColorTransformer) : void;
    function setColorAdjust(param1:ColorTransform, param2:ColorTransform, param3:ColorTransform, param4:ColorTransform) : void;
    function getHeatColorAdjust() : ColorTransform;
    function getFrostColorAdjust() : ColorTransform;
  }
}
