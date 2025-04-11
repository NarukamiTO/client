package alternativa.tanks.model.quest.common.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.model.quest.common.gui.window.CommonQuestView;
  import alternativa.tanks.model.quest.common.gui.window.QuestEmptyItemView;
  import alternativa.tanks.model.quest.common.gui.window.QuestWindow;
  import alternativa.tanks.model.quest.common.gui.window.QuestsTabView;
  import alternativa.types.Long;
  import flash.display.Sprite;
  import projects.tanks.client.panel.model.quest.common.specification.QuestLevel;
  import projects.tanks.client.panel.model.quest.showing.QuestInfoWithLevel;

  public class CommonQuestTab extends QuestsTabView {
    [Inject]
    public static var localeService:ILocaleService;

    public static const QUEST_VIEW_WIDTH:int = 280;
    public static const QUEST_PANEL_HEIGHT:int = 300;
    public static const BUTTON_HEIGHT:int = 50;

    protected var itemViews:Vector.<CommonQuestView>;

    private var stubs:Vector.<QuestEmptyItemView>;

    protected var timeToNextQuestInSeconds:int;

    public function CommonQuestTab() {
      super();
      this.itemViews = new Vector.<CommonQuestView>();
      this.stubs = new Vector.<QuestEmptyItemView>();
    }

    public function setTimeToNextQuest(param1:int) : void {
      this.timeToNextQuestInSeconds = param1;
    }

    public function initViews(param1:Vector.<QuestInfoWithLevel>) : void {
      var local2:QuestLevel = null;
      var local3:QuestInfoWithLevel = null;
      this.clearQuestViews();
      for each(local2 in QuestLevel.values) {
        local3 = this.findQuestBy(local2,param1);
        if(local3 != null) {
          this.addQuestItemView(local3);
        } else {
          this.addQuestStub(local2.value);
        }
      }
    }

    protected function clearQuestViews() : void {
      var local1:CommonQuestView = null;
      var local2:QuestEmptyItemView = null;
      for each(local1 in this.itemViews) {
        this.destroyQuestView(local1);
      }
      this.itemViews.splice(0,this.itemViews.length);
      for each(local2 in this.stubs) {
        if(this.contains(local2)) {
          removeChild(local2);
        }
        local2.destroy();
      }
      this.stubs.slice(0,this.stubs.length);
    }

    protected function destroyQuestView(param1:CommonQuestView) : void {
      removeChild(param1);
      param1.destroy();
    }

    private function findQuestBy(param1:QuestLevel, param2:Vector.<QuestInfoWithLevel>) : QuestInfoWithLevel {
      var local3:QuestInfoWithLevel = null;
      for each(local3 in param2) {
        if(local3.level == param1) {
          return local3;
        }
      }
      return null;
    }

    protected function addQuestItemView(param1:QuestInfoWithLevel) : void {
      var local2:int = param1.level.value;
      var local3:CommonQuestView = this.createQuestView(param1);
      this.alignQuestView(local3,local2);
      this.itemViews.push(local3);
      addChild(local3);
    }

    protected function createQuestView(param1:QuestInfoWithLevel) : CommonQuestView {
      return null;
    }

    private function alignQuestView(param1:Sprite, param2:int) : void {
      param1.x = (QUEST_VIEW_WIDTH + QuestWindow.INNER_MARGIN - 2) * param2;
      param1.y = 0;
    }

    protected function addQuestStub(param1:int) : void {
      var local2:QuestEmptyItemView = new QuestEmptyItemView(QUEST_VIEW_WIDTH,QUEST_PANEL_HEIGHT + QuestWindow.INNER_MARGIN + BUTTON_HEIGHT,this.getTextForStubView(),this.timeToNextQuestInSeconds);
      this.alignQuestView(local2,param1);
      this.stubs.push(local2);
      addChild(local2);
    }

    protected function getTextForStubView() : String {
      return null;
    }

    public function takePrize(param1:Long) : void {
      var local3:CommonQuestView = null;
      var local2:int = 0;
      while(local2 < this.itemViews.length) {
        local3 = this.itemViews[local2];
        if(local3.getQuestId() == param1) {
          this.itemViews.splice(local2,1);
          this.destroyQuestView(local3);
          this.addQuestStub(local3.getQuestLevel().value);
          break;
        }
        local2++;
      }
    }

    override public function close() : void {
      this.clearQuestViews();
    }
  }
}
