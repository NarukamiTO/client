package alternativa.tanks.model.quest.common.gui.window.events {
  import flash.events.Event;

  public class QuestWindowCloseEvent extends Event {
    public static const QUEST_WINDOW_CLOSE:String = "QuestWindowClose";

    public function QuestWindowCloseEvent(param1:String) {
      super(param1,true);
    }
  }
}
