package alternativa.tanks.battle.events.death {
  import platform.client.fp10.core.type.IGameObject;

  public class TankDeadEvent {
    public var victim:IGameObject;

    public function TankDeadEvent(param1:IGameObject) {
      super();
      this.victim = param1;
    }
  }
}
