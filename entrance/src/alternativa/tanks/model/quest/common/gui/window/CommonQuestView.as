package alternativa.tanks.model.quest.common.gui.window {
  import alternativa.tanks.model.quest.common.gui.CommonQuestTab;
  import alternativa.tanks.model.quest.common.gui.window.buttons.QuestGetPrizeButton;
  import alternativa.tanks.model.quest.common.gui.window.events.QuestGetPrizeEvent;
  import alternativa.types.Long;
  import controls.TankWindowInner;
  import controls.base.ThreeLineBigButton;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import projects.tanks.client.panel.model.quest.QuestTypeEnum;
  import projects.tanks.client.panel.model.quest.common.specification.QuestLevel;
  import projects.tanks.client.panel.model.quest.showing.QuestInfoWithLevel;

  public class CommonQuestView extends Sprite {
    public static const IMAGE_PADDING:int = 30;
    public static const IMAGE_HEIGHT:int = 120;

    public const ACTION_BUTTON_MARGIN:int = 4;

    protected var innerWindow:TankWindowInner;
    protected var questInfoPanel:QuestItemViewInfoPanel;
    protected var questImage:Bitmap;
    protected var actionButton:ThreeLineBigButton;
    protected var questInfo:QuestInfoWithLevel;

    public function CommonQuestView(param1:QuestInfoWithLevel) {
      super();
      this.questInfo = param1;
      this.addInnerWindow();
      this.addImage();
      this.addInfoPanel();
      this.addActionButton();
    }

    private function addInnerWindow() : void {
      this.innerWindow = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this.innerWindow.width = CommonQuestTab.QUEST_VIEW_WIDTH;
      this.innerWindow.height = CommonQuestTab.QUEST_PANEL_HEIGHT;
      addChild(this.innerWindow);
    }

    private function addImage() : void {
      this.questImage = new Bitmap();
      this.questImage.x = int(this.innerWindow.width / 2 - CommonQuestTab.QUEST_VIEW_WIDTH / 2);
      this.questImage.y = IMAGE_PADDING;
      this.questImage.bitmapData = this.questInfo.image.data;
      this.innerWindow.addChild(this.questImage);
    }

    private function addInfoPanel() : void {
      var local1:int = CommonQuestTab.QUEST_PANEL_HEIGHT - QuestWindow.INNER_MARGIN - IMAGE_HEIGHT - IMAGE_PADDING * 2;
      var local2:int = CommonQuestTab.QUEST_VIEW_WIDTH - 2 * QuestWindow.INNER_MARGIN;
      this.questInfoPanel = new QuestItemViewInfoPanel(this.questInfo,local2,local1);
      this.questInfoPanel.x = QuestWindow.INNER_MARGIN;
      this.questInfoPanel.y = IMAGE_HEIGHT + IMAGE_PADDING * 2;
      this.innerWindow.addChild(this.questInfoPanel);
    }

    private function addActionButton() : void {
      this.actionButton = this.createActionButton();
      addChild(this.actionButton);
      this.updateActionButtonPosition();
    }

    protected function createActionButton() : ThreeLineBigButton {
      return this.createGetPrizeButton();
    }

    protected function createGetPrizeButton() : ThreeLineBigButton {
      var local1:ThreeLineBigButton = new QuestGetPrizeButton();
      local1.addEventListener(MouseEvent.CLICK,this.onGetPrizeButtonClick);
      return local1;
    }

    private function onGetPrizeButtonClick(param1:MouseEvent) : void {
      this.actionButton.removeEventListener(MouseEvent.CLICK,this.onGetPrizeButtonClick);
      dispatchEvent(new QuestGetPrizeEvent(QuestGetPrizeEvent.GET_QUEST_PRIZE,this.questInfo.questId));
    }

    private function updateActionButtonPosition() : void {
      this.actionButton.x = int(CommonQuestTab.QUEST_VIEW_WIDTH / 2 - this.actionButton.width / 2);
      this.actionButton.y = this.innerWindow.height + QuestWindow.BORDER_MARGIN - this.ACTION_BUTTON_MARGIN;
    }

    public function getQuestId() : Long {
      return this.questInfo.questId;
    }

    public function getQuestLevel() : QuestLevel {
      return this.questInfo.level;
    }

    public function getQuestType() : QuestTypeEnum {
      return null;
    }

    public function destroy() : void {
      if(this.actionButton is QuestGetPrizeButton && this.actionButton.hasEventListener(MouseEvent.CLICK)) {
        this.actionButton.removeEventListener(MouseEvent.CLICK,this.onGetPrizeButtonClick);
      }
    }
  }
}
