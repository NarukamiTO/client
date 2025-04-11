package alternativa.tanks.gui.clanmanagement.clanmemberlist.members {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.ClanMembersHeaderItem;
  import base.DiscreteSprite;
  import flash.text.TextFormatAlign;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class HeaderClanMemberList extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;
    public static var HEADERS:Vector.<HeaderData>;

    private static var header:HeaderClanMemberList;
    private static var _weights:Vector.<Number> = Vector.<Number>([0.16,0.2,0.08,0.08,0.08,0.08,0.16,0.16]);
    private static var hiddenColumns:Vector.<Number> = new Vector.<Number>();
    private static var hideOrder:Vector.<Number> = Vector.<Number>([5,4,3,2,6,7,1]);

    protected static var _width:Number = 840;

    private static var gap:Number = 2;

    public function HeaderClanMemberList() {
      var local1:ClanMembersHeaderItem = null;
      super();
      header = this;
      HEADERS = Vector.<HeaderData>([new HeaderData(localeService.getText(TanksLocale.TEXT_CLAN_MEMBER_NAME),TextFormatAlign.LEFT,2,180),new HeaderData(localeService.getText(TanksLocale.TEXT_CLAN_MEMBER_POSITION),TextFormatAlign.LEFT,2,168),new HeaderData(localeService.getText(TanksLocale.TEXT_CLAN_MEMBER_COLUMN_EXPERIENCE),TextFormatAlign.LEFT,2,67),new HeaderData(localeService.getText(TanksLocale.TEXT_CLAN_MEMBER_COLUMN_DESTROYED),TextFormatAlign.LEFT,2,80),new HeaderData(localeService.getText(TanksLocale.TEXT_CLAN_MEMBER_COLUMN_LOST),TextFormatAlign.LEFT,2,67),new HeaderData(localeService.getText(TanksLocale.TEXT_CLAN_MEMBER_COLUMN_KILL_DEATH_RATIO),TextFormatAlign.LEFT,2,53),new HeaderData(localeService.getText(TanksLocale.TEXT_CLAN_MEMBER_DAYS),TextFormatAlign.LEFT,2,134),new HeaderData(localeService.getText(TanksLocale.TEXT_CLAN_MEMBER_LAST_VISIT),TextFormatAlign.LEFT,2,134)]);
      var local2:int = int(HEADERS.length);
      var local3:int = 0;
      while(local3 < local2) {
        local1 = new ClanMembersHeaderItem(HEADERS[local3].align);
        local1.label = HEADERS[local3].text;
        local1.setLabelPosX(HEADERS[local3].posX);
        local1.height = 18;
        addChild(local1);
        local3++;
      }
    }

    public static function getColumnX(param1:int) : Number {
      return header.getChildAt(param1).x;
    }

    public static function getColumnWidth(param1:int) : Number {
      if(header.getChildAt(param1).visible) {
        return Math.max(header.getChildAt(param1).width,HEADERS[param1].minWidth);
      }
      return 0;
    }

    public static function getPositionColumnWidth() : Number {
      return getColumnWidth(1);
    }

    protected function resize() : void {
      var local6:ClanMembersHeaderItem = null;
      var local8:Number = NaN;
      hiddenColumns = new Vector.<Number>();
      var local1:int = 0;
      if(_width <= 985) {
        local1 = 5 - (_width - 585) / 80;
      }
      hiddenColumns = hideOrder.slice(0,local1);
      var local2:Number = 0;
      var local3:int = 0;
      while(local3 < HEADERS.length) {
        if(hiddenColumns.indexOf(local3) < 0) {
          local2 += _weights[local3];
        }
        local3++;
      }
      var local4:Number = 0;
      var local5:Vector.<Number> = new Vector.<Number>();
      local3 = 0;
      while(local3 < HEADERS.length) {
        local5.push(_weights[local3] / local2);
        local4 += local5[local3];
        local3++;
      }
      var local7:int = 1;
      local3 = 0;
      while(local3 < HEADERS.length) {
        local6 = getChildAt(local3) as ClanMembersHeaderItem;
        if(hiddenColumns.indexOf(local3) < 0) {
          local6.y = 1;
          local6.x = local7;
          local8 = local5[local3] / local4 * (_width + 2 - gap * (_weights.length - hiddenColumns.length + 1));
          local6.width = Math.max(local8,HEADERS[local3].minWidth);
          if(local3 < HEADERS.length - 1) {
            local7 += local6.width + gap;
          }
          local6.visible = true;
        } else {
          local6.visible = false;
        }
        local3++;
      }
      getChildAt(numChildren - 1).width = _width + 3 - local7 - 2 * gap;
    }

    override public function set width(param1:Number) : void {
      _width = param1;
      this.resize();
    }
  }
}

class HeaderData {
  public var text:String;
  public var align:String;
  public var posX:int;
  public var minWidth:Number;

  public function HeaderData(param1:String, param2:String, param3:int, param4:Number = 0) {
    super();
    this.text = param1;
    this.align = param2;
    this.posX = param3;
    this.minWidth = param4;
  }
}
