package alternativa.tanks.view.mainview.grouplist.header {
  import alternativa.osgi.service.locale.ILocaleService;
  import base.DiscreteSprite;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class GroupHeader extends DiscreteSprite {
    public static var HEADER_INFOS:Vector.<GroupHeaderItem>;

    [Inject]
    public static var localeService:ILocaleService;

    private static const GAP:int = 2;

    private var sumParts:int;
    private var headerWidth:Number;

    public function GroupHeader() {
      var local1:GroupHeaderItem = null;
      super();
      HEADER_INFOS = Vector.<GroupHeaderItem>([new GroupHeaderItem(localeService.getText(TanksLocale.TEXT_BATTLE_STAT_CALLSIGN),1.5),new GroupHeaderItem(localeService.getText(TanksLocale.TEXT_TURRET),1),new GroupHeaderItem(localeService.getText(TanksLocale.TEXT_HULL),1)]);
      for each(local1 in HEADER_INFOS) {
        addChild(local1);
        this.sumParts += local1.getPartOfHeader();
      }
      this.resize();
    }

    private function resize() : void {
      var local4:GroupHeaderItem = null;
      var local5:int = 0;
      var local1:Number = 0;
      var local2:int = 0;
      while(local2 < HEADER_INFOS.length - 1) {
        local4 = HEADER_INFOS[local2];
        local4.x = local1;
        local5 = this.width * local4.getPartOfHeader() / this.sumParts;
        local4.width = local5 - GAP;
        local1 += local5;
        local2++;
      }
      var local3:GroupHeaderItem = HEADER_INFOS[HEADER_INFOS.length - 1];
      local3.x = local1;
      local3.width = this.width - local1 - 1;
    }

    override public function set width(param1:Number) : void {
      this.headerWidth = param1;
      this.resize();
    }

    override public function get width() : Number {
      return this.headerWidth;
    }
  }
}
