package services.contextmenu {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;

  public interface IContextMenuService extends IEventDispatcher {
    function show(param1:Long, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean, param11:Boolean, param12:Boolean = false, param13:Boolean = true, param14:Boolean = true) : void;
    function writeInPublic(param1:Long, param2:String) : void;
    function writeInPrivate(param1:Long, param2:String) : void;
    function removeFromFriends(param1:Long, param2:String) : void;
    function acceptRequest(param1:Long, param2:String) : void;
    function rejectRequest(param1:Long, param2:String) : void;
    function addToFriend(param1:Long) : void;
    function focusOnUser(param1:Long, param2:String) : void;
    function showClan(param1:Long) : void;
    function voteUser(param1:Long, param2:String) : void;
  }
}
