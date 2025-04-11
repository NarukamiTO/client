package alternativa.tanks.models.clan {
  import alternativa.types.Long;

  [ModelInterface]
  public interface IClanModel {
    function leaveClan() : void;
    function addClanMember(param1:Long) : void;
    function excludeClanMember(param1:Long) : void;
    function rejectRequest(param1:Long) : void;
    function acceptRequest(param1:Long) : void;
    function rejectAllRequests() : void;
    function inviteByUid(param1:String) : void;
    function revokeRequest(param1:Long) : void;
  }
}
