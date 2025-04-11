package alternativa.tanks.model.garage.upgrade {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface FlushUpgrades {
    function flushToServer(param1:DelayUpgrades, param2:IGameObject) : void;
  }
}
