package projects.tanks.client.battlefield.models.tankparts.weapon.gauss {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface IGaussModelBase {
    function dummyShot() : void;
    function primaryShot(param1:int, param2:Vector3d) : void;
    function secondaryHitTargetCommand(param1:IGameObject, param2:Vector3d) : void;
    function startAiming() : void;
    function stopAiming() : void;
  }
}
