package alternativa.tanks.gui.panel.buttons {
  import alternativa.tanks.model.quest.common.gui.QuestChangesIndicator;
  import alternativa.tanks.model.quest.common.notification.QuestNotificationEvent;
  import alternativa.tanks.model.quest.common.notification.QuestNotifierService;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class QuestsButton extends MainPanelSmallButton {
    [Inject]
    public static var questNotifierService:QuestNotifierService;

    private static const startIconClass:Class = QuestsButton_startIconClass;
    private static const starIcon:BitmapData = Bitmap(new startIconClass()).bitmapData;
    private static const INDICATOR_X_OFFSET:int = 10;
    private static const INDICATOR_Y_OFFSET:int = -4;

    private var questsChangesIndicator:QuestChangesIndicator;

    public function QuestsButton() {
      super(starIcon,3,4);
      this.questsChangesIndicator = new QuestChangesIndicator();
      questNotifierService.addEventListener(QuestNotificationEvent.SHOW_NOTIFICATION,this.onShowNotification);
      questNotifierService.addEventListener(QuestNotificationEvent.HIDE_NOTIFICATION,this.onHideNotification);
      addChild(this.questsChangesIndicator);
      this.questsChangesIndicator.x = INDICATOR_X_OFFSET;
      this.questsChangesIndicator.y = INDICATOR_Y_OFFSET;
    }

    private function onShowNotification(param1:QuestNotificationEvent) : void {
      this.questsChangesIndicator.visible = true;
    }

    private function onHideNotification(param1:QuestNotificationEvent) : void {
      if(questNotifierService.isAllChangesViewed()) {
        this.questsChangesIndicator.visible = false;
      }
    }
  }
}
