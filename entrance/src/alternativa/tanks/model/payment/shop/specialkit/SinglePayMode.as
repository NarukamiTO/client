package alternativa.tanks.model.payment.shop.specialkit {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface SinglePayMode {
    function getPayMode() : IGameObject;
  }
}
