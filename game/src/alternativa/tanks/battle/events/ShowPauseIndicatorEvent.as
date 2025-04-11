package alternativa.tanks.battle.events {
  public class ShowPauseIndicatorEvent {
    public var idleTimeLeft:int;

    public function ShowPauseIndicatorEvent(param1:int) {
      super();
      this.idleTimeLeft = param1;
    }
  }
}
