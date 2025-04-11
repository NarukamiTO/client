package projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;

  public interface IUserPropertiesService extends IEventDispatcher {
    function isInited() : Boolean;
    function get userId() : Long;
    function get userName() : String;
    function set userName(param1:String) : void;
    function get score() : int;
    function get rank() : int;
    function get fullRank() : int;
    function getUserProfileUrl(param1:String) : String;
    function get registrationTimestamp() : int;
    function init(param1:Long, param2:String, param3:int, param4:int, param5:String, param6:int, param7:Boolean, param8:Boolean) : void;
    function initRank(param1:int) : void;
    function updateRank(param1:int) : void;
    function updateCanUseGroup(param1:Boolean) : void;
    function updateScore(param1:int) : void;
    function hasSpectatorPermissions() : Boolean;
    function isQuestsAvailableByRank() : Boolean;
    function canUseGroup() : Boolean;
  }
}
