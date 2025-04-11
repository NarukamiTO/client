package alternativa.tanks.services.initialeffects {
  import alternativa.types.Long;

  public class ClientBattleEffect {
    public var receiveTime:int;
    public var userId:Long;
    public var effectId:int;
    public var duration:int;
    public var effectLevel:int;

    public function ClientBattleEffect(param1:int, param2:Long, param3:int, param4:int, param5:int) {
      super();
      this.receiveTime = param1;
      this.userId = param2;
      this.effectId = param3;
      this.duration = param4;
      this.effectLevel = param5;
    }
  }
}
