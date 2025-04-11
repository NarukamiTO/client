package alternativa.tanks.model.quest.weekly.gui {
  import alternativa.tanks.model.quest.common.gui.window.CommonQuestView;
  import controls.base.ThreeLineBigButton;
  import projects.tanks.client.panel.model.quest.QuestTypeEnum;
  import projects.tanks.client.panel.model.quest.weekly.WeeklyQuestInfo;

  public class WeeklyQuestView extends CommonQuestView {
    public function WeeklyQuestView(param1:WeeklyQuestInfo) {
      super(param1);
    }

    override protected function createActionButton() : ThreeLineBigButton {
      var local1:ThreeLineBigButton = super.createActionButton();
      local1.enabled = questInfo.progress >= questInfo.finishCriteria;
      return local1;
    }

    override public function getQuestType() : QuestTypeEnum {
      return QuestTypeEnum.WEEKLY;
    }
  }
}
