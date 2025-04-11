package alternativa.tanks.model.quest.weekly {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;
  import projects.tanks.client.panel.model.quest.weekly.WeeklyQuestInfo;

  public interface WeeklyQuestsService extends IEventDispatcher {
    function setTimeToNextQuest(param1:int) : void;
    function questInfoChanged(param1:Vector.<WeeklyQuestInfo>) : void;
    function takePrize(param1:Long) : void;
  }
}
