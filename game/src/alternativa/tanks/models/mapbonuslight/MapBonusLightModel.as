package alternativa.tanks.models.mapbonuslight {
  import flash.geom.ColorTransform;
  import projects.tanks.client.battlefield.models.coloradjust.ColorAdjustParams;
  import projects.tanks.client.battlefield.models.mapbonuslight.IMapBonusLightModelBase;
  import projects.tanks.client.battlefield.models.mapbonuslight.MapBonusLightModelBase;

  [ModelInfo]
  public class MapBonusLightModel extends MapBonusLightModelBase implements IMapBonusLight, IMapBonusLightModelBase {
    public function MapBonusLightModel() {
      super();
    }

    public function getBonusLightIntensity() : Number {
      return getInitParam().bonusLightIntensity;
    }

    public function getHWBonusColorAdjust() : ColorTransform {
      return this.createColorTransform(getInitParam().hwColorAdjust);
    }

    public function getSoftBonusColorAdjust() : ColorTransform {
      return this.createColorTransform(getInitParam().softColorAdjust);
    }

    private function createColorTransform(param1:ColorAdjustParams) : ColorTransform {
      return new ColorTransform(param1.redMultiplier,param1.greenMultiplier,param1.blueMultiplier,param1.alphaMultiplier,param1.redOffset,param1.greenOffset,param1.blueOffset,param1.alphaOffset);
    }
  }
}
