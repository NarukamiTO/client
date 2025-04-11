package alternativa.tanks.models.weapon.artillery {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IArtilleryModelAdapt implements IArtilleryModel {
    private var object:IGameObject;
    private var impl:IArtilleryModel;

    public function IArtilleryModelAdapt(param1:IGameObject, param2:IArtilleryModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDefaultElevation() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getDefaultElevation());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getWeapon() : ArtilleryWeapon {
      var result:ArtilleryWeapon = null;
      try {
        Model.object = this.object;
        result = this.impl.getWeapon();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
