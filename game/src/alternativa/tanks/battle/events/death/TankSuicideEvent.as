package alternativa.tanks.battle.events.death {
  import platform.client.fp10.core.type.IGameObject;

  public class TankSuicideEvent {
    public var victim:IGameObject;

    public function TankSuicideEvent(param1:IGameObject) {
      super();
      this.victim = param1;
    }
  }
}
