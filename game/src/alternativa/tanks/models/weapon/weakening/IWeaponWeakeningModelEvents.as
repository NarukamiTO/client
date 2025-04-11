package alternativa.tanks.models.weapon.weakening {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IWeaponWeakeningModelEvents implements IWeaponWeakeningModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IWeaponWeakeningModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDistanceWeakening() : DistanceWeakening {
      var result:DistanceWeakening = null;
      var i:int = 0;
      var m:IWeaponWeakeningModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IWeaponWeakeningModel(this.impl[i]);
          result = m.getDistanceWeakening();
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
