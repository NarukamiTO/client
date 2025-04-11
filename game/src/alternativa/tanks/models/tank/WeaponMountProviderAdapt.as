package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponMountProviderAdapt implements WeaponMountProvider {
    private var object:IGameObject;
    private var impl:WeaponMountProvider;

    public function WeaponMountProviderAdapt(param1:IGameObject, param2:WeaponMountProvider) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createWeaponMount(param1:IGameObject) : WeaponMount {
      var result:WeaponMount = null;
      var tankObject:IGameObject = param1;
      try {
        Model.object = this.object;
        result = this.impl.createWeaponMount(tankObject);
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
