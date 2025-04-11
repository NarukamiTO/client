package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.Tank;

  [ModelInterface]
  public interface TankPartReset {
    function resetTankPart(param1:Tank) : void;
  }
}
