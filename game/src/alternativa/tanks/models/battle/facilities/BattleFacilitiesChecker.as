package alternativa.tanks.models.battle.facilities {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;

  [ModelInterface]
  public interface BattleFacilitiesChecker {
    function checkFacilityZonesDemandsStateCorrection(param1:Vector3, param2:Vector3) : Boolean;
    function onMoveCommand(param1:Tank, param2:Vector3, param3:Vector3) : void;
  }
}
