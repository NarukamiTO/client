package alternativa.tanks.model.item.skins {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface MountShotSkin {
    function getMountedSkin() : IGameObject;
    function mount(param1:IGameObject) : void;
  }
}
