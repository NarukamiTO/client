package alternativa.tanks.models.mapbonuslight {
  import flash.geom.ColorTransform;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IMapBonusLightEvents implements IMapBonusLight {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IMapBonusLightEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getBonusLightIntensity() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:IMapBonusLight = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapBonusLight(this.impl[i]);
          result = Number(m.getBonusLightIntensity());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getHWBonusColorAdjust() : ColorTransform {
      var result:ColorTransform = null;
      var i:int = 0;
      var m:IMapBonusLight = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapBonusLight(this.impl[i]);
          result = m.getHWBonusColorAdjust();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSoftBonusColorAdjust() : ColorTransform {
      var result:ColorTransform = null;
      var i:int = 0;
      var m:IMapBonusLight = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMapBonusLight(this.impl[i]);
          result = m.getSoftBonusColorAdjust();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
