package alternativa.tanks.model.item.skins {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class MountSkinEvents implements MountSkin {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function MountSkinEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getMountedSkin() : IGameObject {
      var result:IGameObject = null;
      var i:int = 0;
      var m:MountSkin = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = MountSkin(this.impl[i]);
          result = m.getMountedSkin();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function mount(param1:IGameObject) : void {
      var i:int = 0;
      var m:MountSkin = null;
      var skin:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = MountSkin(this.impl[i]);
          m.mount(skin);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
