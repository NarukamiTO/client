package alternativa.tanks.gui.notinclan.clanslist {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.components.indicators.NewClanItemIndicator;
  import alternativa.tanks.gui.notinclan.dialogs.ClanDialog;
  import alternativa.tanks.models.user.IClanUserModel;
  import alternativa.types.Long;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import flash.utils.clearInterval;
  import flash.utils.setInterval;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class UserIncomingRequestLabel extends ClanInfoLabel {
    [Inject]
    public static var localeService:ILocaleService;

    private var acceptIndicator:AcceptIndicator = new AcceptIndicator();

    public var newIndicator:NewClanItemIndicator;

    private var restrictionTime:int;
    private var restrictionInterval:uint = 0;

    public function UserIncomingRequestLabel(param1:Long) {
      this.newIndicator = this.createNewIndicator(param1);
      super(param1);
    }

    override protected function onModelInfoLoaded(param1:Event = null) : void {
      super.onModelInfoLoaded();
      this.acceptIndicator.visible = false;
      this.acceptIndicator.addEventListener(MouseEvent.CLICK,this.onAccept);
      addChild(this.acceptIndicator);
      this.newIndicator.updateNotifications();
      if(param1 != null) {
        this.newIndicator.visible = true;
      }
      addChild(this.newIndicator);
      onRollOut();
      this.initRestrictionTime();
    }

    public function initRestrictionTime() : void {
      this.restrictionTime = clanUserInfoService.restrictionTime;
      if(this.restrictionTime > 0 && this.restrictionInterval == 0) {
        this.restrictionInterval = setInterval(this.restrictionCountDown,this.restrictionTime * 1000);
      }
    }

    private function restrictionCountDown() : void {
      clearInterval(this.restrictionInterval);
      this.restrictionInterval = 0;
      this.restrictionTime = 0;
    }

    override public function resize() : void {
      super.resize();
      this.newIndicator.x = width - 3 * ClanDialog.MARGIN - this.newIndicator.width + 2;
      this.acceptIndicator.x = cancelIndicator.x - this.acceptIndicator.width - 3;
      this.acceptIndicator.y = cancelIndicator.y;
    }

    private function createNewIndicator(param1:Long) : NewClanItemIndicator {
      var local2:NewClanItemIndicator = new NewClanItemIndicator(param1);
      local2.autoSize = TextFieldAutoSize.LEFT;
      local2.align = TextFormatAlign.LEFT;
      local2.color = ColorConstants.GREEN_LABEL;
      local2.text = localeService.getText(TanksLocale.TEXT_FRIENDS_NEW);
      local2.mouseEnabled = false;
      return local2;
    }

    override public function showIndicators() : void {
      super.showIndicators();
      if(this.acceptIndicator != null && this.restrictionTime <= 0) {
        this.acceptIndicator.visible = true;
      }
    }

    override public function hideIndicators() : void {
      super.hideIndicators();
      if(this.acceptIndicator != null) {
        this.acceptIndicator.visible = false;
      }
    }

    private function onAccept(param1:MouseEvent) : void {
      this.acceptIndicator.visible = false;
      var local2:IGameObject = clanUserService.getObjectById(clanId);
      (clanUserService.userObject.adapt(IClanUserModel) as IClanUserModel).acceptRequest(local2);
    }

    override protected function onCancelClick(param1:MouseEvent) : void {
      cancelIndicator.visible = false;
      var local2:IGameObject = clanUserService.getObjectById(clanId);
      (clanUserService.userObject.adapt(IClanUserModel) as IClanUserModel).reject(local2);
    }
  }
}
