package projects.tanks.client.battlefield.models.tankparts.weapon.shaft {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface IShaftModelBase {
    function activateManualTargeting(param1:IGameObject) : void;
    function fire(param1:IGameObject, param2:Vector3d, param3:IGameObject, param4:Vector3d, param5:Number) : void;
    function reconfigureWeapon(param1:Number, param2:Number, param3:Boolean) : void;
    function stopManulaTargeting(param1:IGameObject) : void;
  }
}
