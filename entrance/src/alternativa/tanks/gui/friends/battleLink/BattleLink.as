package alternativa.tanks.gui.friends.battleLink {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.friends.list.renderer.FriendsAcceptedListRenderer;
  import alternativa.types.Long;
  import assets.cellrenderer.battlelist.SportBattleItemIcon;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import forms.ColorConstants;
  import forms.contextmenu.BattleInviteContextMenuLabel;
  import platform.client.fp10.core.service.address.AddressService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle.BattleLinkData;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoLabelUpdater;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.UserInfoLabelUpdaterEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class BattleLink extends Sprite {
    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var addressService:AddressService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private var _userId:Long;
    private var _data:BattleLinkData;
    private var _proBattleIcon:SportBattleItemIcon;
    private var _label:LabelBase;
    private var _labelCont:Sprite;
    private var _userInfoUpdater:IUserInfoLabelUpdater;
    private var _availableBattleIcon:Bitmap;

    public function BattleLink(param1:Long) {
      super();
      this._userId = param1;
      this.init();
    }

    private function init() : void {
      this.tabChildren = false;
      this.tabEnabled = false;
      this._availableBattleIcon = new Bitmap(BattleInviteContextMenuLabel.battleInviteBitmapData);
      this._availableBattleIcon.y = (FriendsAcceptedListRenderer.ROW_HEIGHT - this._availableBattleIcon.height) / 2;
      this._availableBattleIcon.visible = false;
      addChild(this._availableBattleIcon);
      this._proBattleIcon = new SportBattleItemIcon();
      this._proBattleIcon.gotoAndStop(1);
      this._proBattleIcon.visible = false;
      this._proBattleIcon.y = (FriendsAcceptedListRenderer.ROW_HEIGHT - this._proBattleIcon.height) / 2;
      addChild(this._proBattleIcon);
      this._labelCont = new Sprite();
      addChild(this._labelCont);
      this._label = new LabelBase();
      this._label.color = ColorConstants.GREEN_LABEL;
      this._label.mouseEnabled = false;
      this._labelCont.addChild(this._label);
      this._labelCont.y = -1;
      this._proBattleIcon.x = 0;
      this._availableBattleIcon.x = this._proBattleIcon.x + this._proBattleIcon.width + 5;
      this._labelCont.x = this._availableBattleIcon.x + this._availableBattleIcon.width + 2;
      this._userInfoUpdater = userInfoService.getOrCreateUpdater(this._userId);
      this._userInfoUpdater.addEventListener(UserInfoLabelUpdaterEvent.CHANGE_BATTLE_LINK,this.onChangeBattleLink);
      if(this._userInfoUpdater.hasData()) {
        this.updateBattleLink(this._userInfoUpdater.battleLink);
      }
    }

    private function onChangeBattleLink(param1:UserInfoLabelUpdaterEvent) : void {
      this.updateBattleLink(this._userInfoUpdater.battleLink);
    }

    private function updateBattleLink(param1:BattleLinkData) : void {
      this._data = param1;
      this._proBattleIcon.visible = false;
      this._availableBattleIcon.visible = false;
      var local2:String = "";
      var local3:Boolean = false;
      if(this.hasData()) {
        if(!this._data.proBattle) {
          local2 = param1.inGroup ? localeService.getText(TanksLocale.TEXT_FRIENDS_IN_GROUP) : localeService.getText(TanksLocale.TEXT_FRIENDS_IN_BATTLE);
        } else if(this._data.isShowBattle()) {
          local2 = this.getInProBattleText(param1);
          this._proBattleIcon.visible = true;
          this._availableBattleIcon.visible = this._data.availableRank();
          local3 = this._data.isClickable();
        }
      }
      this._labelCont.buttonMode = this._labelCont.useHandCursor = local3;
      this._label.htmlText = local2;
    }

    private function getInProBattleText(param1:BattleLinkData) : String {
      if(this.isSelfBattle()) {
        return param1.mapName + " " + localeService.getText(TanksLocale.TEXT_FRIENDS_YOU_ARE_HERE_BATTLE_INDICATOR);
      }
      return param1.isClickable() ? "<u>" + param1.mapName + "</u>" : param1.mapName;
    }

    private function isSelfBattle() : Boolean {
      return addressService != null && this._data.isSelfBattle();
    }

    public function get data() : BattleLinkData {
      return this._data;
    }

    public function hasData() : Boolean {
      return this._data != null;
    }

    public function removeEvents() : void {
      this._userInfoUpdater.removeEventListener(UserInfoLabelUpdaterEvent.CHANGE_BATTLE_LINK,this.onChangeBattleLink);
    }

    public function get labelCont() : Sprite {
      return this._labelCont;
    }
  }
}
