package alternativa.tanks.model.item.temporary {
  [ModelInterface]
  public interface ITemporaryItem {
    function getStopDate() : Date;
    function startTiming(param1:int) : void;
    function setRemainingTime(param1:int) : void;
    function getTimeRemainingInMSec() : Number;
    function getLifeTimeInSec() : int;
    function isInfinityLifeTimeItem() : Boolean;
    function markAsInfinityLifeTimeItem() : void;
  }
}
