package alternativa.tanks.view.battleinfo.dm {
  import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
  import projects.tanks.client.battleselect.model.battle.entrance.user.BattleInfoUser;

  public class BattleInfoDmParams extends BattleInfoBaseParams {
    public var users:Vector.<BattleInfoUser> = new Vector.<BattleInfoUser>();

    public function BattleInfoDmParams() {
      super();
    }
  }
}
