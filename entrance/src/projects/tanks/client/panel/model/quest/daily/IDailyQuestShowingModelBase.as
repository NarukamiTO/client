package projects.tanks.client.panel.model.quest.daily {
  import alternativa.types.Long;

  public interface IDailyQuestShowingModelBase {
    function openDailyQuest(param1:Vector.<DailyQuestInfo>) : void;
    function prizeGiven(param1:Long) : void;
    function skipQuest(param1:Long, param2:DailyQuestInfo) : void;
  }
}
