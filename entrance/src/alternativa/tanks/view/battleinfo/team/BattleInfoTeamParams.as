package alternativa.tanks.view.battleinfo.team {
  import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;

  public class BattleInfoTeamParams extends BattleInfoBaseParams {
    public var usersRed:Vector.<BattleInfoUser> = new Vector.<BattleInfoUser>();
    public var usersBlue:Vector.<BattleInfoUser> = new Vector.<BattleInfoUser>();
    public var scoreRed:int;
    public var scoreBlue:int;

    public function BattleInfoTeamParams() {
      super();
    }
  }
}
