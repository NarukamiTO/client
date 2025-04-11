package alternativa.tanks.model.item.skins {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.skins.IMountShotSkinModelBase;
  import projects.tanks.client.garage.skins.MountShotSkinModelBase;

  [ModelInfo]
  public class MountShotSkinModel extends MountShotSkinModelBase implements IMountShotSkinModelBase, MountShotSkin {
    public function MountShotSkinModel() {
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
