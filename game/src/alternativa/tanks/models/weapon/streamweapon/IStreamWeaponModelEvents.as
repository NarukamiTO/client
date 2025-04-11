package alternativa.tanks.models.weapon.streamweapon {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IStreamWeaponModelEvents implements IStreamWeaponModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IStreamWeaponModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getStreamWeaponData() : StreamWeaponData {
      var result:StreamWeaponData = null;
      var i:int = 0;
      var m:IStreamWeaponModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStreamWeaponModel(this.impl[i]);
          result = m.getStreamWeaponData();
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
