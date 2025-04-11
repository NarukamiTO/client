package alternativa.tanks.model.item.skins {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class MountShotSkinAdapt implements MountShotSkin {
    private var object:IGameObject;
    private var impl:MountShotSkin;

    public function MountShotSkinAdapt(param1:IGameObject, param2:MountShotSkin) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getMountedSkin() : IGameObject {
      var result:IGameObject = null;
      try {
        Model.object = this.object;
        result = this.impl.getMountedSkin();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function mount(param1:IGameObject) : void {
      var skin:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.mount(skin);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
