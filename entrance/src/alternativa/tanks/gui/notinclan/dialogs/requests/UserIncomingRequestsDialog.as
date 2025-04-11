package alternativa.tanks.gui.notinclan.dialogs.requests {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.notinclan.clanslist.ClanListType;
  import alternativa.tanks.gui.notinclan.clanslist.ClansListEvent;
  import alternativa.tanks.models.user.ClanUserService;
  import alternativa.tanks.models.user.IClanUserModel;
  import alternativa.tanks.models.user.incoming.IClanUserIncomingModel;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import controls.base.TankInputBase;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import forms.ColorConstants;
  import forms.events.LoginFormEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class UserIncomingRequestsDialog extends UserRequestsDialog {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var clanUserService:ClanUserService;

    private static const SEARCH_TIMEOUT:int = 600;

    protected var actionButton:DefaultButtonBase = new DefaultButtonBase();
    protected var clanNameInput:TankInputBase = new TankInputBase();
    protected var searchLabel:LabelBase = new LabelBase();

    private var searchInListTimeOut:Number;
    private var labelClanAction:String = localeService.getText(TanksLocale.TEXT_CLAN_SEARCH_CLAN_IN_LIST);

    public function UserIncomingRequestsDialog(param1:int) {
      this.closeButtonWidth = param1;
      super();
      this.actionButton.addEventListener(MouseEvent.CLICK,this.onActionClick);
      this.clanNameInput.addEventListener(FocusEvent.FOCUS_IN,this.onFocusInSearchInput);
      this.clanNameInput.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOutSearchInput);
      this.clanNameInput.maxChars = 20;
      this.searchLabel.mouseEnabled = false;
      this.searchLabel.color = ColorConstants.LIST_LABEL_HINT;
      this.actionButton.label = localeService.getText(TanksLocale.TEXT_FRIENDS_DECLINE_ALL_BUTTON);
      this.actionButton.enable = true;
      this.actionButton.width = 120;
      this.searchLabel.text = this.labelClanAction;
      this.clanNameInput.addEventListener(LoginFormEvent.TEXT_CHANGED,this.onClanNameChanged);
      var local2:IClanUserIncomingModel = clanUserService.userObject.adapt(IClanUserIncomingModel) as IClanUserIncomingModel;
      clansList.fillClansList(local2.getIncomingClans(),ClanListType.INCOMING);
      ClansListEvent.getDispatcher().addEventListener(ClansListEvent.INCOMING + ClansListEvent.ADD,onAddRequest);
      ClansListEvent.getDispatcher().addEventListener(ClansListEvent.INCOMING + ClansListEvent.REMOVE,onCancelRequest);
      this.clanNameInput.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
      addChild(this.actionButton);
      addChild(this.clanNameInput);
      addChild(this.searchLabel);
    }

    override protected function onResize(param1:Event = null) : void {
      heightSearchUnit = Math.max(this.actionButton.height,this.clanNameInput.height);
      super.onResize(param1);
      this.actionButton.x = width - this.actionButton.width - 2 * MARGIN - closeButtonWidth;
      this.actionButton.y = height - this.actionButton.height - MARGIN;
      this.clanNameInput.x = MARGIN;
      this.clanNameInput.y = height - MARGIN - this.clanNameInput.height;
      this.clanNameInput.width = width - this.actionButton.width - 4 * MARGIN - closeButtonWidth;
      this.searchLabel.x = this.clanNameInput.x + 3;
      this.searchLabel.y = this.clanNameInput.y + 7;
    }

    override protected function onActionClick(param1:MouseEvent) : void {
      (clanUserService.userObject.adapt(IClanUserModel) as IClanUserModel).rejectAll();
    }

    private function onClanNameChanged(param1:LoginFormEvent) : void {
      clearTimeout(this.searchInListTimeOut);
      this.searchInListTimeOut = setTimeout(clansList.filterByProperty,SEARCH_TIMEOUT,"name",this.clanNameInput.value);
    }

    override protected function confirmationKeyPressed() : void {
      super.confirmationKeyPressed();
    }

    override protected function removeEvents() : void {
      super.removeEvents();
      ClansListEvent.getDispatcher().removeEventListener(ClansListEvent.INCOMING + ClansListEvent.ADD,onAddRequest);
      ClansListEvent.getDispatcher().removeEventListener(ClansListEvent.INCOMING + ClansListEvent.REMOVE,onCancelRequest);
      this.clanNameInput.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp);
      this.clanNameInput.removeEventListener(LoginFormEvent.TEXT_CHANGED,this.onClanNameChanged);
    }

    override public function destroy() : void {
      clansList.removeAllViewed();
      super.destroy();
    }

    private function onFocusInSearchInput(param1:FocusEvent) : void {
      this.searchLabel.visible = false;
    }

    private function onFocusOutSearchInput(param1:FocusEvent) : void {
      if(this.clanNameInput.value.length == 0) {
        this.searchLabel.visible = true;
      }
    }
  }
}
