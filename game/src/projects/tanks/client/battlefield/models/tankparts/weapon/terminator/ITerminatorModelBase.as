package projects.tanks.client.battlefield.models.tankparts.weapon.terminator {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface ITerminatorModelBase {
    function primaryRemoteCharge(param1:IGameObject, param2:int) : void;
    function primaryRemoteDummy(param1:IGameObject, param2:int) : void;
    function primaryRemoteShot(param1:IGameObject, param2:Vector3d, param3:Vector.<IGameObject>, param4:Vector.<Vector3d>, param5:int) : void;
    function secondaryRemoteHide(param1:IGameObject) : void;
    function secondaryRemoteOpen(param1:IGameObject) : void;
  }
}
