package alternativa.tanks.view.matchmaking.group.invite {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.types.Long;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.events.MouseEvent;
  import forms.ColorConstants;
  import forms.userlabel.UserLabel;
  import projects.tanks.clients.flash.commons.services.notification.Notification;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogwindowdispatcher.IDialogWindowsDispatcherService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.groupinvite.GroupInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  public class GroupInviteNotification extends Notification {
    [Inject]
    public static var inviteService:GroupInviteService;

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

    private var userLabel:UserLabel;
    private var baseMessageLabel:LabelBase;
    private var rejectButton:DefaultButtonBase;
    private var acceptButton:DefaultButtonBase;

    public function GroupInviteNotification(param1:Long) {
      super(param1,localeService.getText(TanksLocale.TEXT_GROUP_INVITE));
    }

    override protected function init() : void {
      super.init();
      this.userLabel = new UserLabel(userId);
      addChild(this.userLabel);
      this.baseMessageLabel = new LabelBase();
      this.baseMessageLabel.color = ColorConstants.GREEN_LABEL;
      this.baseMessageLabel.mouseEnabled = false;
      addChild(this.baseMessageLabel);
      this.baseMessageLabel.htmlText = message;
      this.acceptButton = new DefaultButtonBase();
      this.acceptButton.width = DEFAULT_BUTTON_WIDTH;
      this.acceptButton.label = localeService.getText(TanksLocale.TEXT_GO_TO_BATTLE_LABEL);
      addChild(this.acceptButton);
      this.rejectButton = new DefaultButtonBase();
      this.rejectButton.width = DEFAULT_BUTTON_WIDTH;
      this.rejectButton.label = localeService.getText(TanksLocale.TEXT_DECLINE_LABEL);
      addChild(this.rejectButton);
    }

    override protected function setEvents() : void {
      super.setEvents();
      this.acceptButton.addEventListener(MouseEvent.CLICK,this.onAcceptClick);
      this.rejectButton.addEventListener(MouseEvent.CLICK,this.onRejectClick);
    }

    override protected function removeEvents() : void {
      super.removeEvents();
      this.acceptButton.removeEventListener(MouseEvent.CLICK,this.onAcceptClick);
      this.rejectButton.removeEventListener(MouseEvent.CLICK,this.onRejectClick);
    }

    private function onAcceptClick(param1:MouseEvent = null) : void {
      dialogWindowsDispatcherService.forciblyClose();
      inviteService.accept(userId);
      hide();
    }

    private function onRejectClick(param1:MouseEvent) : void {
      this.closeNotification();
    }

    override protected function closeNotification() : void {
      inviteService.reject(userId);
      hide();
    }

    override protected function resize() : void {
      this.userLabel.x = GAP + 7;
      this.userLabel.y = GAP + 5;
      this.baseMessageLabel.x = GAP + 9;
      this.baseMessageLabel.y = this.userLabel.y + this.userLabel.height - 1;
      _innerHeight = this.baseMessageLabel.y + this.baseMessageLabel.height - 3;
      var local1:int = this.baseMessageLabel.x + this.baseMessageLabel.width + GAP * 2;
      if(local1 > _width) {
        _width = local1;
      }
      var local2:int = _innerHeight + 16;
      this.acceptButton.x = GAP;
      this.acceptButton.y = local2;
      this.rejectButton.x = _width - this.rejectButton.width - GAP;
      this.rejectButton.y = local2;
      _height = this.acceptButton.y + this.acceptButton.height + GAP + 1;
      super.resize();
    }
  }
}
