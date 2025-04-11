package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponMountProviderEvents implements WeaponMountProvider {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function WeaponMountProviderEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createWeaponMount(param1:IGameObject) : WeaponMount {
      var result:WeaponMount = null;
      var i:int = 0;
      var m:WeaponMountProvider = null;
      var tankObject:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = WeaponMountProvider(this.impl[i]);
          result = m.createWeaponMount(tankObject);
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
