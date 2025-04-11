package alternativa.tanks.battle.events {
  import alternativa.tanks.battle.objects.tank.Tank;

  public class TankAddedToBattleEvent {
    public var tank:Tank;
    public var isLocal:Boolean;

    public function TankAddedToBattleEvent(param1:Tank, param2:Boolean) {
      super();
      this.tank = param1;
      this.isLocal = param2;
    }
  }
}
