package alternativa.tanks.model.quest.challenge {
  import flash.events.IEventDispatcher;
  import projects.tanks.client.panel.model.challenge.rewarding.Tier;

  public interface ChallengesViewService extends IEventDispatcher {
    function changeTiersInfo(param1:Vector.<Tier>) : void;
    function getTierNumber(param1:int) : int;
  }
}
