package projects.tanks.clients.fp10.libraries.tanksservices.service.friend {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;

  public interface IFriendActionService extends IEventDispatcher {
    function add(param1:Long) : void;
    function addByUid(param1:String) : void;
    function accept(param1:Long) : void;
    function breakItOff(param1:Long) : void;
    function reject(param1:Long) : void;
    function rejectAllIncoming() : void;
    function alreadyInIncomingFriends(param1:String, param2:Long) : void;
    function alreadyInAcceptedFriends(param1:String) : void;
    function alreadyInOutgoingFriends(param1:String) : void;
    function incomingLimitExceeded() : void;
    function acceptedLimitExceeded(param1:String) : void;
    function requestAccepted(param1:Long) : void;
    function yourAcceptedLimitExceeded() : void;
  }
}
