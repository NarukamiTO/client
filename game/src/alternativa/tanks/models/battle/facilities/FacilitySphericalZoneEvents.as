package alternativa.tanks.models.battle.facilities {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class FacilitySphericalZoneEvents implements FacilitySphericalZone {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function FacilitySphericalZoneEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getRadius() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:FacilitySphericalZone = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FacilitySphericalZone(this.impl[i]);
          result = Number(m.getRadius());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCenterOffsetZ() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:FacilitySphericalZone = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FacilitySphericalZone(this.impl[i]);
          result = Number(m.getCenterOffsetZ());
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
