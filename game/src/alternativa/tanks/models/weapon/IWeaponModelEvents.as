package alternativa.tanks.models.weapon {
  import alternativa.tanks.battle.objects.tank.Weapon;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IWeaponModelEvents implements IWeaponModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IWeaponModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createLocalWeapon(param1:IGameObject) : Weapon {
      var result:Weapon = null;
      var i:int = 0;
      var m:IWeaponModel = null;
      var user:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IWeaponModel(this.impl[i]);
          result = m.createLocalWeapon(user);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function createRemoteWeapon(param1:IGameObject) : Weapon {
      var result:Weapon = null;
      var i:int = 0;
      var m:IWeaponModel = null;
      var user:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IWeaponModel(this.impl[i]);
          result = m.createRemoteWeapon(user);
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
