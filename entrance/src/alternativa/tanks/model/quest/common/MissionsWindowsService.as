package alternativa.tanks.model.quest.common {
  import flash.events.IEventDispatcher;
  import projects.tanks.client.panel.model.quest.QuestTypeEnum;

  public interface MissionsWindowsService extends IEventDispatcher {
    function initWindow() : void;
    function openInTab(param1:QuestTypeEnum) : void;
    function isWindowOpen() : Boolean;
    function closeWindow() : void;
  }
}
