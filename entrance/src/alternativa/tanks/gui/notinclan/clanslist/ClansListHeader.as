package alternativa.tanks.gui.notinclan.clanslist {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.ClanMembersHeaderItem;
  import alternativa.tanks.gui.notinclan.ClanListDialog;
  import alternativa.tanks.gui.notinclan.dialogs.ClanDialog;
  import base.DiscreteSprite;
  import flash.text.TextFormatAlign;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ClansListHeader extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;

    private static var HEADERS:Vector.<String>;

    public static var tabs:Vector.<Number> = Vector.<Number>([0.25,0.1,0.25,0.18,0.22]);

    private static var gap:Number = 2;

    public function ClansListHeader() {
      var local1:ClanMembersHeaderItem = null;
      super();
      HEADERS = Vector.<String>([localeService.getText(TanksLocale.TEXT_CLAN_USER_CLAN_NAME),localeService.getText(TanksLocale.TEXT_CLAN_USER_CLAN_TAG),localeService.getText(TanksLocale.TEXT_CLAN_FOUNDER),localeService.getText(TanksLocale.TEXT_CLAN_USER_CLAN_NUMBER_MEMBERS),localeService.getText(TanksLocale.TEXT_CLAN_USER_CREATION_DATE)]);
      var local2:int = int(HEADERS.length);
      var local3:int = 0;
      while(local3 < local2) {
        local1 = new ClanMembersHeaderItem(TextFormatAlign.LEFT);
        local1.label = HEADERS[local3];
        local1.height = 18;
        local1.y = 1;
        addChild(local1);
        local3++;
      }
      this.resize(ClanListDialog.WIDTH - 2 * ClanDialog.MARGIN);
    }

    override public function set width(param1:Number) : void {
      this.resize(param1);
    }

    protected function resize(param1:Number) : void {
      var local2:ClanMembersHeaderItem = null;
      var local3:int = int(HEADERS.length);
      var local4:Number = gap - 1;
      var local5:int = 0;
      while(local5 < local3) {
        local2 = getChildAt(local5) as ClanMembersHeaderItem;
        local2.width = tabs[local5] * (param1 + 2 - gap * (tabs.length + 1));
        local2.x = local4;
        local2.y = 1;
        if(local5 != local3 - 1) {
          local4 += local2.width + gap;
        }
        local5++;
      }
      getChildAt(numChildren - 1).width = param1 + 3 - local4 - 2 * gap;
    }
  }
}
