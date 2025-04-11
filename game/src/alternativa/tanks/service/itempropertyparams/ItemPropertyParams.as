package alternativa.tanks.service.itempropertyparams {
  import alternativa.tanks.gui.ItemPropertyIcon;
  import alternativa.tanks.service.itempropertyparams.aggregationmodes.UpgradeAggregationMode;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import projects.tanks.client.garage.models.item.properties.ItemProperty;

  public class ItemPropertyParams {
    private var _sortIndex:int;
    private var _bitmapData:BitmapData;
    private var _name:String;
    private var properties:Vector.<ItemProperty>;
    private var aggregationMode:UpgradeAggregationMode;
    private var _icon:ItemPropertyIcon;
    private var multiplier:Number;

    public function ItemPropertyParams(param1:int, param2:BitmapData, param3:String, param4:Vector.<ItemProperty>, param5:UpgradeAggregationMode, param6:Number, param7:BitmapData) {
      super();
      this._sortIndex = param1;
      this._bitmapData = param2;
      this._name = param3;
      this.properties = param4;
      this.aggregationMode = param5;
      this.multiplier = param6;
      this._icon = new ItemPropertyIcon(param2,param7);
    }

    public function get sortIndex() : int {
      return this._sortIndex;
    }

    public function get bitmapData() : BitmapData {
      return this._bitmapData;
    }

    public function get name() : String {
      return this._name;
    }

    public function get icon() : ItemPropertyIcon {
      return this._icon;
    }

    public function createBitmap() : Bitmap {
      return new Bitmap(this.bitmapData);
    }

    public function getProperties() : Vector.<ItemProperty> {
      return this.properties;
    }

    public function getAggregationMode() : UpgradeAggregationMode {
      return this.aggregationMode;
    }

    public function getMultiplier() : Number {
      return this.multiplier;
    }
  }
}
