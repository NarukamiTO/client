package projects.tanks.client.battlefield.models.tankparts.weapon.healing {
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;

  public interface IIsisModelBase {
    function addEnergy(param1:int) : void;
    function reconfigureWeapon(param1:Number, param2:Number, param3:Number, param4:Number) : void;
    function resetTarget() : void;
    function setTarget(param1:IsisState, param2:TargetHit) : void;
    function stopWeapon() : void;
  }
}
