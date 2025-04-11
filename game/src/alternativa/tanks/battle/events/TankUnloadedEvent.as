package alternativa.tanks.battle.events {
  import alternativa.tanks.battle.objects.tank.Tank;

  public class TankUnloadedEvent {
    public var tank:Tank;
    public var isLocal:Boolean;

    public function TankUnloadedEvent(param1:Tank, param2:Boolean) {
      super();
      this.tank = param1;
      this.isLocal = param2;
    }
  }
}
