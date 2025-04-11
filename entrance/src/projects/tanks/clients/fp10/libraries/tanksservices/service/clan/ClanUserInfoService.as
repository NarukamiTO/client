package projects.tanks.clients.fp10.libraries.tanksservices.service.clan {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;
  import projects.tanks.client.clans.clan.permissions.ClanAction;

  public interface ClanUserInfoService extends IEventDispatcher {
    function updateUserClanInfo(param1:UserClanInfo) : void;
    function userClanInfoByUserId(param1:Long) : UserClanInfo;
    function get updateFriendsClanButtonFunction() : Function;
    function set updateFriendsClanButtonFunction(param1:Function) : void;
    function hasAction(param1:ClanAction) : Boolean;
    function get actions() : Vector.<ClanAction>;
    function set actions(param1:Vector.<ClanAction>) : void;
    function get restrictionTime() : int;
    function set restrictionTime(param1:int) : void;
    function inSameClan(param1:Long) : Boolean;
    function get selfClan() : Boolean;
    function set selfClan(param1:Boolean) : void;
    function get clanMember() : Boolean;
    function set clanMember(param1:Boolean) : void;
    function get giveBonusesClan() : Boolean;
    function set giveBonusesClan(param1:Boolean) : void;
    function onLeaveClan() : void;
    function onJoinClan() : void;
  }
}
