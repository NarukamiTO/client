package alternativa.tanks.gui.notinclan {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.notinclan.buttons.ClanUserListsButton;
  import alternativa.tanks.gui.notinclan.dialogs.ClanCreateDialog;
  import alternativa.tanks.gui.notinclan.dialogs.ClanDialog;
  import alternativa.tanks.gui.notinclan.dialogs.ClanLicenseDialog;
  import alternativa.tanks.models.service.ClanUserNotificationsManager;
  import alternativa.tanks.models.user.ClanUserService;
  import controls.base.LabelBase;
  import controls.base.ThreeLineBigButton;
  import controls.windowinner.WindowInner;
  import flash.display.Bitmap;
  import flash.events.MouseEvent;
  import flash.text.TextFormatAlign;
  import flash.utils.clearInterval;
  import flash.utils.setInterval;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;
  import utils.TimeFormatter;

  public class NotInClanPanel extends ClanDialog {
    [Inject]
    public static var clanUserService:ClanUserService;

    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    private static var attractionImageClass:Class = NotInClanPanel_attractionImageClass;

    private static const image:Bitmap = new attractionImageClass();

    public static const FRAME:Number = 7;
    public static const MARGIN:Number = 11;
    public static const WIDTH:Number = 790;
    public static const HEIGHT:Number = 450;

    private var _clanUserObject:IGameObject;
    private var _aboutClansLabel:LabelBase;
    private var _inner:WindowInner;
    private var _createClanButton:ThreeLineBigButton = new ThreeLineBigButton();
    private var _listsClanButton:ClanUserListsButton = new ClanUserListsButton();
    private var _clanDialog:ClanDialog;
    private var _restrictionTime:int = 0;
    private var restrictionInterval:uint = 0;

    public function NotInClanPanel(param1:IGameObject) {
      super();
      this._clanUserObject = param1;
      ClanUserNotificationsManager.addIncomingIndicatorListener(this._listsClanButton);
      this.init();
    }

    public function init() : void {
      this._inner = new WindowInner(0,0,WindowInner.GREEN);
      addChild(this._inner);
      addChild(image);
      this._aboutClansLabel = new LabelBase();
      this._aboutClansLabel.align = TextFormatAlign.CENTER;
      this._aboutClansLabel.text = localeService.getText(TanksLocale.TEXT_CLAN_DESCRIPTION);
      this._inner.addChild(this._aboutClansLabel);
      image.x = WIDTH / 2 - image.width / 2 + 1;
      image.y = 2 * MARGIN;
      this._inner.width = WIDTH - 2 * MARGIN;
      this._inner.height = HEIGHT - this._createClanButton.height - 3 * MARGIN;
      this._inner.x = MARGIN;
      this._inner.y = MARGIN;
      this._aboutClansLabel.width = this._inner.width - 2 * MARGIN;
      this._aboutClansLabel.height = this._inner.height - 2 * MARGIN;
      this._aboutClansLabel.x = this._inner.width / 2 - this._aboutClansLabel.width / 2;
      this._aboutClansLabel.y = image.y + image.height + MARGIN;
      this._createClanButton.label = localeService.getText(TanksLocale.TEXT_CLAN_CREATE);
      this._createClanButton.addEventListener(MouseEvent.CLICK,this.onCreateClanPressed);
      this._createClanButton.x = WIDTH / 2 - this._createClanButton.width - 13;
      this._createClanButton.y = HEIGHT - this._createClanButton.height - MARGIN;
      addChild(this._createClanButton);
      this._listsClanButton.label = localeService.getText(TanksLocale.TEXT_CLAN_SEARCH);
      this._listsClanButton.addEventListener(MouseEvent.CLICK,this.onCreateClanLists);
      this._listsClanButton.x = WIDTH / 2 + 13;
      this._listsClanButton.y = this._createClanButton.y;
      addChild(this._listsClanButton);
      this.initRestrictionTime();
    }

    private function onCreateClanLists(param1:MouseEvent) : void {
      this._clanDialog = new ClanListDialog();
    }

    private function onCreateClanPressed(param1:MouseEvent) : void {
      if(clanUserService.hasClanLicense) {
        this._clanDialog = new ClanCreateDialog();
      } else {
        this._clanDialog = new ClanLicenseDialog();
      }
    }

    override public function destroy() : void {
      clanUserService.hideNotInClanPanel();
      ClanUserNotificationsManager.removeIncomingIndicatorListener(this._listsClanButton);
      this._listsClanButton.destroy();
      if(this._clanDialog != null) {
        this._clanDialog.destroy();
      }
      clearInterval(this.restrictionInterval);
      super.destroy();
    }

    override public function get height() : Number {
      return HEIGHT;
    }

    override public function get width() : Number {
      return WIDTH;
    }

    override protected function getImageHeaderId() : String {
      return TanksLocale.TEXT_HEADER_CLAN;
    }

    public function showAlertFullClan() : void {
      alertService.showOkAlert(localeService.getText(TanksLocale.TEXT_CLAN_ALERT_CLAN_FULL));
    }

    public function initRestrictionTime() : void {
      this.restrictionTime = clanUserInfoService.restrictionTime;
      if(this.restrictionTime > 0 && this.restrictionInterval == 0) {
        this.restrictionCountDown();
        this.restrictionInterval = setInterval(this.restrictionCountDown,1000);
      }
    }

    private function restrictionCountDown() : void {
      --this.restrictionTime;
      if(this.restrictionTime <= 0) {
        clearInterval(this.restrictionInterval);
        this.restrictionInterval = 0;
        this.restrictionTime = 0;
        this._listsClanButton.enabled = true;
      } else {
        this._listsClanButton.enabled = false;
        this._listsClanButton.label = TimeFormatter.format(this.restrictionTime);
      }
    }

    public function set restrictionTime(param1:int) : void {
      this._restrictionTime = param1;
    }

    public function get restrictionTime() : int {
      return this._restrictionTime;
    }
  }
}
