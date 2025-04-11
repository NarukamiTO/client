package projects.tanks.client.garage.models.item.item {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class ItemModelCC {
    private var _maxRank:int;
    private var _minRank:int;
    private var _position:int;
    private var _preview:ImageResource;

    public function ItemModelCC(param1:int = 0, param2:int = 0, param3:int = 0, param4:ImageResource = null) {
      super();
      this._maxRank = param1;
      this._minRank = param2;
      this._position = param3;
      this._preview = param4;
    }

    public function get maxRank() : int {
      return this._maxRank;
    }

    public function set maxRank(param1:int) : void {
      this._maxRank = param1;
    }

    public function get minRank() : int {
      return this._minRank;
    }

    public function set minRank(param1:int) : void {
      this._minRank = param1;
    }

    public function get position() : int {
      return this._position;
    }

    public function set position(param1:int) : void {
      this._position = param1;
    }

    public function get preview() : ImageResource {
      return this._preview;
    }

    public function set preview(param1:ImageResource) : void {
      this._preview = param1;
    }

    public function toString() : String {
      var local1:String = "ItemModelCC [";
      local1 += "maxRank = " + this.maxRank + " ";
      local1 += "minRank = " + this.minRank + " ";
      local1 += "position = " + this.position + " ";
      local1 += "preview = " + this.preview + " ";
      return local1 + "]";
    }
  }
}
