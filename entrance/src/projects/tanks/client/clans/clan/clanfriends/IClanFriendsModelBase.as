package projects.tanks.client.clans.clan.clanfriends {
  import alternativa.types.Long;

  public interface IClanFriendsModelBase {
    function onUserAdd(param1:Long) : void;
    function onUserRemove(param1:Long) : void;
    function userJoinClan(param1:Vector.<Long>) : void;
  }
}
