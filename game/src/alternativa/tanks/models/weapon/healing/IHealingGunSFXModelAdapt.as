package alternativa.tanks.models.weapon.healing {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IHealingGunSFXModelAdapt implements IHealingGunSFXModel {
    private var object:IGameObject;
    private var impl:IHealingGunSFXModel;

    public function IHealingGunSFXModelAdapt(param1:IGameObject, param2:IHealingGunSFXModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getHealingGunEffects() : HealingGunEffects {
      var result:HealingGunEffects = null;
      try {
        Model.object = this.object;
        result = this.impl.getHealingGunEffects();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
