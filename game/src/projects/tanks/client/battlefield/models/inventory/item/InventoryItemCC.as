package projects.tanks.client.battlefield.models.inventory.item {
  public class InventoryItemCC {
    private var _alternativeSlotItem:Boolean;
    private var _count:int;
    private var _itemIndex:int;

    public function InventoryItemCC(param1:Boolean = false, param2:int = 0, param3:int = 0) {
      super();
      this._alternativeSlotItem = param1;
      this._count = param2;
      this._itemIndex = param3;
    }

    public function get alternativeSlotItem() : Boolean {
      return this._alternativeSlotItem;
    }

    public function set alternativeSlotItem(param1:Boolean) : void {
      this._alternativeSlotItem = param1;
    }

    public function get count() : int {
      return this._count;
    }

    public function set count(param1:int) : void {
      this._count = param1;
    }

    public function get itemIndex() : int {
      return this._itemIndex;
    }

    public function set itemIndex(param1:int) : void {
      this._itemIndex = param1;
    }

    public function toString() : String {
      var local1:String = "InventoryItemCC [";
      local1 += "alternativeSlotItem = " + this.alternativeSlotItem + " ";
      local1 += "count = " + this.count + " ";
      local1 += "itemIndex = " + this.itemIndex + " ";
      return local1 + "]";
    }
  }
}
