package alternativa.tanks.battle.events {
  import alternativa.types.Long;

  public class EffectActivatedEvent {
    public var userId:Long;
    public var effectId:int;
    public var duration:int;
    public var inventory:Boolean;
    public var activeAfterDeath:Boolean;
    public var effectLevel:int;
    public var infinite:Boolean;

    public function EffectActivatedEvent(param1:Long, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false, param6:int = 0, param7:Boolean = false) {
      super();
      this.userId = param1;
      this.effectId = param2;
      this.duration = param3;
      this.inventory = param4;
      this.activeAfterDeath = param5;
      this.effectLevel = param6;
      this.infinite = param7;
    }
  }
}
