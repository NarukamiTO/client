package alternativa.tanks.models.weapon {
  import alternativa.tanks.battle.objects.tank.Weapon;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IWeaponModelAdapt implements IWeaponModel {
    private var object:IGameObject;
    private var impl:IWeaponModel;

    public function IWeaponModelAdapt(param1:IGameObject, param2:IWeaponModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      var result:Weapon = null;
      var user:IGameObject = param1;
      try {
        Model.object = this.object;
        result = this.impl.createLocalWeapon(user);
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var result:Weapon = null;
      var user:IGameObject = param1;
      try {
        Model.object = this.object;
        result = this.impl.createRemoteWeapon(user);
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
