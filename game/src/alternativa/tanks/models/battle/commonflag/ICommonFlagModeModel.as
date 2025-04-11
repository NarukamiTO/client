package alternativa.tanks.models.battle.commonflag {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import projects.tanks.client.battlefield.models.battle.pointbased.ClientTeamPoint;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  [ModelInterface]
  public interface ICommonFlagModeModel {
    function initFlag(param1:CommonFlag, param2:ClientFlag) : void;
    function createBasePoint(param1:ClientTeamPoint, param2:Tanks3DSResource) : Object3D;
    function getFlags() : Vector.<ClientFlag>;
    function getPoints() : Vector.<ClientTeamPoint>;
    function getLocalTank() : Tank;
    function onFlagTouch(param1:CommonFlag) : void;
    function onPickupTimeoutPassed(param1:CommonFlag) : void;
    function addMineProtectedZone(param1:Vector3) : void;
  }
}
