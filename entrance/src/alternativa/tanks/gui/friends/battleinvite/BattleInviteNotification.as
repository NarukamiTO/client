package alternativa.tanks.gui.friends.battleinvite {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.types.Long;
  import assets.cellrenderer.battlelist.SportBattleItemIcon;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.events.MouseEvent;
  import flash.text.TextLineMetrics;
  import forms.ColorConstants;
  import forms.userlabel.UserLabel;
  import projects.tanks.client.tanksservices.types.battle.BattleInfoData;
  import projects.tanks.clients.flash.commons.services.notification.Notification;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  public class BattleInviteNotification extends Notification {
    [Inject]
    public static var battleInviteService:IBattleInviteService;

    [Inject]
    public static var battleAlertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var dialogWindowsDispatcherService:IDialogWindowsDispatcherService;

    private static const DEFAULT_BUTTON_WIDTH:int = 96;
    private static const SHOW_ALERT_ABOUT_INACCESSIBLE_IN_STANDALONE:String = "SHOW_ALERT_ABOUT_INACCESSIBLE_IN_STANDALONE";

    private var _userLabel:UserLabel;
    private var battleData:BattleInfoData;
    private var _baseMessageLabel:LabelBase;
    private var _mapAndServerNumberMessageLabel:LabelBase;
    private var _rejectButton:DefaultButtonBase;
    private var _acceptButton:DefaultButtonBase;
    private var _mapAndServerNumberString:String;
    private var _noSuppliesIcon:SportBattleItemIcon;

    public function BattleInviteNotification(param1:Long, param2:String, param3:String, param4:BattleInfoData) {
      this.battleData = param4;
      this._mapAndServerNumberString = param3;
      super(param1,param2);
    }

    override protected function init() : void {
      super.init();
      this._userLabel = new UserLabel(userId);
      addChild(this._userLabel);
      this._baseMessageLabel = new LabelBase();
      this._baseMessageLabel.color = ColorConstants.GREEN_LABEL;
      this._baseMessageLabel.mouseEnabled = false;
      addChild(this._baseMessageLabel);
      this._baseMessageLabel.htmlText = message;
      this._mapAndServerNumberMessageLabel = new LabelBase();
      this._mapAndServerNumberMessageLabel.color = ColorConstants.GREEN_LABEL;
      this._mapAndServerNumberMessageLabel.mouseEnabled = false;
      addChild(this._mapAndServerNumberMessageLabel);
      this._mapAndServerNumberMessageLabel.htmlText = this._mapAndServerNumberString;
      if(this.battleData.proBattle) {
        this._noSuppliesIcon = new SportBattleItemIcon();
        this._noSuppliesIcon.gotoAndStop(1);
        addChild(this._noSuppliesIcon);
      }
      this._acceptButton = new DefaultButtonBase();
      this._acceptButton.width = DEFAULT_BUTTON_WIDTH;
      this._acceptButton.label = localeService.getText(TanksLocale.TEXT_GO_TO_BATTLE_LABEL);
      addChild(this._acceptButton);
      this._rejectButton = new DefaultButtonBase();
      this._rejectButton.width = DEFAULT_BUTTON_WIDTH;
      this._rejectButton.label = localeService.getText(TanksLocale.TEXT_DECLINE_LABEL);
      addChild(this._rejectButton);
    }

    override protected function setEvents() : void {
      super.setEvents();
      this._acceptButton.addEventListener(MouseEvent.CLICK,this.onAcceptClick);
      this._rejectButton.addEventListener(MouseEvent.CLICK,this.onRejectClick);
    }

    override protected function removeEvents() : void {
      super.removeEvents();
      this._acceptButton.removeEventListener(MouseEvent.CLICK,this.onAcceptClick);
      this._rejectButton.removeEventListener(MouseEvent.CLICK,this.onRejectClick);
    }

    private function onAcceptClick(param1:MouseEvent = null) : void {
      dialogWindowsDispatcherService.forciblyClose();
      battleInviteService.accept(userId,this.battleData);
      hide();
    }

    private function onRejectClick(param1:MouseEvent) : void {
      this.closeNotification();
    }

    override protected function closeNotification() : void {
      battleInviteService.reject(userId);
      hide();
    }

    override protected function resize() : void {
      this._userLabel.x = GAP + 7;
      this._userLabel.y = GAP + 5;
      this._baseMessageLabel.x = GAP + 9;
      this._baseMessageLabel.y = this._userLabel.y + this._userLabel.height - 1;
      this._mapAndServerNumberMessageLabel.x = GAP + 9;
      var local1:TextLineMetrics = this._baseMessageLabel.getLineMetrics(0);
      if(this.battleData.proBattle) {
        this._noSuppliesIcon.x = GAP + 12;
        this._noSuppliesIcon.y = this._baseMessageLabel.y + local1.height + 3;
        this._mapAndServerNumberMessageLabel.x = this._noSuppliesIcon.x + this._noSuppliesIcon.width + 2;
      }
      this._mapAndServerNumberMessageLabel.y = this._baseMessageLabel.y + local1.height;
      _innerHeight = this._baseMessageLabel.y + this._baseMessageLabel.height - 3;
      var local2:int = this._baseMessageLabel.x + this._baseMessageLabel.width + GAP * 2;
      if(local2 > _width) {
        _width = local2;
      }
      var local3:int = _innerHeight + 16;
      this._acceptButton.x = GAP;
      this._acceptButton.y = local3;
      this._rejectButton.x = _width - this._rejectButton.width - GAP;
      this._rejectButton.y = local3;
      _height = this._acceptButton.y + this._acceptButton.height + GAP + 1;
      super.resize();
    }
  }
}
