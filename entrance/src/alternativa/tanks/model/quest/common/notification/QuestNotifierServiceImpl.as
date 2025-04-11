package alternativa.tanks.model.quest.common.notification {
  import flash.events.EventDispatcher;
  import flash.utils.Dictionary;
  import projects.tanks.client.panel.model.quest.QuestTypeEnum;

  public class QuestNotifierServiceImpl extends EventDispatcher implements QuestNotifierService {
    private var changes:Dictionary;

    public function QuestNotifierServiceImpl() {
      var local1:QuestTypeEnum = null;
      this.changes = new Dictionary();
      super();
      for each(local1 in QuestTypeEnum.values) {
        this.changes[local1] = false;
      }
    }

    public function hasChange(param1:QuestTypeEnum) : Boolean {
      return this.changes[param1];
    }

    public function showChanges(param1:QuestTypeEnum) : void {
      this.changes[param1] = true;
      this.showNotification(param1);
    }

    public function changesViewed(param1:QuestTypeEnum) : void {
      this.changes[param1] = false;
      this.hideNotification(param1);
    }

    public function isAllChangesViewed() : Boolean {
      var local1:Boolean = false;
      for each(local1 in this.changes) {
        if(local1) {
          return false;
        }
      }
      return true;
    }

    private function showNotification(param1:QuestTypeEnum) : void {
      dispatchEvent(new QuestNotificationEvent(QuestNotificationEvent.SHOW_NOTIFICATION,param1));
    }

    private function hideNotification(param1:QuestTypeEnum = null) : void {
      dispatchEvent(new QuestNotificationEvent(QuestNotificationEvent.HIDE_NOTIFICATION,param1));
    }
  }
}
