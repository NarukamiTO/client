package alternativa.tanks.models.service {
  import alternativa.tanks.gui.clanmanagement.ClanManagementPanel;
  import alternativa.tanks.gui.notinclan.NotInClanPanel;
  import alternativa.tanks.models.panel.clanpanel.IClanPanelModel;
  import alternativa.tanks.service.panel.IPanelView;
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
  import platform.client.fp10.core.network.handler.OnConnectionClosedServiceListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  public class ClanServiceImpl extends EventDispatcher implements ClanService, OnConnectionClosedServiceListener {
    [Inject]
    public static var panelView:IPanelView;

    private var _clanMembers:Vector.<Long>;
    private var _name:String;
    private var _tag:String;
    private var _creationDate:String;
    private var _creatorId:Long;
    private var _clanPanelModel:IClanPanelModel;
    private var _clanObject:IGameObject;
    private var _isSelf:Boolean;
    private var _isBlocked:Boolean;
    private var _notInClanPanel:NotInClanPanel;
    private var _clanManagementPanel:ClanManagementPanel;
    private var _minRankForCreateClan:int;
    private var _minRankForRequest:int;
    private var _requestsEnabled:Boolean;
    private var _maxCharactersDescription:int;

    public function ClanServiceImpl() {
      super();
    }

    public function onConnectionClosed(param1:ConnectionCloseStatus) : void {
      this.clanMembers = new Vector.<Long>();
    }

    public function unloadMembers() : void {
      this.clanMembers = new Vector.<Long>();
    }

    public function get clanMembers() : Vector.<Long> {
      return this._clanMembers;
    }

    public function set clanMembers(param1:Vector.<Long>) : void {
      this._clanMembers = param1;
    }

    public function get name() : String {
      return this._name;
    }

    public function set name(param1:String) : void {
      this._name = param1;
    }

    public function get tag() : String {
      return this._tag;
    }

    public function set tag(param1:String) : void {
      this._tag = param1;
    }

    public function updateClanInfo(param1:String, param2:int, param3:ClanFlag, param4:Boolean) : void {
      dispatchEvent(new ClanServiceUpdateEvent(ClanServiceUpdateEvent.UPDATE,param1,param2,param3,param4));
    }

    public function get clanObject() : IGameObject {
      return this._clanObject;
    }

    public function set clanObject(param1:IGameObject) : void {
      this._clanObject = param1;
      this._clanManagementPanel = new ClanManagementPanel(this._clanObject);
    }

    public function objectUnloaded() : void {
      this._clanObject = null;
      this._clanManagementPanel.destroy();
    }

    public function maxMembers() : void {
      this._clanManagementPanel.maxMembers();
    }

    public function get clanManagementPanel() : ClanManagementPanel {
      return this._clanManagementPanel;
    }

    public function get creatorId() : Long {
      return this._creatorId;
    }

    public function set creatorId(param1:Long) : void {
      this._creatorId = param1;
    }

    public function get creationDate() : String {
      return this._creationDate;
    }

    public function set creationDate(param1:String) : void {
      this._creationDate = param1;
    }

    public function get isSelf() : Boolean {
      return this._isSelf;
    }

    public function set isSelf(param1:Boolean) : void {
      this._isSelf = param1;
    }

    public function get membersCount() : int {
      return this.clanMembers.length;
    }

    public function get isBlocked() : Boolean {
      return this._isBlocked;
    }

    public function set isBlocked(param1:Boolean) : void {
      this._isBlocked = param1;
    }

    public function clanBlock(param1:String) : void {
      this._isBlocked = true;
      dispatchEvent(new ClanServiceEvent(ClanServiceEvent.CLAN_BLOCK,param1));
    }

    public function set minRankForCreateClan(param1:int) : void {
      this._minRankForCreateClan = param1;
    }

    public function get minRankForCreateClan() : int {
      return this._minRankForCreateClan;
    }

    public function get notInClanPanel() : NotInClanPanel {
      return this._notInClanPanel;
    }

    public function set notInClanPanel(param1:NotInClanPanel) : void {
      this._notInClanPanel = param1;
    }

    public function get clanPanelModel() : IClanPanelModel {
      return this._clanPanelModel;
    }

    public function set clanPanelModel(param1:IClanPanelModel) : void {
      this._clanPanelModel = param1;
    }

    public function get minRankForRequest() : int {
      return this._minRankForRequest;
    }

    public function set minRankForRequest(param1:int) : void {
      this._minRankForRequest = param1;
    }

    public function get requestsEnabled() : Boolean {
      return this._requestsEnabled;
    }

    public function set requestsEnabled(param1:Boolean) : void {
      this._requestsEnabled = param1;
    }

    public function get maxCharactersDescription() : int {
      return this._maxCharactersDescription;
    }

    public function set maxCharactersDescription(param1:int) : void {
      this._maxCharactersDescription = param1;
    }
  }
}
