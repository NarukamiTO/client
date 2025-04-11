package alternativa.tanks.models.coloradjust {
  import flash.geom.ColorTransform;
  import projects.tanks.client.battlefield.models.coloradjust.ColorAdjustModelBase;
  import projects.tanks.client.battlefield.models.coloradjust.ColorAdjustParams;
  import projects.tanks.client.battlefield.models.coloradjust.IColorAdjustModelBase;

  [ModelInfo]
  public class ColorAdjustModel extends ColorAdjustModelBase implements IColorAdjustModelBase, IColorAdjust {
    public function ColorAdjustModel() {
      super();
    }

    private function createColorTransform(param1:ColorAdjustParams) : ColorTransform {
      return new ColorTransform(param1.redMultiplier,param1.greenMultiplier,param1.blueMultiplier,param1.alphaMultiplier,param1.redOffset,param1.greenOffset,param1.blueOffset,param1.alphaOffset);
    }

    public function getHWHeat() : ColorTransform {
      return this.createColorTransform(getInitParam().heatParamsHW);
    }

    public function getHWFrost() : ColorTransform {
      return this.createColorTransform(getInitParam().frostParamsHW);
    }

    public function getSoftHeat() : ColorTransform {
      return this.createColorTransform(getInitParam().heatParamsSoft);
    }

    public function getSoftFrost() : ColorTransform {
      return this.createColorTransform(getInitParam().frostParamsSoft);
    }
  }
}
