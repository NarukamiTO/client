package alternativa.tanks.model.garage.present {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface PresentPurchase {
    function preparePresent(param1:IGameObject) : void;
    function confirmPresentPurchase(param1:IGameObject) : void;
  }
}
