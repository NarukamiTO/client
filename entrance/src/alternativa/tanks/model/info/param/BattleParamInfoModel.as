package alternativa.tanks.model.info.param {
  import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoCC;
  import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoModelBase;
  import projects.tanks.client.battleselect.model.battle.param.IBattleParamInfoModelBase;

  [ModelInfo]
  public class BattleParamInfoModel extends BattleParamInfoModelBase implements IBattleParamInfoModelBase, BattleParams {
    public function BattleParamInfoModel() {
      super();
    }

    public function getConstructor() : BattleParamInfoCC {
      return getInitParam();
    }
  }
}
