package alternativa.tanks.models.weapons.discrete {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;

  [ModelInterface]
  public interface DiscreteWeaponListener {
    function onShot(param1:IGameObject, param2:Vector3, param3:Vector.<TargetHit>) : void;
  }
}
