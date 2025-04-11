package alternativa.tanks.models.weapon.streamweapon {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IStreamWeaponModelAdapt implements IStreamWeaponModel {
    private var object:IGameObject;
    private var impl:IStreamWeaponModel;

    public function IStreamWeaponModelAdapt(param1:IGameObject, param2:IStreamWeaponModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getStreamWeaponData() : StreamWeaponData {
      var result:StreamWeaponData = null;
      try {
        Model.object = this.object;
        result = this.impl.getStreamWeaponData();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
