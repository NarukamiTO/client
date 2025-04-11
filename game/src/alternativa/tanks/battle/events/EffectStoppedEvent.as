package alternativa.tanks.battle.events {
  import alternativa.types.Long;

  public class EffectStoppedEvent {
    public var userId:Long;
    public var effectId:int;
    public var activeAfterDeath:Boolean;

    public function EffectStoppedEvent(param1:Long, param2:int, param3:Boolean = false) {
      super();
      this.userId = param1;
      this.effectId = param2;
      this.activeAfterDeath = param3;
    }
  }
}
