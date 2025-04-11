package alternativa.tanks.services.colortransform.impl {
  import alternativa.tanks.services.colortransform.ColorTransformService;
  import alternativa.tanks.services.colortransform.ColorTransformer;
  import flash.geom.ColorTransform;

  public class HardwareColorTransformService implements ColorTransformService {
    private var heatColorAdjust:ColorTransform;
    private var frostColorAdjust:ColorTransform;

    public function HardwareColorTransformService() {
      super();
    }

    public function setColorTransform(param1:ColorTransform) : void {
    }

    public function getColorTransform() : ColorTransform {
      return null;
    }

    public function addColorTransformer(param1:ColorTransformer) : void {
    }

    public function setColorAdjust(param1:ColorTransform, param2:ColorTransform, param3:ColorTransform, param4:ColorTransform) : void {
      this.heatColorAdjust = param3;
      this.frostColorAdjust = param4;
    }

    public function getHeatColorAdjust() : ColorTransform {
      return this.heatColorAdjust;
    }

    public function getFrostColorAdjust() : ColorTransform {
      return this.frostColorAdjust;
    }
  }
}
