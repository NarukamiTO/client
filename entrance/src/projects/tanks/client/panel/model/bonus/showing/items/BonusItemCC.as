package projects.tanks.client.panel.model.bonus.showing.items {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class BonusItemCC {
    private var _count:int;
    private var _resource:ImageResource;

    public function BonusItemCC(param1:int = 0, param2:ImageResource = null) {
      super();
      this._count = param1;
      this._resource = param2;
    }

    public function get count() : int {
      return this._count;
    }

    public function set count(param1:int) : void {
      this._count = param1;
    }

    public function get resource() : ImageResource {
      return this._resource;
    }

    public function set resource(param1:ImageResource) : void {
      this._resource = param1;
    }

    public function toString() : String {
      var local1:String = "BonusItemCC [";
      local1 += "count = " + this.count + " ";
      local1 += "resource = " + this.resource + " ";
      return local1 + "]";
    }
  }
}
