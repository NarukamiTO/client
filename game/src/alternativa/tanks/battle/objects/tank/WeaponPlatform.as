package alternativa.tanks.battle.objects.tank {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.BasicGlobalGunParams;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public interface WeaponPlatform {
    function getAllGunParams(param1:AllGlobalGunParams, param2:int = 0) : void;
    function getBasicGunParams(param1:BasicGlobalGunParams, param2:int = 0) : void;
    function getBody() : Body;
    function getLocalMuzzlePosition(param1:int = 0) : Vector3;
    function getLaserLocalPosition() : Vector3;
    function getBarrelLength(param1:int = 0) : Number;
    function getTurret3D() : Object3D;
    function stopMovement() : void;
    function lockMovement(param1:Boolean) : void;
    function getNumberOfBarrels() : int;
    function enableTurretSound(param1:Boolean) : void;
    function getSkin() : TankSkin;
    function showTitle() : void;
    function addDust(param1:int = 7) : void;
    function get teamType() : BattleTeam;
    function getWeaponMount() : WeaponMount;
  }
}
