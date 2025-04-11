package alternativa.tanks.model.quest.weekly.gui {
  import alternativa.tanks.model.quest.common.gui.CommonQuestTab;
  import alternativa.tanks.model.quest.common.gui.window.CommonQuestView;
  import alternativa.tanks.model.quest.common.notification.QuestNotifierService;
  import alternativa.tanks.model.quest.weekly.WeeklyQuestEvent;
  import alternativa.tanks.model.quest.weekly.WeeklyQuestsService;
  import projects.tanks.client.panel.model.quest.QuestTypeEnum;
  import projects.tanks.client.panel.model.quest.showing.QuestInfoWithLevel;
  import projects.tanks.client.panel.model.quest.weekly.WeeklyQuestInfo;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class WeeklyQuestTab extends CommonQuestTab implements WeeklyQuestsService {
    [Inject]
    public static var questNotifierService:QuestNotifierService;

    public function WeeklyQuestTab() {
      super();
    }

    override protected function createQuestView(param1:QuestInfoWithLevel) : CommonQuestView {
      return new WeeklyQuestView(WeeklyQuestInfo(param1));
    }

    override public function show() : void {
      super.show();
      dispatchEvent(new WeeklyQuestEvent(WeeklyQuestEvent.REQUEST_DATA));
      questNotifierService.changesViewed(QuestTypeEnum.WEEKLY);
    }

    override protected function getTextForStubView() : String {
      return localeService.getText(TanksLocale.TEXT_WEEKLY_QUEST_COMPLETED);
    }

    public function questInfoChanged(param1:Vector.<WeeklyQuestInfo>) : void {
      var local3:WeeklyQuestInfo = null;
      var local2:Vector.<QuestInfoWithLevel> = new Vector.<QuestInfoWithLevel>();
      for each(local3 in param1) {
        local2.push(local3);
      }
      initViews(local2);
    }
  }
}
