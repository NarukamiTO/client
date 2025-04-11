package alternativa.tanks.battle.events {
  import alternativa.tanks.battle.objects.tank.Tank;

  public class TankActivationEvent {
    public var tank:Tank;

    public function TankActivationEvent(param1:Tank) {
      super();
      this.tank = param1;
    }
  }
}
