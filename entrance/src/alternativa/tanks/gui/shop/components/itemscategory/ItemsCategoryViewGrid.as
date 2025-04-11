package alternativa.tanks.gui.shop.components.itemscategory {
  import alternativa.tanks.gui.shop.components.item.GridItemBase;
  import base.DiscreteSprite;

  public class ItemsCategoryViewGrid extends DiscreteSprite {
    public var columnCount:int = 3;
    public var horizontalSpacing:int = 3;
    public var verticalSpacing:int = 3;
    public var items:Vector.<GridItemBase>;

    public function ItemsCategoryViewGrid() {
      super();
      this.items = new Vector.<GridItemBase>();
    }

    public function addItem(param1:GridItemBase) : void {
      this.items.push(param1);
      addChild(param1);
    }

    public function render() : void {
      var local5:GridItemBase = null;
      var local1:int = 0;
      var local2:int = 0;
      var local3:int = 0;
      var local4:int = 0;
      for each(local5 in this.items) {
        if(local5.forceNewLine || local1 + local5.widthInCells > this.columnCount) {
          local1 = 0;
          local2 = 0;
          local3 += this.verticalSpacing + local4;
          local4 = 0;
        }
        local1 += local5.widthInCells;
        local5.x = local2;
        local5.y = local3;
        local2 += local5.width + this.horizontalSpacing;
        if(local5.height > local4) {
          local4 = local5.height;
        }
      }
    }

    public function destroy() : void {
      var local1:GridItemBase = null;
      for each(local1 in this.items) {
        local1.destroy();
      }
      this.items = null;
    }

    public function set spacing(param1:int) : void {
      this.horizontalSpacing = param1;
      this.verticalSpacing = param1;
    }
  }
}
