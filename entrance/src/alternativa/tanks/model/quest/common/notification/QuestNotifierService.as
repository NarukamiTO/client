package alternativa.tanks.model.quest.common.notification {
  import flash.events.IEventDispatcher;
  import projects.tanks.client.panel.model.quest.QuestTypeEnum;

  public interface QuestNotifierService extends IEventDispatcher {
    function hasChange(param1:QuestTypeEnum) : Boolean;
    function showChanges(param1:QuestTypeEnum) : void;
    function changesViewed(param1:QuestTypeEnum) : void;
    function isAllChangesViewed() : Boolean;
  }
}
