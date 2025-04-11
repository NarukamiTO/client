package projects.tanks.client.battlefield.models.tankparts.weapons.common.stream {
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface IStreamWeaponCommunicationModelBase {
    function startFire() : void;
    function stopFire() : void;
    function updateTargets(param1:Vector3d, param2:Vector.<TargetHit>) : void;
  }
}
