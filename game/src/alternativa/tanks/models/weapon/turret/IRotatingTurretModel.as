package alternativa.tanks.models.weapon.turret {
  import alternativa.tanks.battle.objects.tank.controllers.LocalTurretController;
  import alternativa.tanks.battle.objects.tank.controllers.Turret;

  [ModelInterface]
  public interface IRotatingTurretModel {
    function getLocalTurretController() : LocalTurretController;
    function getTurret() : Turret;
  }
}
