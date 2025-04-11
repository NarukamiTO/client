package alternativa.tanks.battle.events {
  public class SpeedHackEvent {
    public var deltas:Array;

    public function SpeedHackEvent(param1:Array) {
      super();
      this.deltas = param1;
    }
  }
}
