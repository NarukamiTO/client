package alternativa.tanks.battle.events {
  public class PauseActivationEvent {
    public var idleTimeLeft:int;

    public function PauseActivationEvent(param1:int) {
      super();
      this.idleTimeLeft = param1;
    }
  }
}
