package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface WeaponMountProvider {
    function createWeaponMount(param1:IGameObject) : WeaponMount;
  }
}
