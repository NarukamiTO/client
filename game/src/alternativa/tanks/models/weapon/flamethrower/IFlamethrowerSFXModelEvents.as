package alternativa.tanks.models.weapon.flamethrower {
  import alternativa.tanks.models.weapon.shared.streamweapon.StreamWeaponEffects;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IFlamethrowerSFXModelEvents implements IFlamethrowerSFXModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IFlamethrowerSFXModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getFlamethrowerEffects(param1:Number, param2:Number) : StreamWeaponEffects {
      var result:StreamWeaponEffects = null;
      var i:int = 0;
      var m:IFlamethrowerSFXModel = null;
      var range:Number = param1;
      var coneAngle:Number = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IFlamethrowerSFXModel(this.impl[i]);
          result = m.getFlamethrowerEffects(range,coneAngle);
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
