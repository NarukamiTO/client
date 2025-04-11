package alternativa.tanks.model.item.skins {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface AvailableSkins {
    function getSkins() : Vector.<IGameObject>;
  }
}
