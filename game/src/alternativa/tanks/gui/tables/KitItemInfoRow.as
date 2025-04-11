package alternativa.tanks.gui.tables {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.item.ItemService;
  import assets.Diamond;
  import controls.Money;
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.text.TextFormatAlign;
  import projects.tanks.client.garage.models.item.kit.KitItem;

  public class KitItemInfoRow extends Sprite {
    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var localeService:ILocaleService;

    public function KitItemInfoRow(param1:int, param2:int, param3:KitItem, param4:int, param5:int) {
      super();
      var local6:int = param2;
      this.y = param1;
      var local7:LabelBase = new LabelBase();
      local7.align = TextFormatAlign.LEFT;
      local7.text = itemService.getName(param3.item) + (param3.count <= 1 ? "" : " ×" + String(param3.count));
      local7.x = param4;
      addChild(local7);
      var local8:Diamond = new Diamond();
      local8.x = local6 - local7.x - local8.width;
      addChild(local8);
      local8.y = param5;
      var local9:int = itemService.getPriceWithoutDiscount(param3.item) * param3.count;
      var local10:LabelBase = new LabelBase();
      local10.align = TextFormatAlign.RIGHT;
      local10.text = Money.numToString(local9,false);
      local10.x = local8.x - local10.width - 1;
      addChild(local10);
    }
  }
}
