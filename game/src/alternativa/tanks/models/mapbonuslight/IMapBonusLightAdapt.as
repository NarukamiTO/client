package alternativa.tanks.models.mapbonuslight {
  import flash.geom.ColorTransform;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IMapBonusLightAdapt implements IMapBonusLight {
    private var object:IGameObject;
    private var impl:IMapBonusLight;

    public function IMapBonusLightAdapt(param1:IGameObject, param2:IMapBonusLight) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getBonusLightIntensity() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getBonusLightIntensity());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getHWBonusColorAdjust() : ColorTransform {
      var result:ColorTransform = null;
      try {
        Model.object = this.object;
        result = this.impl.getHWBonusColorAdjust();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSoftBonusColorAdjust() : ColorTransform {
      var result:ColorTransform = null;
      try {
        Model.object = this.object;
        result = this.impl.getSoftBonusColorAdjust();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
