package projects.tanks.client.battlefield.models.user.tank {
  import alternativa.types.Long;
  import projects.tanks.client.battlefield.models.user.tank.commands.MoveCommand;
  import projects.tanks.client.battlefield.types.DamageType;
  import projects.tanks.client.battlefield.types.Vector3d;

  public interface ITankModelBase {
    function activateTank() : void;
    function deathConfirmed() : void;
    function kill(param1:Long, param2:int, param3:DamageType) : void;
    function move(param1:MoveCommand) : void;
    function movementControl(param1:int, param2:int) : void;
    function push(param1:Vector3d, param2:Vector3d) : void;
    function resetConfiguration(param1:Long, param2:Long, param3:Long, param4:int) : void;
    function setHealth(param1:Number) : void;
  }
}
