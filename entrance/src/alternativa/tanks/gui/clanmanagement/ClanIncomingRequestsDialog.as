package alternativa.tanks.gui.clanmanagement {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.candidates.ClanIncomingListRenderer;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.candidates.HeaderClanCandidateList;
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.list.ClanMembersDataProvider;
  import alternativa.tanks.gui.notinclan.dialogs.ClanDialog;
  import alternativa.tanks.models.clan.incoming.IClanIncomingModel;
  import alternativa.tanks.models.service.ClanNotificationsManager;
  import alternativa.tanks.service.clan.ClanMembersListEvent;
  import alternativa.types.Long;
  import controls.base.DefaultButtonBase;
  import controls.windowinner.WindowInner;
  import fl.controls.List;
  import flash.events.MouseEvent;
  import flash.utils.Dictionary;
  import forms.Styles;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanFunctionsService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoLabelUpdater;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;
  import utils.ScrollStyleUtils;

  public class ClanIncomingRequestsDialog extends ClanDialog {
    [Inject]
    public static var clanFunctionsService:ClanFunctionsService;

    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var userInfoService:IUserInfoService;

    public static const WIDTH:Number = 550;
    public static const HEIGHT:Number = 450;

    private var viewed:Dictionary;
    private var inner:WindowInner;
    private var list:List;
    private var dataProvider:ClanMembersDataProvider;
    private var _header:HeaderClanCandidateList;
    private var rejectAllButton:DefaultButtonBase;
    private var incomingModel:IClanIncomingModel;

    public function ClanIncomingRequestsDialog(param1:IGameObject) {
      super();
      this.viewed = new Dictionary();
      this.incomingModel = IClanIncomingModel(param1.adapt(IClanIncomingModel));
      this.incomingModel.setClanIncomingWindow(this);
      this.inner = new WindowInner(WIDTH,HEIGHT,WindowInner.GREEN);
      window.addChild(this.inner);
      this._header = new HeaderClanCandidateList();
      this.inner.addChild(this._header);
      this.dataProvider = new ClanMembersDataProvider();
      this.dataProvider.getItemAtHandler = this.markAsViewed;
      this.list = new List();
      this.list.rowHeight = 20;
      this.list.setStyle(Styles.CELL_RENDERER,ClanIncomingListRenderer);
      this.list.focusEnabled = true;
      this.list.selectable = false;
      this.list.dataProvider = this.dataProvider;
      ScrollStyleUtils.setGreenStyle(this.list);
      this.inner.addChild(this.list);
      ScrollStyleUtils.setGreenStyle(this.list);
      this.fillData();
      this.rejectAllButton = new DefaultButtonBase();
      this.rejectAllButton.label = localeService.getText(TanksLocale.TEXT_FRIENDS_DECLINE_ALL_BUTTON);
      window.addChild(this.rejectAllButton);
      this.list.addEventListener(ClanMembersListEvent.REJECT_USER,this.onRejectUser);
      this.list.addEventListener(ClanMembersListEvent.ACCEPTED_USER,this.onAcceptedUser);
      this.rejectAllButton.addEventListener(MouseEvent.CLICK,this.onRejectAll);
      this.resize();
    }

    private function markAsViewed(param1:Object) : void {
      if(!this.isViewed(param1)) {
        this.setAsViewed(param1);
      }
    }

    public function removeAllViewed() : void {
      var local1:Object = null;
      for(local1 in this.viewed) {
        ClanNotificationsManager.removeIncomingNotification(local1.id);
      }
    }

    protected function isViewed(param1:Object) : Boolean {
      return param1 in this.viewed;
    }

    protected function setAsViewed(param1:Object) : void {
      this.viewed[param1] = true;
    }

    private function onRejectAll(param1:MouseEvent) : void {
      clanFunctionsService.rejectAllRequests();
    }

    private function onAcceptedUser(param1:ClanMembersListEvent) : void {
      clanFunctionsService.acceptRequest(param1.userId);
    }

    private function onRejectUser(param1:ClanMembersListEvent) : void {
      clanFunctionsService.rejectRequest(param1.userId);
    }

    public function resize() : void {
      this.inner.x = MARGIN;
      this.inner.y = MARGIN;
      this.inner.width = WIDTH - 2 * MARGIN;
      this.inner.height = closeButton.y - MARGIN - SMALL_MARGIN;
      this._header.x = 3;
      this._header.y = 3;
      this._header.width = this.inner.width - 6;
      this.list.x = 3;
      this.list.y = 23;
      this.list.height = this.inner.height - 24;
      var local1:Boolean = this.list.maxVerticalScrollPosition > 0;
      this.list.width = local1 ? this.inner.width + 2 : this.inner.width - 6;
      if(this.rejectAllButton != null) {
        this.rejectAllButton.x = MARGIN;
        this.rejectAllButton.y = this.height - MARGIN - this.rejectAllButton.height;
      }
    }

    public function fillData() : void {
      var local1:Long = null;
      var local2:IUserInfoLabelUpdater = null;
      var local3:Object = null;
      this.dataProvider.removeAll();
      for each(local1 in this.incomingModel.getUsers()) {
        local2 = userInfoService.getOrCreateUpdater(local1);
        local3 = {};
        local3.id = local1;
        local3.isNew = ClanNotificationsManager.userInIncomingNotifications(local1);
        local3.uid = local2.uid;
        this.dataProvider.addItem(local3);
      }
      this.sort();
      this.resize();
    }

    private function sort() : void {
      this.dataProvider.sortOn(["isNew","uid"],[Array.NUMERIC | Array.DESCENDING,Array.CASEINSENSITIVE]);
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

    override protected function onCloseClick(param1:MouseEvent) : void {
      this.removeAllViewed();
      super.onCloseClick(param1);
    }

    override public function updateActions() : void {
      if(!clanUserInfoService.hasAction(ClanAction.ADDING_TO_CLAN)) {
        destroy();
      }
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
