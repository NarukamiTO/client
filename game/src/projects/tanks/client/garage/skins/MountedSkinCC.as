package projects.tanks.client.garage.skins {
  import platform.client.fp10.core.type.IGameObject;

  public class MountedSkinCC {
    private var _item:IGameObject;

    public function MountedSkinCC(param1:IGameObject = null) {
      super();
      this._item = param1;
    }

    public function get item() : IGameObject {
      return this._item;
    }

    public function set item(param1:IGameObject) : void {
      this._item = param1;
    }

    public function toString() : String {
      var local1:String = "MountedSkinCC [";
      local1 += "item = " + this.item + " ";
      return local1 + "]";
    }
  }
}
