package alternativa.tanks.gui.tables {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.model.item.kit.GarageKit;
  import alternativa.tanks.service.item.ItemService;
  import assets.Diamond;
  import controls.Money;
  import controls.base.LabelBase;
  import flash.display.BitmapData;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.geom.Matrix;
  import flash.text.TextFormatAlign;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.client.garage.models.item.kit.KitItem;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class KitInfoTable extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var itemService:ItemService;

    private static const upgradeSelectionLeftClass:Class = KitInfoTable_upgradeSelectionLeftClass;
    private static const upgradeSelectionCenterClass:Class = KitInfoTable_upgradeSelectionCenterClass;

    private const LEFT_TOP_MARGIN:int = 12;
    private const SUMMARY_TOP_MARGIN:int = 13;
    private const CRYSTAL_TOP_MARGIN:int = 4;
    private const ITEM_HEIGHT:int = 17;

    private var selection:Shape = new Shape();
    private var _width:int;
    private var topPartHeight:int;
    private var bottomPartHeight:int;
    private var kitObject:IGameObject;
    private var kit:GarageKit;

    public function KitInfoTable(param1:int) {
      super();
      this._width = param1;
      this.topPartHeight = 0;
    }

    public function show(param1:IGameObject) : void {
      this.kitObject = param1;
      this.kit = GarageKit(param1.adapt(GarageKit));
      var local2:int = int(this.kit.getItems().length);
      this.topPartHeight = this.LEFT_TOP_MARGIN + (local2 + 1) * this.ITEM_HEIGHT;
      this.clearTable();
      this.addHeader();
      this.addRows();
      this.addSum();
      this.addSummary();
    }

    public function clearTable() : void {
      while(this.numChildren > 0) {
        this.removeChildAt(0);
      }
    }

    private function addHeader() : void {
      var local1:LabelBase = new LabelBase();
      local1.color = ColorConstants.GREEN_LABEL;
      local1.align = TextFormatAlign.LEFT;
      local1.text = localeService.getText(TanksLocale.TEXT_ITEMS_IN_KIT);
      local1.x = this.LEFT_TOP_MARGIN;
      local1.y = this.LEFT_TOP_MARGIN;
      addChild(local1);
      var local2:LabelBase = new LabelBase();
      local2.color = ColorConstants.GREEN_LABEL;
      local2.align = TextFormatAlign.RIGHT;
      local2.text = localeService.getText(TanksLocale.TEXT_GARAGE_PRICE);
      local2.x = this._width - local2.width - local1.x;
      local2.y = local1.y;
      addChild(local2);
    }

    private function addRows() : void {
      var local2:KitItem = null;
      var local3:KitItemInfoRow = null;
      this.kit.getItems().sort(this.compareItems);
      var local1:int = this.LEFT_TOP_MARGIN + this.ITEM_HEIGHT;
      for each(local2 in this.kit.getItems()) {
        local3 = new KitItemInfoRow(local1,this._width,local2,this.LEFT_TOP_MARGIN,this.CRYSTAL_TOP_MARGIN);
        addChild(local3);
        local1 += this.ITEM_HEIGHT;
      }
    }

    private function addSum() : void {
      var local1:LabelBase = new LabelBase();
      local1.color = ColorConstants.GREEN_LABEL;
      local1.align = TextFormatAlign.LEFT;
      local1.text = localeService.getText(TanksLocale.TEXT_TOTAL_PRICE_KIT);
      local1.x = this.LEFT_TOP_MARGIN;
      local1.y = this.topPartHeight + this.ITEM_HEIGHT - 6;
      addChild(local1);
      var local2:Diamond = new Diamond();
      local2.x = this._width - local1.x - local2.width;
      addChild(local2);
      local2.y = local1.y + this.CRYSTAL_TOP_MARGIN;
      var local3:LabelBase = new LabelBase();
      local3.color = ColorConstants.GREEN_LABEL;
      local3.align = TextFormatAlign.RIGHT;
      local3.text = Money.numToString(this.kit.getPriceWithoutDiscount(),false);
      local3.x = local2.x - local3.width - 1;
      local3.y = local1.y;
      addChild(local3);
    }

    private function addSummary() : void {
      addChild(this.selection);
      this.selection.y = this.SUMMARY_TOP_MARGIN + this.ITEM_HEIGHT + this.topPartHeight;
      this.resizeSelection();
      var local1:int = int(itemService.getDiscount(this.kitObject));
      var local2:int = int(itemService.getPrice(this.kitObject));
      var local3:String = localeService.getText(TanksLocale.TEXT_DISCOUNTED_AT_KIT);
      local3 = local3.replace("{0}",local1 + "%");
      this.addSummaryRow(local3,local2);
      this.bottomPartHeight = 2 * this.ITEM_HEIGHT;
    }

    private function addSummaryRow(param1:String, param2:int) : void {
      var local3:LabelBase = new LabelBase();
      local3.align = TextFormatAlign.LEFT;
      local3.text = param1;
      local3.x = this.LEFT_TOP_MARGIN;
      local3.y = this.SUMMARY_TOP_MARGIN + this.ITEM_HEIGHT + this.topPartHeight;
      addChild(local3);
      var local4:Diamond = new Diamond();
      local4.x = this._width - local3.x - local4.width;
      addChild(local4);
      local4.y = local3.y + this.CRYSTAL_TOP_MARGIN;
      var local5:LabelBase = new LabelBase();
      local5.align = TextFormatAlign.RIGHT;
      local5.text = Money.numToString(param2,false);
      local5.x = local4.x - local5.width - 1;
      local5.y = local3.y;
      addChild(local5);
    }

    private function resizeSelection() : void {
      var local1:int = this._width - 18;
      var local2:BitmapData = new upgradeSelectionLeftClass().bitmapData;
      this.selection.x = 9;
      this.selection.graphics.clear();
      this.selection.graphics.beginBitmapFill(local2);
      this.selection.graphics.drawRect(0,0,local2.width,local2.height);
      var local3:BitmapData = new upgradeSelectionCenterClass().bitmapData;
      this.selection.graphics.beginBitmapFill(local3);
      this.selection.graphics.drawRect(local2.width,0,local1 - local2.width * 2,local3.height);
      var local4:Matrix = new Matrix(-1,0,0,1,local1,0);
      this.selection.graphics.beginBitmapFill(local2,local4);
      this.selection.graphics.drawRect(local1 - local2.width,0,local2.width,local2.height);
      this.selection.graphics.endFill();
    }

    private function compareItems(param1:KitItem, param2:KitItem) : Number {
      var local3:int = this.getTypeIndex(param1);
      var local4:int = this.getTypeIndex(param2);
      if(local3 > local4) {
        return 1;
      }
      if(local3 < local4) {
        return -1;
      }
      var local5:int = itemService.getPrice(param1.item) * param1.count;
      var local6:int = itemService.getPrice(param2.item) * param2.count;
      if(local5 < local6) {
        return 1;
      }
      if(local5 > local6) {
        return -1;
      }
      return 0;
    }

    private function getTypeIndex(param1:KitItem) : int {
      switch(itemService.getCategory(param1.item)) {
        case ItemCategoryEnum.WEAPON:
          return 0;
        case ItemCategoryEnum.ARMOR:
          return 1;
        case ItemCategoryEnum.INVENTORY:
          return 3;
        case ItemCategoryEnum.PLUGIN:
          return 4;
        case ItemCategoryEnum.PAINT:
          return 5;
        default:
          return 6;
      }
    }

    public function getTopPartTableHeight() : int {
      return this.topPartHeight;
    }

    public function getFullTableHeight() : int {
      return this.SUMMARY_TOP_MARGIN + this.topPartHeight + this.bottomPartHeight;
    }

    public function getBottomPartTableHeight() : int {
      return this.bottomPartHeight;
    }
  }
}
