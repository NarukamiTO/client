package projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface IDiscreteWeaponCommunicationModelBase {
    function shoot(param1:IGameObject, param2:Vector3d, param3:Vector.<TargetHit>) : void;
  }
}
