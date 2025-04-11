package alternativa.tanks.models.weapon.flamethrower {
  import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IFlamethrowerSFXModelAdapt implements IFlamethrowerSFXModel {
    private var object:IGameObject;
    private var impl:IFlamethrowerSFXModel;

    public function IFlamethrowerSFXModelAdapt(param1:IGameObject, param2:IFlamethrowerSFXModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getFlamethrowerEffects(param1:Number, param2:Number) : StreamWeaponEffects {
      var result:StreamWeaponEffects = null;
      var range:Number = param1;
      var coneAngle:Number = param2;
      try {
        Model.object = this.object;
        result = this.impl.getFlamethrowerEffects(range,coneAngle);
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
