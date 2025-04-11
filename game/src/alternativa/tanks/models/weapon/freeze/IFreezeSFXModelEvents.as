package alternativa.tanks.models.weapon.freeze {
  import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IFreezeSFXModelEvents implements IFreezeSFXModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IFreezeSFXModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getFreezeEffects(param1:Number, param2:Number) : StreamWeaponEffects {
      var result:StreamWeaponEffects = null;
      var i:int = 0;
      var m:IFreezeSFXModel = null;
      var damageAreaRange:Number = param1;
      var damageAreaConeAngle:Number = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IFreezeSFXModel(this.impl[i]);
          result = m.getFreezeEffects(damageAreaRange,damageAreaConeAngle);
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
