package alternativa.tanks.battle.events.reload {
  public class ReloadScheduledEvent {
    public var suicideDelayMS:int;

    public function ReloadScheduledEvent(param1:int) {
      super();
      this.suicideDelayMS = param1;
    }
  }
}
