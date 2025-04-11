package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.Tank;

  [ModelInterface]
  public interface InitTankPart {
    function initTankPart(param1:Tank) : void;
  }
}
