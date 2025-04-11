package alternativa.tanks.service.clan {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;

  public interface ClanFriendsService extends IEventDispatcher {
    function get clanMembers() : Vector.<Long>;
    function set clanMembers(param1:Vector.<Long>) : void;
  }
}
