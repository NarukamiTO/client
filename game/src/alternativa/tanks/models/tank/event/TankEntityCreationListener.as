package alternativa.tanks.models.tank.event {
  import alternativa.tanks.battle.objects.tank.Tank;
  import projects.tanks.client.battlefield.models.user.tank.TankLogicState;

  [ModelInterface]
  public interface TankEntityCreationListener {
    function onTankEntityCreated(param1:Tank, param2:Boolean, param3:TankLogicState) : void;
  }
}
