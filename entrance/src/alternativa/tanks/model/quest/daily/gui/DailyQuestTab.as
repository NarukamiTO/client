package alternativa.tanks.model.quest.daily.gui {
  import alternativa.tanks.model.quest.common.gui.CommonQuestTab;
  import alternativa.tanks.model.quest.common.gui.window.*;
  import alternativa.tanks.model.quest.common.notification.QuestNotifierService;
  import alternativa.tanks.model.quest.daily.DailyQuestChangeEvent;
  import alternativa.tanks.model.quest.daily.DailyQuestEvent;
  import alternativa.tanks.model.quest.daily.DailyQuestsService;
  import alternativa.tanks.service.money.IMoneyService;
  import alternativa.types.Long;
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerOnCompleteAfter;
  import flash.utils.getTimer;
  import projects.tanks.client.panel.model.quest.QuestTypeEnum;
  import projects.tanks.client.panel.model.quest.daily.DailyQuestInfo;
  import projects.tanks.client.panel.model.quest.showing.QuestInfoWithLevel;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class DailyQuestTab extends CommonQuestTab implements CountDownTimerOnCompleteAfter, DailyQuestsService {
    [Inject]
    public static var moneyService:IMoneyService;

    [Inject]
    public static var questNotifierService:QuestNotifierService;

    private const CHANGE_DELAY_IN_MILLISECONDS:int = 1000;

    private var changeButtonDelayTimer:CountDownTimer;
    private var changedQuestLoaded:Boolean;
    private var changeButtonDelayTimerIsRunning:Boolean;

    public function DailyQuestTab() {
      super();
    }

    override protected function destroyQuestView(param1:CommonQuestView) : void {
      param1.removeEventListener(DailyQuestChangeEvent.DAILY_QUEST_CHANGE,this.onDailyQuestChange);
      super.destroyQuestView(param1);
    }

    override protected function createQuestView(param1:QuestInfoWithLevel) : CommonQuestView {
      var local2:DailyQuestItemView = new DailyQuestItemView(DailyQuestInfo(param1));
      local2.addEventListener(DailyQuestChangeEvent.DAILY_QUEST_CHANGE,this.onDailyQuestChange);
      return local2;
    }

    private function onDailyQuestChange(param1:DailyQuestChangeEvent) : void {
      if(param1.dailyQuestInfo.canSkipForFree || Boolean(moneyService.checkEnough(param1.dailyQuestInfo.skipCost))) {
        this.changedQuestLoaded = false;
        this.lockChangeButtonsForTime();
      } else {
        this.removeChangeButtonDelayTimer();
      }
    }

    private function lockChangeButtonsForTime() : void {
      this.lockChangeButtons();
      this.createAndStartChangeButtonDelayTimer();
    }

    private function createAndStartChangeButtonDelayTimer() : void {
      this.changeButtonDelayTimer = new CountDownTimer();
      this.changeButtonDelayTimer.addListener(CountDownTimerOnCompleteAfter,this);
      this.changeButtonDelayTimer.start(getTimer() + this.CHANGE_DELAY_IN_MILLISECONDS);
      this.changeButtonDelayTimerIsRunning = true;
    }

    private function lockChangeButtons() : void {
      var local1:DailyQuestItemView = null;
      for each(local1 in itemViews) {
        if(local1.actionButtonIsChangeButton()) {
          local1.lockActionButton();
        }
      }
    }

    public function changeSkippedQuest(param1:Long, param2:DailyQuestInfo) : void {
      var local3:DailyQuestItemView = null;
      for each(local3 in itemViews) {
        if(local3.getQuestId() == param1) {
          local3.updateItemViewWhenQuestChanged(param2);
        }
        if(local3.actionButtonIsChangeButton()) {
          local3.updateChangeCost(param2.skipCost);
        }
      }
      this.changedQuestLoaded = true;
      if(!this.changeButtonDelayTimerIsRunning) {
        this.unlockChangeButtons();
      }
    }

    public function onCompleteAfter(param1:CountDownTimer, param2:Boolean) : void {
      this.removeChangeButtonDelayTimer();
      if(this.changedQuestLoaded) {
        this.unlockChangeButtons();
      }
    }

    private function removeChangeButtonDelayTimer() : void {
      if(this.changeButtonDelayTimer != null) {
        this.changeButtonDelayTimer.removeListener(CountDownTimerOnCompleteAfter,this);
        this.changeButtonDelayTimer.destroy();
        this.changeButtonDelayTimerIsRunning = false;
      }
    }

    private function unlockChangeButtons() : void {
      var local1:DailyQuestItemView = null;
      for each(local1 in itemViews) {
        if(local1.actionButtonIsChangeButton()) {
          local1.unlockActionButton();
        }
      }
    }

    override public function show() : void {
      super.show();
      dispatchEvent(new DailyQuestEvent(DailyQuestEvent.REQUEST_DATA));
      questNotifierService.changesViewed(QuestTypeEnum.DAILY);
    }

    override protected function getTextForStubView() : String {
      return localeService.getText(TanksLocale.TEXT_DAILY_QUEST_COMPLETED);
    }

    public function questInfoChanged(param1:Vector.<DailyQuestInfo>) : void {
      var local3:DailyQuestInfo = null;
      var local2:Vector.<QuestInfoWithLevel> = new Vector.<QuestInfoWithLevel>();
      for each(local3 in param1) {
        local2.push(local3);
      }
      initViews(local2);
    }
  }
}
