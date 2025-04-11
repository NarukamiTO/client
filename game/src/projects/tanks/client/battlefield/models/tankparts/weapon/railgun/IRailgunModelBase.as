package projects.tanks.client.battlefield.models.tankparts.weapon.railgun {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface IRailgunModelBase {
    function fire(param1:IGameObject, param2:Vector3d, param3:Vector.<IGameObject>, param4:Vector.<Vector3d>) : void;
    function fireDummy(param1:IGameObject) : void;
    function immediateReload() : void;
    function reconfigureWeapon(param1:int) : void;
    function startCharging(param1:IGameObject) : void;
  }
}
