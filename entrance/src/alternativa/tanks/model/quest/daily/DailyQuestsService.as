package alternativa.tanks.model.quest.daily {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;
  import projects.tanks.client.panel.model.quest.daily.DailyQuestInfo;

  public interface DailyQuestsService extends IEventDispatcher {
    function setTimeToNextQuest(param1:int) : void;
    function questInfoChanged(param1:Vector.<DailyQuestInfo>) : void;
    function changeSkippedQuest(param1:Long, param2:DailyQuestInfo) : void;
    function takePrize(param1:Long) : void;
  }
}
