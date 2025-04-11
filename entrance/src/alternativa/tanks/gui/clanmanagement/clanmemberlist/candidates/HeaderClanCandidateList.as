package alternativa.tanks.gui.clanmanagement.clanmemberlist.candidates {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.ClanMembersHeaderItem;
  import base.DiscreteSprite;
  import flash.text.TextFormatAlign;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class HeaderClanCandidateList extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;
    public static var HEADERS:Vector.<HeaderData>;
    public static var tabs:Vector.<Number> = Vector.<Number>([1]);

    private static const GAP:int = 2;

    protected var _width:int = 800;

    private var headerCells:Vector.<ClanMembersHeaderItem>;

    public function HeaderClanCandidateList() {
      var local1:ClanMembersHeaderItem = null;
      this.headerCells = new Vector.<ClanMembersHeaderItem>();
      super();
      HEADERS = Vector.<HeaderData>([new HeaderData(localeService.getText(TanksLocale.TEXT_CLAN_MEMBER_NAME),TextFormatAlign.LEFT,2)]);
      var local2:int = int(HEADERS.length);
      var local3:int = 0;
      while(local3 < local2) {
        local1 = new ClanMembersHeaderItem(HEADERS[local3].align);
        local1.label = HEADERS[local3].text;
        local1.setLabelPosX(HEADERS[local3].posX);
        local1.height = 18;
        addChild(local1);
        this.headerCells.push(local1);
        local3++;
      }
      this.align();
    }

    protected function align() : void {
      var local1:ClanMembersHeaderItem = null;
      var local2:int = int(HEADERS.length);
      var local3:Number = GAP - 1;
      var local4:int = 0;
      while(local4 < local2) {
        local1 = this.headerCells[local4];
        local1.width = tabs[local4] * (this._width + 2 - GAP * (tabs.length + 1));
        local1.x = local3;
        local1.y = 1;
        if(local4 != local2 - 1) {
          local3 += local1.width + GAP;
        }
        local4++;
      }
      this.headerCells[this.headerCells.length - 1].width = this._width + 3 - local3 - 2 * GAP;
    }

    override public function set width(param1:Number) : void {
      this._width = Math.floor(param1);
      this.align();
    }
  }
}

class HeaderData {
  public var text:String;
  public var align:String;
  public var posX:int;

  public function HeaderData(param1:String, param2:String, param3:int) {
    super();
    this.text = param1;
    this.align = param2;
    this.posX = param3;
  }
}
