package alternativa.tanks.gui.notinclan.dialogs.requests {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.ISourceData;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.SearchInputView;
  import alternativa.tanks.gui.notinclan.clanslist.ClanListType;
  import alternativa.tanks.gui.notinclan.clanslist.ClansListEvent;
  import alternativa.tanks.models.user.ClanUserService;
  import alternativa.tanks.models.user.outgoing.IClanUserOutgoingModel;
  import flash.events.Event;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class UserOutgoingRequestsDialog extends UserRequestsDialog {
    [Inject]
    public static var clanUserService:ClanUserService;

    [Inject]
    public static var localeService:ILocaleService;

    private var searchInput:SearchInputView;

    public function UserOutgoingRequestsDialog(param1:int) {
      this.closeButtonWidth = param1;
      var local2:ISourceData = ISourceData(clanUserService.userObject.adapt(ISourceData));
      this.searchInput = new SearchInputView(local2,localeService.getText(TanksLocale.TEXT_CLAN_SEND_REQUEST_TO_CLAN),localeService.getText(TanksLocale.TEXT_CLAN_SEND_REQUEST),localeService.getText(TanksLocale.TEXT_CLAN_SEARCH_BLOCKED_HINT),"");
      super();
      var local3:IClanUserOutgoingModel = clanUserService.userObject.adapt(IClanUserOutgoingModel) as IClanUserOutgoingModel;
      clansList.fillClansList(local3.getOutgoingClans(),ClanListType.OUTGOING);
      ClansListEvent.getDispatcher().addEventListener(ClansListEvent.OUTGOING + ClansListEvent.ADD,onAddRequest);
      ClansListEvent.getDispatcher().addEventListener(ClansListEvent.OUTGOING + ClansListEvent.REMOVE,onCancelRequest);
      addChild(this.searchInput);
    }

    override protected function onResize(param1:Event = null) : void {
      heightSearchUnit = this.searchInput.height;
      super.onResize(param1);
      this.searchInput.width = width - 3 * MARGIN - closeButtonWidth;
      this.searchInput.x = MARGIN;
      this.searchInput.y = height - this.searchInput.height - MARGIN;
    }

    override protected function removeEvents() : void {
      super.removeEvents();
      ClansListEvent.getDispatcher().removeEventListener(ClansListEvent.OUTGOING + ClansListEvent.ADD,onAddRequest);
      ClansListEvent.getDispatcher().removeEventListener(ClansListEvent.OUTGOING + ClansListEvent.REMOVE,onCancelRequest);
    }

    override public function destroy() : void {
      this.searchInput.hide();
      super.destroy();
    }
  }
}
