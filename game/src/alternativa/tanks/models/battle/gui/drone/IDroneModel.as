package alternativa.tanks.models.battle.gui.drone {
  import alternativa.tanks.battle.objects.tank.Tank;
  import projects.tanks.client.battlefield.models.user.tank.TankLogicState;

  [ModelInterface]
  public interface IDroneModel {
    function initDrones(param1:Tank, param2:Boolean, param3:TankLogicState) : void;
    function canOverheal() : Boolean;
  }
}
