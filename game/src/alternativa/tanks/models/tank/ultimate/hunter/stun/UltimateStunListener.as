package alternativa.tanks.models.tank.ultimate.hunter.stun {
  import alternativa.tanks.battle.objects.tank.Tank;

  [ModelInterface]
  public interface UltimateStunListener {
    function onStun(param1:Tank, param2:Boolean) : void;
    function onCalm(param1:Tank, param2:Boolean, param3:int) : void;
  }
}
