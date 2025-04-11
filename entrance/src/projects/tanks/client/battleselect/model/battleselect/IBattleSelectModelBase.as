package projects.tanks.client.battleselect.model.battleselect {
  import platform.client.fp10.core.type.IGameObject;

  public interface IBattleSelectModelBase {
    function battleItemsPacketJoinSuccess() : void;
    function select(param1:IGameObject) : void;
  }
}
