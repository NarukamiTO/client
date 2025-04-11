package alternativa.tanks.models.tank.resistance {
  import projects.tanks.client.battlefield.models.user.resistance.TankResistance;

  [ModelInterface]
  public interface TankResistances {
    function getResistance(param1:Boolean) : int;
    function getResistances() : Vector.<TankResistance>;
    function updateOthersResistances() : void;
  }
}
