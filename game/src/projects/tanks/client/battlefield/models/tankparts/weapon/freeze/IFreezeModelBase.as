package projects.tanks.client.battlefield.models.tankparts.weapon.freeze {
  import platform.client.fp10.core.type.IGameObject;

  public interface IFreezeModelBase {
    function startFire(param1:IGameObject) : void;
    function stopFire(param1:IGameObject) : void;
  }
}
