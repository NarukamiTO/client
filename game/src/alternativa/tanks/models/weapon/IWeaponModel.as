package alternativa.tanks.models.weapon {
  import alternativa.tanks.battle.objects.tank.Weapon;
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface IWeaponModel {
    function createLocalWeapon(param1:IGameObject) : Weapon;
    function createRemoteWeapon(param1:IGameObject) : Weapon;
  }
}
