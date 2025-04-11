package projects.tanks.client.battlefield.models.tankparts.weapons.common.shell {
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface IShellWeaponCommunicationModelBase {
    function shoot(param1:int, param2:int, param3:Vector3d) : void;
    function shootDummy(param1:int) : void;
    function shootWithTarget(param1:int, param2:int, param3:Vector3d, param4:TargetPosition, param5:Vector3d) : void;
  }
}
