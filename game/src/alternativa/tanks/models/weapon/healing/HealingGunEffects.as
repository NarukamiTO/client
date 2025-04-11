package alternativa.tanks.models.weapon.healing {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisState;

  public interface HealingGunEffects {
    function init(param1:Object3D, param2:Vector3) : void;
    function setLocalEffectsType(param1:IsisState, param2:Tank = null, param3:Vector3 = null) : void;
    function setRemoteEffectsType(param1:IsisState, param2:Tank = null, param3:Vector3 = null) : void;
    function stopEffects() : void;
    function setBuffedMode(param1:Boolean) : void;
  }
}
