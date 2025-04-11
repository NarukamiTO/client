package alternativa.tanks.model.info.param {
  import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoCC;

  [ModelInterface]
  public interface BattleParams {
    function getConstructor() : BattleParamInfoCC;
  }
}
