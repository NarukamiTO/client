package alternativa.tanks.model.quest.common.gui.window.navigatepanel {
  import flash.events.Event;
  import projects.tanks.client.panel.model.quest.QuestTypeEnum;

  public class SelectTabEvent extends Event {
    public static var SELECT_QUESTS_TAB:String = "QUESTS_WINDOW_SELECT_TAB_EVENT";

    public var selectedType:QuestTypeEnum;

    public function SelectTabEvent(param1:QuestTypeEnum) {
      super(SELECT_QUESTS_TAB);
      this.selectedType = param1;
    }
  }
}
