package alternativa.tanks.models.panel.create {
  import flash.events.IEventDispatcher;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  public interface ClanCreateService extends IEventDispatcher {
    function createClan(param1:String, param2:String, param3:String, param4:ClanFlag) : void;
    function validateName(param1:String) : void;
    function validateTag(param1:String) : void;
    function incorrectName() : void;
    function incorrectTag() : void;
    function correctName() : void;
    function correctTag() : void;
    function notUniqueName() : void;
    function notUniqueTag() : void;
    function get flags() : Vector.<ClanFlag>;
    function set flags(param1:Vector.<ClanFlag>) : void;
    function get defaultFlag() : ClanFlag;
    function otherError() : void;
    function alreadyInClan() : void;
  }
}
