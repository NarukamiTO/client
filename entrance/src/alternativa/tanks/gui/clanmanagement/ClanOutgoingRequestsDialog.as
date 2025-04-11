package alternativa.tanks.gui.clanmanagement {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.ISourceData;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.SearchInputView;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.candidates.ClanOutgoingListRenderer;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.candidates.HeaderClanCandidateList;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.ClanMembersDataProvider;
  import alternativa.tanks.gui.notinclan.dialogs.ClanDialog;
  import alternativa.tanks.models.clan.outgoing.IClanOutgoingModel;
  import alternativa.tanks.service.clan.ClanMembersListEvent;
  import alternativa.types.Long;
  import controls.windowinner.WindowInner;
  import fl.controls.List;
  import forms.Styles;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanFunctionsService;
  import utils.ScrollStyleUtils;

  public class ClanOutgoingRequestsDialog extends ClanDialog {
    [Inject]
    public static var clanFunctionsService:ClanFunctionsService;

    [Inject]
    public static var localeService:ILocaleService;

    public static const WIDTH:Number = 550;
    public static const HEIGHT:Number = 450;

    private var inner:WindowInner;
    private var list:List;
    private var dataProvider:ClanMembersDataProvider;
    private var _header:HeaderClanCandidateList;
    private var outgoingModel:IClanOutgoingModel;
    private var searchInput:SearchInputView;

    public function ClanOutgoingRequestsDialog(param1:IGameObject) {
      super();
      this.outgoingModel = IClanOutgoingModel(param1.adapt(IClanOutgoingModel));
      this.outgoingModel.setClanOutgoingWindow(this);
      this.inner = new WindowInner(WIDTH,HEIGHT,WindowInner.GREEN);
      window.addChild(this.inner);
      this._header = new HeaderClanCandidateList();
      this.inner.addChild(this._header);
      this.dataProvider = new ClanMembersDataProvider();
      this.list = new List();
      this.list.rowHeight = 20;
      this.list.setStyle(Styles.CELL_RENDERER,ClanOutgoingListRenderer);
      this.list.focusEnabled = true;
      this.list.selectable = false;
      this.list.dataProvider = this.dataProvider;
      ScrollStyleUtils.setGreenStyle(this.list);
      this.inner.addChild(this.list);
      var local2:ISourceData = ISourceData(param1.adapt(ISourceData));
      this.searchInput = new SearchInputView(local2,localeService.getText(TanksLocale.TEXT_CLAN_SEND_INVITE),localeService.getText(TanksLocale.TEXT_FRIENDS_SEND_REQUEST_BUTTON),"","");
      window.addChild(this.searchInput);
      ScrollStyleUtils.setGreenStyle(this.list);
      this.fillData();
      this.list.addEventListener(ClanMembersListEvent.REVOKE_USER,this.onRevokeUser);
      this.resize();
    }

    private function onRevokeUser(param1:ClanMembersListEvent) : void {
      clanFunctionsService.revokeRequest(param1.userId);
    }

    public function resize() : void {
      var local1:int = HEIGHT - closeButton.height - MARGIN;
      this.inner.x = MARGIN;
      this.inner.y = MARGIN;
      this.inner.width = WIDTH - 2 * MARGIN;
      this.inner.height = local1 - 2 * MARGIN;
      this._header.x = 3;
      this._header.y = 3;
      this._header.width = this.inner.width - 6;
      this.list.x = 3;
      this.list.y = 23;
      this.list.height = this.inner.height - 24;
      var local2:Boolean = this.list.maxVerticalScrollPosition > 0;
      this.list.width = local2 ? this.inner.width + 2 : this.inner.width - 6;
      if(this.searchInput != null) {
        this.searchInput.x = MARGIN;
        this.searchInput.y = HEIGHT - MARGIN - 30;
        this.searchInput.width = WIDTH - 2 * MARGIN - 2 * closeButton.width - 17;
      }
    }

    public function fillData() : void {
      var local1:Long = null;
      this.dataProvider.removeAll();
      for each(local1 in this.outgoingModel.getUsers()) {
        this.dataProvider.addItem({"id":local1});
      }
      this.sort();
      this.resize();
    }

    private function sort() : void {
      this.dataProvider.sortOn(["id"],[Array.NUMERIC]);
    }

    public function addUser(param1:Long) : void {
      this.dataProvider.addItem({"id":param1});
      this.sort();
      this.resize();
    }

    public function removeUser(param1:Long) : void {
      var local2:int = this.dataProvider.getItemIndexById(param1);
      if(local2 >= 0) {
        this.dataProvider.removeItemAt(local2);
      }
      this.sort();
      this.resize();
    }

    override public function updateActions() : void {
      if(!clanUserInfoService.hasAction(ClanAction.INVITE_TO_CLAN)) {
        this.destroy();
      }
    }

    override public function destroy() : void {
      this.searchInput.hide();
      super.destroy();
    }

    override public function get height() : Number {
      return HEIGHT;
    }

    override public function get width() : Number {
      return WIDTH;
    }

    override protected function getImageHeaderId() : String {
      return TanksLocale.TEXT_HEADER_CLAN_MANAGMENT;
    }
  }
}
