package projects.tanks.client.battlefield.models.tankparts.weapon.ricochet {
  import platform.client.fp10.core.type.IGameObject;

  public interface IRicochetModelBase {
    function addEnergy(param1:int) : void;
    function fire(param1:IGameObject, param2:int, param3:int, param4:int) : void;
    function fireDummy(param1:IGameObject) : void;
    function reconfigureWeapon(param1:Number, param2:Number) : void;
  }
}
