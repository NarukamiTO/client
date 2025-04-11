package alternativa.tanks.model.item.skins {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.skins.IMountSkinItemModelBase;
  import projects.tanks.client.garage.skins.MountSkinItemModelBase;

  [ModelInfo]
  public class MountSkinItemModel extends MountSkinItemModelBase implements IMountSkinItemModelBase, MountSkin {
    public function MountSkinItemModel() {
      super();
    }

    public function getMountedSkin() : IGameObject {
      return getInitParam().item;
    }

    public function mount(param1:IGameObject) : void {
      getInitParam().item = param1;
      server.mountSkin(param1);
    }
  }
}
