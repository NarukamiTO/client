package alternativa.tanks.gui.panel {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.panel.buttons.ClanButton;
  import alternativa.tanks.gui.panel.buttons.FriendsButton;
  import alternativa.tanks.gui.panel.buttons.MainPanelFullscreenButton;
  import alternativa.tanks.gui.panel.buttons.QuestsButton;
  import alternativa.tanks.gui.panel.buttons.ShopBarButton;
  import alternativa.tanks.service.clan.ClanPanelNotificationService;
  import controls.base.MainPanelBattlesButtonBase;
  import controls.base.MainPanelGarageButtonBase;
  import controls.panel.BaseButton;
  import flash.display.MovieClip;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import forms.*;
  import forms.events.MainButtonBarEvents;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.fullscreen.FullscreenService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import services.buttonbar.IButtonBarService;

  public class ButtonBar extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var buttonBarService:IButtonBarService;

    [Inject]
    public static var fullscreenService:FullscreenService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var clanPanelNotificationService:ClanPanelNotificationService;

    private static const SECTION_BUTTON_GAP:int = 8;

    public var battlesButton:MainPanelBattlesButtonBase = new MainPanelBattlesButtonBase();
    public var garageButton:MainPanelGarageButtonBase = new MainPanelGarageButtonBase();
    public var clanButton:ClanButton = new ClanButton();
    public var settingsButton:MainPanelConfigButton = new MainPanelConfigButton();
    public var closeButton:CloseOrBackButton = new CloseOrBackButton();
    public var fullScreenButton:MainPanelFullscreenButton = new MainPanelFullscreenButton();

    private var soundButton:MainPanelSoundButton = new MainPanelSoundButton();
    private var helpButton:MainPanelHelpButton = new MainPanelHelpButton();
    private var shopButton:ShopBarButton = new ShopBarButton();
    private var questsButton:QuestsButton = new QuestsButton();
    private var friendsButton:FriendsButton = new FriendsButton();
    private var _soundOn:Boolean = true;
    private var soundIcon:MovieClip;

    public function ButtonBar() {
      super();
      addChild(this.shopButton);
      addChild(this.battlesButton);
      addChild(this.garageButton);
      addChild(this.clanButton);
      addChild(this.questsButton);
      addChild(this.friendsButton);
      addChild(this.settingsButton);
      addChild(this.closeButton);
      addChild(this.soundButton);
      addChild(this.fullScreenButton);
      addChild(this.helpButton);
      this.shopButton.type = 1;
      this.shopButton.label = localeService.getText(TanksLocale.TEXT_MAIN_PANEL_BUTTON_SHOP);
      this.shopButton.addEventListener(MouseEvent.CLICK,this.listClick);
      this.battlesButton.type = 2;
      this.battlesButton.label = localeService.getText(TanksLocale.TEXT_MAIN_PANEL_BUTTON_BATTLES);
      this.battlesButton.enable = false;
      this.battlesButton.addEventListener(MouseEvent.CLICK,this.listClick);
      this.garageButton.type = 3;
      this.garageButton.label = localeService.getText(TanksLocale.TEXT_MAIN_PANEL_BUTTON_GARAGE);
      this.garageButton.addEventListener(MouseEvent.CLICK,this.listClick);
      this.clanButton.type = 11;
      this.clanButton.label = localeService.getText(TanksLocale.TEXT_CLAN);
      this.clanButton.addEventListener(MouseEvent.CLICK,this.listClick);
      this.clanButton.visible = clanPanelNotificationService.clanButtonVisible;
      this.questsButton.type = 10;
      this.questsButton.addEventListener(MouseEvent.CLICK,this.listClick);
      this.friendsButton.type = 8;
      this.friendsButton.addEventListener(MouseEvent.CLICK,this.listClick);
      this.settingsButton.type = 4;
      this.settingsButton.addEventListener(MouseEvent.CLICK,this.listClick);
      this.soundButton.type = 5;
      this.soundButton.addEventListener(MouseEvent.CLICK,this.listClick);
      this.soundIcon = this.soundButton.getChildByName("icon") as MovieClip;
      this.fullScreenButton.type = 9;
      this.fullScreenButton.addEventListener(MouseEvent.CLICK,this.listClick);
      this.helpButton.type = 6;
      this.helpButton.addEventListener(MouseEvent.CLICK,this.listClick);
      this.closeButton.addEventListener(MouseEvent.CLICK,this.listClick);
      this.draw();
    }

    public function draw() : void {
      this.questsButton.visible = userPropertiesService.isQuestsAvailableByRank();
      this.battlesButton.x = this.shopButton.x + this.shopButton.width + 1;
      this.garageButton.x = this.battlesButton.x + this.battlesButton.width;
      this.clanButton.x = this.garageButton.x + this.garageButton.width;
      var local1:Number = SECTION_BUTTON_GAP;
      if(this.clanButton.visible) {
        local1 += this.clanButton.x + this.clanButton.width;
      } else {
        local1 += this.garageButton.x + this.garageButton.width;
      }
      this.questsButton.x = local1;
      this.friendsButton.x = this.questsButton.x + (this.questsButton.visible ? this.questsButton.width : 0);
      this.settingsButton.x = this.friendsButton.x + this.friendsButton.width;
      this.soundButton.x = this.settingsButton.x + this.settingsButton.width;
      this.fullScreenButton.x = this.soundButton.x + this.soundButton.width;
      this.helpButton.x = this.fullScreenButton.x + this.fullScreenButton.width;
      this.closeButton.x = this.helpButton.x + this.helpButton.width + 6;
      this.soundIcon.gotoAndStop(this.soundOn ? 1 : 2);
    }

    public function hidePaymentButton() : void {
      this.shopButton.width = 0;
      this.shopButton.visible = false;
      this.draw();
      MainPanel(parent).resize();
    }

    public function hideClanButton() : void {
      this.clanButton.visible = false;
      this.draw();
      MainPanel(parent).resize();
    }

    public function showClanButton() : void {
      this.clanButton.visible = true;
      this.draw();
      MainPanel(parent).resize();
    }

    public function set soundOn(param1:Boolean) : void {
      this._soundOn = param1;
      this.draw();
    }

    public function get soundOn() : Boolean {
      return this._soundOn;
    }

    private function listClick(param1:MouseEvent) : void {
      var local2:Object = param1.currentTarget;
      if(Boolean(local2.enable) || local2 is BaseButton && local2.selected) {
        dispatchEvent(new MainButtonBarEvents(local2.type));
        buttonBarService.change(local2.type);
      }
      if(local2 == this.soundButton) {
        this.soundOn = !this.soundOn;
      }
    }
  }
}
