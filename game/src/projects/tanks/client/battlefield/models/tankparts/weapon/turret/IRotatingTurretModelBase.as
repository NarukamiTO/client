package projects.tanks.client.battlefield.models.tankparts.weapon.turret {
  import projects.tanks.client.battlefield.models.user.tank.commands.TurretStateCommand;

  public interface IRotatingTurretModelBase {
    function update(param1:TurretStateCommand) : void;
  }
}
