package alternativa.tanks.services.colortransform.impl {
  import alternativa.tanks.services.colortransform.*;
  import flash.geom.ColorTransform;

  public class SoftwareColorTransformService implements ColorTransformService {
    private const transformers:Vector.<ColorTransformer> = new Vector.<ColorTransformer>();

    private var colorTransform:ColorTransform;
    private var heatColorAdjust:ColorTransform;
    private var frostColorAdjust:ColorTransform;

    public function SoftwareColorTransformService() {
      super();
    }

    public function addColorTransformer(param1:ColorTransformer) : void {
      this.transformers.push(param1);
      param1.setColorTransform(this.colorTransform);
    }

    public function setColorTransform(param1:ColorTransform) : void {
      var local2:ColorTransformer = null;
      if(!ColorTransformUtils.equal(this.colorTransform,param1)) {
        this.colorTransform = ColorTransformUtils.clone(param1);
        for each(local2 in this.transformers) {
          local2.setColorTransform(this.colorTransform);
        }
      }
    }

    public function getColorTransform() : ColorTransform {
      return ColorTransformUtils.clone(this.colorTransform);
    }

    public function setColorAdjust(param1:ColorTransform, param2:ColorTransform, param3:ColorTransform, param4:ColorTransform) : void {
      this.heatColorAdjust = param1;
      this.frostColorAdjust = param2;
    }

    public function getHeatColorAdjust() : ColorTransform {
      return this.heatColorAdjust;
    }

    public function getFrostColorAdjust() : ColorTransform {
      return this.frostColorAdjust;
    }
  }
}
