package alternativa.tanks.models.weapon.freeze {
  import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IFreezeSFXModelAdapt implements IFreezeSFXModel {
    private var object:IGameObject;
    private var impl:IFreezeSFXModel;

    public function IFreezeSFXModelAdapt(param1:IGameObject, param2:IFreezeSFXModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getFreezeEffects(param1:Number, param2:Number) : StreamWeaponEffects {
      var result:StreamWeaponEffects = null;
      var damageAreaRange:Number = param1;
      var damageAreaConeAngle:Number = param2;
      try {
        Model.object = this.object;
        result = this.impl.getFreezeEffects(damageAreaRange,damageAreaConeAngle);
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
