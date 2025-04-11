package projects.tanks.client.battlefield.models.tankparts.weapon.flamethrower {
  import platform.client.fp10.core.type.IGameObject;

  public interface IFlameThrowerModelBase {
    function startFire(param1:IGameObject) : void;
    function stopFire(param1:IGameObject) : void;
  }
}
