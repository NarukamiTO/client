package alternativa.tanks.model.quest.challenge.stars {
  import flash.events.IEventDispatcher;

  public interface StarsInfoService extends IEventDispatcher {
    function setStars(param1:int) : void;
    function getStars() : int;
  }
}
