package alternativa.tanks.gui.shop.components.itemscategory {
  import alternativa.tanks.gui.shop.components.item.GridItemBase;
  import alternativa.types.Long;
  import base.DiscreteSprite;

  public class ItemsCategoryView extends DiscreteSprite {
    private static const GAP:int = 10;

    public var headerText:String;
    public var descriptionText:String;
    public var categoryId:Long;
    public var header:ItemsCategoryViewHeader;
    public var items:ItemsCategoryViewGrid;

    public function ItemsCategoryView(param1:String, param2:String, param3:Long) {
      super();
      this.headerText = param1;
      this.descriptionText = param2;
      this.categoryId = param3;
      this.init();
    }

    private function init() : void {
      this.header = new ItemsCategoryViewHeader(this.headerText,this.descriptionText);
      addChild(this.header);
      this.items = new ItemsCategoryViewGrid();
      addChild(this.items);
    }

    public function addItem(param1:GridItemBase) : void {
      this.items.addItem(param1);
    }

    public function render(param1:int) : void {
      this.header.render(param1);
      this.items.render();
      this.items.y = this.header.y + this.header.height + GAP;
    }

    public function destroy() : void {
      this.header = null;
      this.items.destroy();
      this.items = null;
    }
  }
}
