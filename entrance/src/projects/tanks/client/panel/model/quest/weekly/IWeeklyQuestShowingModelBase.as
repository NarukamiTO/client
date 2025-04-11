package projects.tanks.client.panel.model.quest.weekly {
  import alternativa.types.Long;

  public interface IWeeklyQuestShowingModelBase {
    function openWeeklyQuest(param1:Vector.<WeeklyQuestInfo>) : void;
    function prizeGiven(param1:Long) : void;
  }
}
