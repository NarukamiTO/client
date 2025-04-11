package projects.tanks.client.battlefield.models.tankparts.weapon.twins {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface ITwinsModelBase {
    function fire(param1:IGameObject, param2:int, param3:int, param4:Vector3d) : void;
    function fireDummy(param1:IGameObject, param2:int) : void;
  }
}
