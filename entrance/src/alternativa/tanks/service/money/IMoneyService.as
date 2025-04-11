package alternativa.tanks.service.money {
  public interface IMoneyService {
    function addListener(param1:IMoneyListener) : void;
    function removeListener(param1:IMoneyListener) : void;
    function get crystal() : int;
    function init(param1:int) : void;
    function setServerCrystals(param1:int) : void;
    function changeCrystals(param1:int) : void;
    function checkEnough(param1:int) : Boolean;
    function spend(param1:int) : void;
  }
}
