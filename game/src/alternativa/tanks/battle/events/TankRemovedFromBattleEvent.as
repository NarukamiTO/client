package alternativa.tanks.battle.events {
  import alternativa.tanks.battle.objects.tank.Tank;

  public class TankRemovedFromBattleEvent {
    public var tank:Tank;

    public function TankRemovedFromBattleEvent(param1:Tank) {
      super();
      this.tank = param1;
    }
  }
}
