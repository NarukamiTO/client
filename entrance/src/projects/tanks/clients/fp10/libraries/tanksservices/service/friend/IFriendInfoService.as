package projects.tanks.clients.fp10.libraries.tanksservices.service.friend {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;

  public interface IFriendInfoService extends IEventDispatcher {
    function setFriendState(param1:Long, param2:FriendState) : void;
    function isFriendsInState(param1:Long, param2:FriendState) : Boolean;
    function isNewFriend(param1:Long) : Boolean;
    function getFriendsIdByState(param1:FriendState) : Vector.<Long>;
    function deleteFriend(param1:Long, param2:FriendState) : void;
    function getOrCreateUpdater(param1:Long) : IFriendsInfoLabelUpdater;
    function get acceptedFriendsLength() : int;
    function get incomingFriendsLength() : int;
    function onAddNewAcceptedFriend(param1:Long) : void;
    function onRemoveNewAcceptedFriend(param1:Long) : void;
    function removeNewAcceptedFriend(param1:Long) : void;
    function isNewAcceptedFriend(param1:Long) : Boolean;
    function get newAcceptedFriendsLength() : int;
    function onAddNewIncomingFriend(param1:Long) : void;
    function onRemoveNewIncomingFriend(param1:Long) : void;
    function removeNewIncomingFriend(param1:Long) : void;
    function isNewIncomingFriend(param1:Long) : Boolean;
    function get newIncomingFriendsLength() : int;
  }
}
