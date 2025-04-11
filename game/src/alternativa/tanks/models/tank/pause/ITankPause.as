package alternativa.tanks.models.tank.pause {
  [ModelInterface]
  public interface ITankPause {
    function enablePause() : void;
    function disablePause() : void;
    function resetIdleKickTime() : void;
  }
}
