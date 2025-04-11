package alternativa.tanks.model.quest.common.notification {
  import flash.events.Event;
  import projects.tanks.client.panel.model.quest.QuestTypeEnum;

  public class QuestNotificationEvent extends Event {
    public static const SHOW_NOTIFICATION:String = "showNotification";
    public static const HIDE_NOTIFICATION:String = "hideNotification";

    public var questType:QuestTypeEnum;

    public function QuestNotificationEvent(param1:String, param2:QuestTypeEnum = null) {
      super(param1,true);
      this.questType = param2;
    }
  }
}
