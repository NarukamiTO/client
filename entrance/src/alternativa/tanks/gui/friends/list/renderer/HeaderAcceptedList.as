package alternativa.tanks.gui.friends.list.renderer {
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.display.Sprite;
  import flash.text.TextFormatAlign;
  import platform.clients.fp10.libraries.alternativapartners.service.IPartnerService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class HeaderAcceptedList extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var partnersService:IPartnerService;
    public static var HEADERS:Vector.<HeaderData>;

    protected var tabs:Vector.<Number>;
    protected var _width:int = 800;

    public function HeaderAcceptedList() {
      var local1:FriendsHeaderItem = null;
      this.tabs = new Vector.<Number>();
      super();
      HEADERS = Vector.<HeaderData>([new HeaderData(localeService.getText(TanksLocale.TEXT_FRIENDS_NAME),TextFormatAlign.LEFT,2),new HeaderData(localeService.getText(TanksLocale.TEXT_FRIENDS_BATTLE),TextFormatAlign.LEFT,2)]);
      var local2:int = int(HEADERS.length);
      var local3:int = 0;
      while(local3 < local2) {
        local1 = new FriendsHeaderItem(HEADERS[local3].align);
        local1.label = HEADERS[local3].text;
        local1.setLabelPosX(HEADERS[local3].posX);
        local1.height = 18;
        addChild(local1);
        local3++;
      }
      this.draw();
    }

    protected function draw() : void {
      var local1:FriendsHeaderItem = null;
      this.tabs = Vector.<Number>([0,this._width / 2,this._width - 1]);
      var local2:int = int(HEADERS.length);
      var local3:int = 0;
      while(local3 < local2) {
        local1 = getChildAt(local3) as FriendsHeaderItem;
        local1.width = this.tabs[local3 + 1] - this.tabs[local3] - 2;
        local1.x = this.tabs[local3];
        local3++;
      }
    }

    override public function set width(param1:Number) : void {
      this._width = Math.floor(param1);
      this.draw();
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
