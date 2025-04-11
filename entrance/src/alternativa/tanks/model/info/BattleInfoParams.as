package alternativa.tanks.model.info {
  import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;

  [ModelInterface]
  public interface BattleInfoParams {
    function getParams() : BattleInfoBaseParams;
  }
}
