package projects.tanks.client.battlefield.models.tankparts.weapon.laser {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface ILaserPointerModelBase {
    function aimRemoteAtTank(param1:IGameObject, param2:Vector3d) : void;
    function hideRemote() : void;
    function updateRemoteDirection(param1:Number) : void;
  }
}
