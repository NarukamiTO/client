package alternativa.tanks.models.battle.ctf {
  public class FlagActionMessages {
    public var positive:FlagMessage;
    public var negative:FlagMessage;

    public function FlagActionMessages(param1:FlagMessage, param2:FlagMessage) {
      super();
      this.positive = param1;
      this.negative = param2;
    }
  }
}
