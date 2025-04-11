package alternativa.tanks.models.weapon.weakening {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IWeaponWeakeningModelAdapt implements IWeaponWeakeningModel {
    private var object:IGameObject;
    private var impl:IWeaponWeakeningModel;

    public function IWeaponWeakeningModelAdapt(param1:IGameObject, param2:IWeaponWeakeningModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDistanceWeakening() : DistanceWeakening {
      var result:DistanceWeakening = null;
      try {
        Model.object = this.object;
        result = this.impl.getDistanceWeakening();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
