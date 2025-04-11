package alternativa.tanks.gui.clanmanagement.clanmemberlist {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.clanmanagement.ClanPermissionsManager;
  import alternativa.tanks.models.clan.membersdata.ClanMembersDataService;
  import alternativa.tanks.models.foreignclan.ForeignClanService;
  import alternativa.tanks.models.service.ClanService;
  import alternativa.types.Long;
  import base.DiscreteSprite;
  import controls.base.LabelBase;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;
  import flash.ui.Mouse;
  import flash.ui.MouseCursor;
  import forms.ColorConstants;
  import projects.tanks.client.clans.clan.clanmembersdata.UserData;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.client.clans.clan.permissions.ClanPermission;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;

  public class ContextMenuPermissionLabel extends DiscreteSprite implements IClanPositionListener, IClanActionListener {
    [Inject]
    public static var clanService:ClanService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var clanMembersData:ClanMembersDataService;

    [Inject]
    public static var foreignClanService:ForeignClanService;

    [Inject]
    public static var localeService:ILocaleService;

    public static const HEIGHT:int = 18;

    protected var id:Long;
    protected var contextItem:Boolean;

    private var label:LabelBase;
    private var _width:Number;

    public var currentUserId:Long;
    public var permission:ClanPermission;
    public var data:Object;

    public function ContextMenuPermissionLabel(param1:ClanPermission) {
      super();
      this.permission = param1;
      this.label = createLabelBase(param1);
      this.addEventListeners();
      addChild(this.label);
      this.contextItem = true;
    }

    public static function createPositionLabel(param1:ClanPermission) : ContextMenuPermissionLabel {
      return new ContextMenuPermissionLabel(param1);
    }

    private static function createLabelBase(param1:ClanPermission) : LabelBase {
      var local2:LabelBase = new LabelBase();
      local2.autoSize = TextFieldAutoSize.LEFT;
      local2.color = ColorConstants.GREEN_LABEL;
      local2.text = getLocalizedNamePermission(param1);
      return local2;
    }

    public static function getLocalizedNamePermission(param1:ClanPermission) : String {
      switch(param1) {
        case ClanPermission.SUPREME_COMMANDER:
          return localeService.getText(TanksLocale.TEXT_CLAN_POSITION_SUPREME_COMMANDER);
        case ClanPermission.COMMANDER:
          return localeService.getText(TanksLocale.TEXT_CLAN_POSITION_COMMANDER);
        case ClanPermission.OFFICER:
          return localeService.getText(TanksLocale.TEXT_CLAN_POSITION_OFFICER);
        case ClanPermission.SERGEANT:
          return localeService.getText(TanksLocale.TEXT_CLAN_POSITION_SERGEANT);
        case ClanPermission.VETERAN:
          return localeService.getText(TanksLocale.TEXT_CLAN_POSITION_VETERAN);
        case ClanPermission.PRIVATE:
          return localeService.getText(TanksLocale.TEXT_CLAN_POSITION_PRIVATE);
        case ClanPermission.NOVICE:
          return localeService.getText(TanksLocale.TEXT_CLAN_POSITION_NOVICE);
        default:
          return "EMPTY";
      }
    }

    public function addEventListeners() : void {
      this.label.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,false,0,true);
      this.label.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,false,0,true);
    }

    private function onMouseOver(param1:MouseEvent = null) : void {
      if(this.contextItem) {
        Mouse.cursor = MouseCursor.BUTTON;
        this.label.color = ColorConstants.WHITE;
      } else if(this.isEditPermission()) {
        Mouse.cursor = MouseCursor.BUTTON;
      }
    }

    private function isEditPermission() : Boolean {
      return this.permission != ClanPermission.SUPREME_COMMANDER && this.currentUserId != this.id && Boolean(clanUserInfoService.hasAction(ClanAction.PERMISSION_DISTRIBUTION)) && !clanService.isBlocked && this.permission.value > clanMembersData.getPermission(this.currentUserId).value && !foreignClanService.isShowForeignClan();
    }

    private function onMouseOut(param1:MouseEvent = null) : void {
      Mouse.cursor = MouseCursor.AUTO;
      if(this.contextItem) {
        this.label.color = ColorConstants.GREEN_LABEL;
      }
    }

    public function dataChanged(param1:UserData) : void {
      this.label.text = getLocalizedNamePermission(param1.permission);
      this.data.permission = param1.permission;
      this.width = this._width;
    }

    public function updateActions() : void {
      if(foreignClanService.isShowForeignClan()) {
        return;
      }
      this.permission = clanMembersData.getPermission(this.userId);
      if(Boolean(clanUserInfoService.hasAction(ClanAction.PERMISSION_DISTRIBUTION)) && !clanService.isBlocked && this.permission.value > clanMembersData.getPermission(this.currentUserId).value) {
        if(this.permission != ClanPermission.SUPREME_COMMANDER && this.currentUserId != this.id) {
          addEventListener(MouseEvent.CLICK,this.onPositionClick,false,0,true);
        }
      } else if(hasEventListener(MouseEvent.CLICK)) {
        removeEventListener(MouseEvent.CLICK,this.onPositionClick);
      }
    }

    public function get userId() : Long {
      return this.id;
    }

    private function onPositionClick(param1:MouseEvent) : void {
      ClanPermissionsManager.show(this.userId,this.currentUserId,this);
    }

    public function destroy() : void {
      this.label.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
      this.label.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this.label.x = param1 - this.label.width >> 1;
    }

    override public function get width() : Number {
      return this._width;
    }
  }
}
