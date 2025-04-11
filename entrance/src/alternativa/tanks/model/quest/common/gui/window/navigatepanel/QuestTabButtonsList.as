package alternativa.tanks.model.quest.common.gui.window.navigatepanel {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.model.quest.common.gui.window.*;
  import base.DiscreteSprite;
  import controls.buttons.CategoryButtonSkin;
  import flash.events.MouseEvent;
  import flash.utils.Dictionary;
  import projects.tanks.client.panel.model.quest.QuestTypeEnum;
  import projects.tanks.clients.flash.commons.models.challenge.ChallengeInfoService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class QuestTabButtonsList extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var starsEventService:ChallengeInfoService;
    public static var BUTTON_HEIGHT:int = 30;

    private static var BUTTON_WIDTH:int = 120;

    private var questCategoryToButton:Dictionary = new Dictionary();
    private var tabButtons:Vector.<QuestTabButton> = new Vector.<QuestTabButton>();
    private var currentQuestType:QuestTypeEnum;
    private var panelWidth:int = 0;

    public function QuestTabButtonsList() {
      super();
    }

    public function addCategoryButton(param1:QuestTypeEnum) : void {
      var local2:QuestTabButton = null;
      switch(param1) {
        case QuestTypeEnum.MAIN:
          local2 = this.createCategoryButton(QuestTypeEnum.MAIN,localeService.getText(TanksLocale.TEXT_MAIN_QUEST_BUTTON));
          local2.setSkin(CategoryButtonSkin.createDisableButtonSkin());
          local2.enabled = false;
          this.addToPanel(local2);
          break;
        case QuestTypeEnum.DAILY:
          this.addToPanel(this.createCategoryButton(QuestTypeEnum.DAILY,localeService.getText(TanksLocale.TEXT_DAILY_QUEST_BUTTON)));
          break;
        case QuestTypeEnum.WEEKLY:
          this.addToPanel(this.createCategoryButton(QuestTypeEnum.WEEKLY,localeService.getText(TanksLocale.TEXT_WEEKLY_QUEST_BUTTON)));
          break;
        case QuestTypeEnum.CHALLENGE:
          local2 = this.createCategoryButton(QuestTypeEnum.CHALLENGE,localeService.getText(TanksLocale.TEXT_CHALLENGE_QUEST_BUTTON));
          if(!starsEventService.isInTime()) {
            local2.setSkin(CategoryButtonSkin.createDisableButtonSkin());
            local2.enabled = false;
          }
          this.addToPanel(local2);
      }
    }

    private function addToPanel(param1:QuestTabButton) : void {
      var local2:int = this.panelWidth == 0 ? 0 : QuestWindow.INNER_MARGIN;
      param1.x = this.panelWidth + local2;
      this.panelWidth += BUTTON_WIDTH + local2;
      addChild(param1);
    }

    private function createCategoryButton(param1:QuestTypeEnum, param2:String) : QuestTabButton {
      var local3:QuestTabButton = new QuestTabButton(param1,param2);
      this.questCategoryToButton[param1] = local3;
      this.tabButtons.push(local3);
      local3.addEventListener(MouseEvent.CLICK,this.onButtonClick);
      return local3;
    }

    private function onButtonClick(param1:MouseEvent) : void {
      var local2:QuestTypeEnum = param1.currentTarget.getQuestType();
      if(this.currentQuestType != local2) {
        this.selectTabButton(local2);
      }
    }

    public function selectTabButton(param1:QuestTypeEnum) : void {
      if(Boolean(this.currentQuestType)) {
        this.questCategoryToButton[this.currentQuestType].enabled = true;
      }
      this.questCategoryToButton[param1].enabled = false;
      this.currentQuestType = param1;
      dispatchEvent(new SelectTabEvent(param1));
    }

    override public function get height() : Number {
      return BUTTON_HEIGHT;
    }

    override public function get width() : Number {
      return this.panelWidth;
    }

    public function destroy() : void {
      var local1:QuestTabButton = null;
      for each(local1 in this.tabButtons) {
        local1.removeEventListener(MouseEvent.CLICK,this.onButtonClick);
      }
    }
  }
}
