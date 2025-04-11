package projects.tanks.client.garage.models.item.kit {
  import platform.client.fp10.core.type.IGameObject;

  public class KitItem {
    private var _count:int;
    private var _item:IGameObject;
    private var _mount:Boolean;

    public function KitItem(param1:int = 0, param2:IGameObject = null, param3:Boolean = false) {
      super();
      this._count = param1;
      this._item = param2;
      this._mount = param3;
    }

    public function get count() : int {
      return this._count;
    }

    public function set count(param1:int) : void {
      this._count = param1;
    }

    public function get item() : IGameObject {
      return this._item;
    }

    public function set item(param1:IGameObject) : void {
      this._item = param1;
    }

    public function get mount() : Boolean {
      return this._mount;
    }

    public function set mount(param1:Boolean) : void {
      this._mount = param1;
    }

    public function toString() : String {
      var local1:String = "KitItem [";
      local1 += "count = " + this.count + " ";
      local1 += "item = " + this.item + " ";
      local1 += "mount = " + this.mount + " ";
      return local1 + "]";
    }
  }
}
