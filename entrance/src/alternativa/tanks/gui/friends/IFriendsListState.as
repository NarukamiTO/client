package alternativa.tanks.gui.friends {
  public interface IFriendsListState {
    function initList() : void;
    function hide() : void;
    function filter(param1:String, param2:String) : void;
    function resetFilter() : void;
    function resize(param1:Number, param2:Number) : void;
  }
}
