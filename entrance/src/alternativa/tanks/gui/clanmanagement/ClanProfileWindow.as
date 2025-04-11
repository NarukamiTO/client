package alternativa.tanks.gui.clanmanagement {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.components.button.ClanButtonActionListener;
  import alternativa.tanks.models.clan.accepted.IClanAcceptedModel;
  import alternativa.tanks.models.clan.info.IClanInfoModel;
  import alternativa.tanks.models.clan.membersdata.ClanMembersDataService;
  import alternativa.tanks.models.service.ClanInfoUpdateEvent;
  import alternativa.tanks.models.service.ClanService;
  import alternativa.tanks.models.service.ClanServiceEvent;
  import alternativa.types.Long;
  import base.DiscreteSprite;
  import controls.TankWindow;
  import controls.TankWindowInner;
  import controls.windowinner.WindowInner;
  import flash.display.Bitmap;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;

  public class ClanProfileWindow extends DiscreteSprite {
    [Inject]
    public static var clanService:ClanService;

    [Inject]
    public static var clanMembersData:ClanMembersDataService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var localeService:ILocaleService;

    private static const FRAME:int = 7;
    private static const MARGIN:int = 11;
    private static const BUTTON_HEIGHT:int = 30;

    public static const INFO_INNER_HEIGHT:int = 120;

    private var bitmapDeachIcon:Class;
    private var bitmapKillsIcon:Class;
    private var bitmapKillsDeathsIcon:Class;
    private var bitmapPlayersIcon:Class;
    private var bonusesWindow:TankWindow;
    private var bonusesInner:WindowInner;
    private var descriptionWindow:TankWindow;
    private var editButton:ClanButtonActionListener;
    private var countMembersItem:ClanBonusItem;
    private var killsCountItem:ClanBonusItem;
    private var deathsCountItem:ClanBonusItem;
    private var killsDeathsItem:ClanBonusItem;
    private var _width:int;
    private var _height:int;
    private var clanInfo:IClanInfoModel;
    private var editedClanInfo:ClanInfoUpdateEvent;
    private var description:ClanDescriptionPanel;

    public function ClanProfileWindow(param1:IGameObject) {
      var local5:Long = null;
      this.bitmapDeachIcon = ClanProfileWindow_bitmapDeachIcon;
      this.bitmapKillsIcon = ClanProfileWindow_bitmapKillsIcon;
      this.bitmapKillsDeathsIcon = ClanProfileWindow_bitmapKillsDeathsIcon;
      this.bitmapPlayersIcon = ClanProfileWindow_bitmapPlayersIcon;
      this.editButton = new ClanButtonActionListener(ClanAction.EDIT_PROFILE);
      super();
      this.clanInfo = IClanInfoModel(param1.adapt(IClanInfoModel));
      this.bonusesWindow = new TankWindow();
      this.descriptionWindow = new TankWindow();
      addChild(this.bonusesWindow);
      addChild(this.descriptionWindow);
      this.bonusesInner = new WindowInner(this._width,INFO_INNER_HEIGHT,TankWindowInner.GREEN);
      this.bonusesWindow.addChild(this.bonusesInner);
      var local2:IClanAcceptedModel = IClanAcceptedModel(param1.adapt(IClanAcceptedModel));
      var local3:int = 0;
      var local4:int = 0;
      for each(local5 in local2.getAcceptedUsers()) {
        local3 += clanMembersData.getKills(local5);
        local4 += clanMembersData.getDeaths(local5);
      }
      this.countMembersItem = new ClanBonusItem(new this.bitmapPlayersIcon() as Bitmap,localeService.getText(TanksLocale.TEXT_CLAN_PLAYERS_IN_CLAN),"");
      this.setMembersCount();
      this.killsCountItem = new ClanBonusItem(new this.bitmapKillsIcon() as Bitmap,localeService.getText(TanksLocale.TEXT_CLAN_TANKS_DESTROYED),local3.toString());
      this.deathsCountItem = new ClanBonusItem(new this.bitmapDeachIcon() as Bitmap,localeService.getText(TanksLocale.TEXT_CLAN_TANKS_LOST),local4.toString());
      this.killsDeathsItem = new ClanBonusItem(new this.bitmapKillsDeathsIcon() as Bitmap,localeService.getText(TanksLocale.TEXT_CLAN_KILL_DEATH_RATION),"");
      if(local4 == 0) {
        this.killsDeathsItem.setValue("0.00");
      } else {
        this.killsDeathsItem.setValue((Number(local3) / local4).toFixed(2));
      }
      this.bonusesInner.addChild(this.countMembersItem);
      this.bonusesInner.addChild(this.killsCountItem);
      this.bonusesInner.addChild(this.deathsCountItem);
      this.bonusesInner.addChild(this.killsDeathsItem);
      this.description = new ClanDescriptionPanel(this.clanInfo.getDescription());
      this.descriptionWindow.addChild(this.description);
      this.editButton.label = localeService.getText(TanksLocale.TEXT_CLAN_EDIT_PROFILE);
      ClanActionsManager.addActionsUpdateListener(this.editButton);
      this.editButton.updateActions();
      this.editButton.addEventListener(MouseEvent.CLICK,this.onEditClick);
      addChild(this.editButton);
      clanService.addEventListener(ClanServiceEvent.CLAN_BLOCK,this.onClanBlock);
    }

    private function onClanBlock(param1:ClanServiceEvent) : void {
      this.description.setDescriptionText(this.clanInfo.getDescription());
    }

    private function onEditClick(param1:MouseEvent) : void {
      new ClanEditProfileDialog(this.clanInfo,this.editedClanInfo,this);
    }

    public function dispatchUpdate(param1:ClanInfoUpdateEvent) : void {
      dispatchEvent(param1);
      this.description.setDescriptionText(param1.clanDescription);
    }

    private function onResize(param1:Event = null) : void {
      this.bonusesWindow.y = MARGIN + ClanTopManagementPanel.HEIGHT - 3;
      this.bonusesWindow.width = this.width;
      this.bonusesWindow.height = INFO_INNER_HEIGHT + 2 * MARGIN;
      this.descriptionWindow.y = this.bonusesWindow.y + this.bonusesWindow.height;
      this.descriptionWindow.width = this.width;
      this.descriptionWindow.height = this.height - this.descriptionWindow.y;
      this.bonusesInner.x = MARGIN;
      this.bonusesInner.y = MARGIN;
      this.bonusesInner.width = this.bonusesWindow.width - 2 * MARGIN;
      this.bonusesInner.height = INFO_INNER_HEIGHT;
      this.description.x = MARGIN;
      this.description.y = MARGIN;
      this.description.width = this.descriptionWindow.width - 2 * MARGIN;
      this.description.height = this.descriptionWindow.height - BUTTON_HEIGHT - FRAME - 2 * MARGIN;
      this.description.onResize();
      this.bonusesInner.addChild(this.countMembersItem);
      this.bonusesInner.addChild(this.killsCountItem);
      this.bonusesInner.addChild(this.deathsCountItem);
      this.bonusesInner.addChild(this.killsDeathsItem);
      this.countMembersItem.x = MARGIN;
      this.killsCountItem.x = this.countMembersItem.x + this.countMembersItem.width + MARGIN;
      this.deathsCountItem.x = this.killsCountItem.x + this.killsCountItem.width + MARGIN;
      this.killsDeathsItem.x = this.deathsCountItem.x + this.deathsCountItem.width + MARGIN;
      this.countMembersItem.y = MARGIN;
      this.killsCountItem.y = this.countMembersItem.y;
      this.deathsCountItem.y = this.countMembersItem.y;
      this.killsDeathsItem.y = this.countMembersItem.y;
      this.editButton.x = MARGIN;
      this.editButton.y = this._height - this.editButton.height - MARGIN - 1;
    }

    private function setMembersCount() : void {
      this.countMembersItem.setValue(clanService.membersCount.toString());
    }

    public function userAdded() : void {
      this.setMembersCount();
    }

    public function userRemoved() : void {
      this.setMembersCount();
    }

    public function setInfo(param1:ClanInfoUpdateEvent) : void {
      this.editedClanInfo = param1;
      this.onResize();
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this.onResize();
    }

    override public function get height() : Number {
      return this._height;
    }

    override public function set height(param1:Number) : void {
      this._height = param1;
      this.onResize();
    }
  }
}
