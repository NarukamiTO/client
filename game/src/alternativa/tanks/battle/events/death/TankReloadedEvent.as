package alternativa.tanks.battle.events.death {
  import alternativa.types.Long;

  public class TankReloadedEvent {
    public var userId:Long;

    public function TankReloadedEvent(param1:Long) {
      super();
      this.userId = param1;
    }
  }
}
