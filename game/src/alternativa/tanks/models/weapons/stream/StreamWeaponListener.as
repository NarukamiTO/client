package alternativa.tanks.models.weapons.stream {
  import alternativa.math.Vector3;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;

  [ModelInterface]
  public interface StreamWeaponListener {
    function onStart() : void;
    function onStop() : void;
    function onTargetsUpdated(param1:Vector3, param2:Vector.<TargetHit>) : void;
  }
}
