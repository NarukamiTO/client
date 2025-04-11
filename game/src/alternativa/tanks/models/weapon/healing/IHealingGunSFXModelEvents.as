package alternativa.tanks.models.weapon.healing {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IHealingGunSFXModelEvents implements IHealingGunSFXModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IHealingGunSFXModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getHealingGunEffects() : HealingGunEffects {
      var result:HealingGunEffects = null;
      var i:int = 0;
      var m:IHealingGunSFXModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IHealingGunSFXModel(this.impl[i]);
          result = m.getHealingGunEffects();
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
