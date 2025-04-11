package alternativa.tanks.model.quest.daily.gui {
  import alternativa.tanks.model.quest.common.gui.window.CommonQuestView;
  import alternativa.tanks.model.quest.common.gui.window.buttons.DailyQuestChangeButton;
  import alternativa.tanks.model.quest.daily.DailyQuestChangeEvent;
  import alternativa.tanks.service.money.IMoneyService;
  import controls.base.ThreeLineBigButton;
  import flash.events.MouseEvent;
  import projects.tanks.client.panel.model.quest.QuestTypeEnum;
  import projects.tanks.client.panel.model.quest.daily.DailyQuestInfo;

  public class DailyQuestItemView extends CommonQuestView {
    [Inject]
    public static var moneyService:IMoneyService;

    public function DailyQuestItemView(param1:DailyQuestInfo) {
      super(param1);
    }

    private function dailyInfo() : DailyQuestInfo {
      return DailyQuestInfo(questInfo);
    }

    override protected function createActionButton() : ThreeLineBigButton {
      if(questInfo.progress >= questInfo.finishCriteria) {
        return createGetPrizeButton();
      }
      return this.createChangeButton();
    }

    private function createChangeButton() : ThreeLineBigButton {
      var local1:DailyQuestChangeButton = new DailyQuestChangeButton();
      local1.addEventListener(MouseEvent.CLICK,this.onChangeButtonClick,false,0,true);
      if(this.dailyInfo().canSkipForFree) {
        local1.showButtonWithoutCrystals();
      } else {
        local1.showButtonWithCrystals(this.dailyInfo().skipCost);
      }
      return ThreeLineBigButton(local1);
    }

    private function onChangeButtonClick(param1:MouseEvent) : void {
      if(this.dailyInfo().canSkipForFree || Boolean(moneyService.checkEnough(this.dailyInfo().skipCost))) {
        dispatchEvent(new DailyQuestChangeEvent(DailyQuestChangeEvent.DAILY_QUEST_CHANGE,this.dailyInfo()));
      }
    }

    public function updateItemViewWhenQuestChanged(param1:DailyQuestInfo) : void {
      this.questInfo = param1;
      questImage.bitmapData = param1.image.data;
      questInfoPanel.updatePanel(param1);
    }

    public function updateChangeCost(param1:int) : void {
      this.dailyInfo().canSkipForFree = false;
      this.dailyInfo().skipCost = param1;
      DailyQuestChangeButton(actionButton).showButtonWithCrystals(param1);
    }

    public function actionButtonIsChangeButton() : Boolean {
      return actionButton is DailyQuestChangeButton;
    }

    public function lockActionButton() : void {
      actionButton.enabled = false;
    }

    public function unlockActionButton() : void {
      actionButton.enabled = true;
    }

    override public function destroy() : void {
      super.destroy();
      if(actionButton is DailyQuestChangeButton) {
        if(actionButton.hasEventListener(MouseEvent.CLICK)) {
          actionButton.removeEventListener(MouseEvent.CLICK,this.onChangeButtonClick);
        }
        (actionButton as DailyQuestChangeButton).removeListeners();
      }
    }

    override public function getQuestType() : QuestTypeEnum {
      return QuestTypeEnum.DAILY;
    }
  }
}
