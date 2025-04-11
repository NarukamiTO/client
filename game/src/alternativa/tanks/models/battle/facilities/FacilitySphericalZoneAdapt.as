package alternativa.tanks.models.battle.facilities {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class FacilitySphericalZoneAdapt implements FacilitySphericalZone {
    private var object:IGameObject;
    private var impl:FacilitySphericalZone;

    public function FacilitySphericalZoneAdapt(param1:IGameObject, param2:FacilitySphericalZone) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getRadius() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getRadius());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCenterOffsetZ() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getCenterOffsetZ());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
