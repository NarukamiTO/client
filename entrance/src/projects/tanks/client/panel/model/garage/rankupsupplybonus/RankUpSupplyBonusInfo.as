package projects.tanks.client.panel.model.garage.rankupsupplybonus {
  import platform.client.fp10.core.resource.types.ImageResource;

  public class RankUpSupplyBonusInfo {
    private var _count:int;
    private var _preview:ImageResource;
    private var _text:String;

    public function RankUpSupplyBonusInfo(param1:int = 0, param2:ImageResource = null, param3:String = null) {
      super();
      this._count = param1;
      this._preview = param2;
      this._text = param3;
    }

    public function get count() : int {
      return this._count;
    }

    public function set count(param1:int) : void {
      this._count = param1;
    }

    public function get preview() : ImageResource {
      return this._preview;
    }

    public function set preview(param1:ImageResource) : void {
      this._preview = param1;
    }

    public function get text() : String {
      return this._text;
    }

    public function set text(param1:String) : void {
      this._text = param1;
    }

    public function toString() : String {
      var local1:String = "RankUpSupplyBonusInfo [";
      local1 += "count = " + this.count + " ";
      local1 += "preview = " + this.preview + " ";
      local1 += "text = " + this.text + " ";
      return local1 + "]";
    }
  }
}
