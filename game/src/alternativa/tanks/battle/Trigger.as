package alternativa.tanks.battle {
  import alternativa.physics.Body;

  public interface Trigger {
    function checkTrigger(param1:Body) : void;
  }
}
