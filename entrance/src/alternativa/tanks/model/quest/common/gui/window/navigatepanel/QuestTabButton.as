package alternativa.tanks.model.quest.common.gui.window.navigatepanel {
  import alternativa.tanks.model.quest.common.gui.QuestChangesIndicator;
  import alternativa.tanks.model.quest.common.notification.QuestNotificationEvent;
  import alternativa.tanks.model.quest.common.notification.QuestNotifierService;
  import controls.buttons.CategoryButtonSkin;
  import controls.buttons.FixedHeightButton;
  import controls.buttons.h30px.H30ButtonSkin;
  import projects.tanks.client.panel.model.quest.QuestTypeEnum;

  public class QuestTabButton extends FixedHeightButton {
    [Inject]
    public static var questNotifierService:QuestNotifierService;

    private static const INDICATOR_X_OFFSET:int = -16;
    private static const INDICATOR_Y_OFFSET:int = -4;

    private var questType:QuestTypeEnum;
    private var indicator:QuestChangesIndicator;

    public function QuestTabButton(param1:QuestTypeEnum, param2:String) {
      super(new CategoryButtonSkin());
      this.questType = param1;
      labelSize = H30ButtonSkin.DEFAULT_LABEL_SIZE;
      labelHeight = H30ButtonSkin.DEFAULT_LABEL_HEIGHT;
      labelPositionY = H30ButtonSkin.DEFAULT_LABEL_Y;
      this.label = param2;
      buttonMode = true;
      useHandCursor = true;
      this.indicator = new QuestChangesIndicator();
      questNotifierService.addEventListener(QuestNotificationEvent.SHOW_NOTIFICATION,this.onShowNotification);
      questNotifierService.addEventListener(QuestNotificationEvent.HIDE_NOTIFICATION,this.onHideNotification);
      addChild(this.indicator);
      this.indicator.visible = questNotifierService.hasChange(param1);
      this.indicator.x = width + INDICATOR_X_OFFSET;
      this.indicator.y = INDICATOR_Y_OFFSET;
    }

    public function getQuestType() : QuestTypeEnum {
      return this.questType;
    }

    private function onShowNotification(param1:QuestNotificationEvent) : void {
      if(param1.questType == this.questType) {
        this.indicator.visible = true;
      }
    }

    private function onHideNotification(param1:QuestNotificationEvent) : void {
      if(param1.questType == this.questType) {
        this.indicator.visible = false;
      }
    }
  }
}
