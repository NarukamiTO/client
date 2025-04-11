package alternativa.tanks.model.garage.upgradingitems {
  import platform.client.fp10.core.type.IGameObject;

  public interface UpgradingItem {
    function select(param1:IGameObject) : void;
    function itemUpgraded(param1:IGameObject) : void;
  }
}
