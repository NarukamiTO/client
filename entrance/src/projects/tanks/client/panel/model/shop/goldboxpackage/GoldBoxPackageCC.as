package projects.tanks.client.panel.model.shop.goldboxpackage {
  public class GoldBoxPackageCC {
    private var _count:int;

    public function GoldBoxPackageCC(param1:int = 0) {
      super();
      this._count = param1;
    }

    public function get count() : int {
      return this._count;
    }

    public function set count(param1:int) : void {
      this._count = param1;
    }

    public function toString() : String {
      var local1:String = "GoldBoxPackageCC [";
      local1 += "count = " + this.count + " ";
      return local1 + "]";
    }
  }
}
