package projects.tanks.client.panel.model.garage {
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;

  public class GarageItemInfo {
    private var _category:ItemCategoryEnum;
    private var _garageItemId:Long;
    private var _item:IGameObject;
    private var _itemViewCategory:ItemViewCategoryEnum;
    private var _modificationIndex:int;
    private var _mounted:Boolean;
    private var _name:String;
    private var _position:int;
    private var _premiumItem:Boolean;
    private var _preview:ImageResource;
    private var _remaingTimeInMS:int;

    public function GarageItemInfo(param1:ItemCategoryEnum = null, param2:Long = null, param3:IGameObject = null, param4:ItemViewCategoryEnum = null, param5:int = 0, param6:Boolean = false, param7:String = null, param8:int = 0, param9:Boolean = false, param10:ImageResource = null, param11:int = 0) {
      super();
      this._category = param1;
      this._garageItemId = param2;
      this._item = param3;
      this._itemViewCategory = param4;
      this._modificationIndex = param5;
      this._mounted = param6;
      this._name = param7;
      this._position = param8;
      this._premiumItem = param9;
      this._preview = param10;
      this._remaingTimeInMS = param11;
    }

    public function get category() : ItemCategoryEnum {
      return this._category;
    }

    public function set category(param1:ItemCategoryEnum) : void {
      this._category = param1;
    }

    public function get garageItemId() : Long {
      return this._garageItemId;
    }

    public function set garageItemId(param1:Long) : void {
      this._garageItemId = param1;
    }

    public function get item() : IGameObject {
      return this._item;
    }

    public function set item(param1:IGameObject) : void {
      this._item = param1;
    }

    public function get itemViewCategory() : ItemViewCategoryEnum {
      return this._itemViewCategory;
    }

    public function set itemViewCategory(param1:ItemViewCategoryEnum) : void {
      this._itemViewCategory = param1;
    }

    public function get modificationIndex() : int {
      return this._modificationIndex;
    }

    public function set modificationIndex(param1:int) : void {
      this._modificationIndex = param1;
    }

    public function get mounted() : Boolean {
      return this._mounted;
    }

    public function set mounted(param1:Boolean) : void {
      this._mounted = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function get position() : int {
      return this._position;
    }

    public function set position(param1:int) : void {
      this._position = param1;
    }

    public function get premiumItem() : Boolean {
      return this._premiumItem;
    }

    public function set premiumItem(param1:Boolean) : void {
      this._premiumItem = param1;
    }

    public function get preview() : ImageResource {
      return this._preview;
    }

    public function set preview(param1:ImageResource) : void {
      this._preview = param1;
    }

    public function get remaingTimeInMS() : int {
      return this._remaingTimeInMS;
    }

    public function set remaingTimeInMS(param1:int) : void {
      this._remaingTimeInMS = param1;
    }

    public function toString() : String {
      var local1:String = "GarageItemInfo [";
      local1 += "category = " + this.category + " ";
      local1 += "garageItemId = " + this.garageItemId + " ";
      local1 += "item = " + this.item + " ";
      local1 += "itemViewCategory = " + this.itemViewCategory + " ";
      local1 += "modificationIndex = " + this.modificationIndex + " ";
      local1 += "mounted = " + this.mounted + " ";
      local1 += "name = " + this.name + " ";
      local1 += "position = " + this.position + " ";
      local1 += "premiumItem = " + this.premiumItem + " ";
      local1 += "preview = " + this.preview + " ";
      local1 += "remaingTimeInMS = " + this.remaingTimeInMS + " ";
      return local1 + "]";
    }
  }
}
