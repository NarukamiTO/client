package alternativa.tanks.controllers.battlelist {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.BattleMode;

  public interface IBattleListViewControllerCallback {
    function onShowCreateBattleFormButtonClick() : void;
    function onBattleListItemClick(param1:IGameObject) : void;
    function onBattleListItemChange(param1:IGameObject) : void;
    function onBattleModeChange(param1:BattleMode, param2:Boolean) : void;
    function onBackToMatchmakingClick() : void;
  }
}
