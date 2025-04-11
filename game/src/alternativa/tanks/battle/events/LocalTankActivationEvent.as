package alternativa.tanks.battle.events {
  import alternativa.tanks.battle.objects.tank.Tank;

  public class LocalTankActivationEvent {
    public var tank:Tank;

    public function LocalTankActivationEvent(param1:Tank) {
      super();
      this.tank = param1;
    }
  }
}
