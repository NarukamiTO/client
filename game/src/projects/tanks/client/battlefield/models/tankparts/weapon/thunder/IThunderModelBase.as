package projects.tanks.client.battlefield.models.tankparts.weapon.thunder {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface IThunderModelBase {
    function shoot(param1:IGameObject) : void;
    function shootStatic(param1:IGameObject, param2:Vector3d) : void;
    function shootTarget(param1:IGameObject, param2:IGameObject, param3:Vector3d) : void;
  }
}
