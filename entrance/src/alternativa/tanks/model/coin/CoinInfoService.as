package alternativa.tanks.model.coin {
  import flash.events.IEventDispatcher;

  public interface CoinInfoService extends IEventDispatcher {
    function setCoins(param1:int) : void;
    function getCoins() : int;
    function get enabled() : Boolean;
    function set enabled(param1:Boolean) : void;
    function changeBy(param1:int) : void;
  }
}
