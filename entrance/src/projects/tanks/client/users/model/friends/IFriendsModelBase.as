package projects.tanks.client.users.model.friends {
  import alternativa.types.Long;

  public interface IFriendsModelBase {
    function acceptSuccess(param1:Long) : void;
    function acceptedLimitExceeded(param1:String) : void;
    function alreadyInAcceptedFriends(param1:String) : void;
    function alreadyInIncomingFriends(param1:String, param2:Long) : void;
    function alreadyInOutgoingFriends(param1:String) : void;
    function incomingLimitExceeded() : void;
    function yourAcceptedLimitExceeded() : void;
  }
}
