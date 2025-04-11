package alternativa.tanks.models.service {
  import alternativa.tanks.gui.clanmanagement.ClanManagementPanel;
  import alternativa.tanks.gui.notinclan.NotInClanPanel;
  import alternativa.tanks.models.panel.clanpanel.IClanPanelModel;
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  public interface ClanService extends IEventDispatcher {
    function get clanMembers() : Vector.<Long>;
    function set clanMembers(param1:Vector.<Long>) : void;
    function get name() : String;
    function set name(param1:String) : void;
    function get tag() : String;
    function set tag(param1:String) : void;
    function get creatorId() : Long;
    function set creatorId(param1:Long) : void;
    function get creationDate() : String;
    function set creationDate(param1:String) : void;
    function get clanPanelModel() : IClanPanelModel;
    function set clanPanelModel(param1:IClanPanelModel) : void;
    function updateClanInfo(param1:String, param2:int, param3:ClanFlag, param4:Boolean) : void;
    function get clanObject() : IGameObject;
    function set clanObject(param1:IGameObject) : void;
    function maxMembers() : void;
    function objectUnloaded() : void;
    function get clanManagementPanel() : ClanManagementPanel;
    function get membersCount() : int;
    function get notInClanPanel() : NotInClanPanel;
    function set notInClanPanel(param1:NotInClanPanel) : void;
    function get isSelf() : Boolean;
    function set isSelf(param1:Boolean) : void;
    function unloadMembers() : void;
    function get isBlocked() : Boolean;
    function set isBlocked(param1:Boolean) : void;
    function set minRankForCreateClan(param1:int) : void;
    function get minRankForCreateClan() : int;
    function get minRankForRequest() : int;
    function set minRankForRequest(param1:int) : void;
    function get requestsEnabled() : Boolean;
    function set requestsEnabled(param1:Boolean) : void;
    function get maxCharactersDescription() : int;
    function set maxCharactersDescription(param1:int) : void;
    function clanBlock(param1:String) : void;
  }
}
