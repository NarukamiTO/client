package alternativa.tanks.model.item.resistance {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface MountedResistances {
    function mount(param1:int, param2:IGameObject) : void;
    function unmount(param1:IGameObject) : void;
    function getMounted() : Vector.<IGameObject>;
  }
}
