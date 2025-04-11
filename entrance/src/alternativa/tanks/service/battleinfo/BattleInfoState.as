package alternativa.tanks.service.battleinfo {
  public class BattleInfoState {
    public static const NONE:BattleInfoState = new BattleInfoState(-1);
    public static const DM_FORM:BattleInfoState = new BattleInfoState(1);
    public static const TEAM_FORM:BattleInfoState = new BattleInfoState(2);

    private var stateId:int;

    public function BattleInfoState(param1:int) {
      super();
      this.stateId = param1;
    }
  }
}
