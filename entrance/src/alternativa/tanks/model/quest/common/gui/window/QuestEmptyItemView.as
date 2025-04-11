package alternativa.tanks.model.quest.common.gui.window {
  import alternativa.tanks.model.quest.common.gui.CommonQuestTab;
  import alternativa.tanks.model.quest.common.gui.NoQuestBitmap;
  import alternativa.tanks.model.quest.common.gui.greenpanel.GreenPanel;
  import alternativa.tanks.model.quest.common.gui.window.buttons.DailyQuestDisabledPrizeButton;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerWithIcon;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.text.TextFormatAlign;

  public class QuestEmptyItemView extends Sprite {
    private const TEXT_WHITE_COLOR:uint = 16777215;

    private var innerWindow:TankWindowInner;
    private var noQuestsLabel:LabelBase;
    private var greenPanel:GreenPanel;
    private var _width:int;
    private var _height:int;
    private var timer:CountDownTimer;

    public function QuestEmptyItemView(param1:int, param2:int, param3:String, param4:int) {
      super();
      this._width = param1;
      this._height = param2;
      this.addInnerWindow();
      this.addTimeLabel(param4);
      this.addImage();
      this.addPanel();
      this.addLabel(param3);
      this.addDisabledButton();
    }

    private function addInnerWindow() : void {
      this.innerWindow = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this.innerWindow.width = CommonQuestTab.QUEST_VIEW_WIDTH;
      this.innerWindow.height = CommonQuestTab.QUEST_PANEL_HEIGHT;
      addChild(this.innerWindow);
    }

    private function addTimeLabel(param1:int) : void {
      this.timer = new CountDownTimer();
      this.timer.start(param1 * 1000);
      var local2:CountDownTimerWithIcon = new CountDownTimerWithIcon(false);
      local2.y = QuestWindow.INNER_MARGIN;
      this.innerWindow.addChild(local2);
      local2.start(this.timer);
      local2.x = QuestWindow.INNER_MARGIN;
    }

    private function addImage() : void {
      var local1:Bitmap = null;
      local1 = new Bitmap();
      local1.x = int(this.innerWindow.width / 2 - CommonQuestTab.QUEST_VIEW_WIDTH / 2);
      local1.y = CommonQuestView.IMAGE_PADDING;
      local1.bitmapData = NoQuestBitmap.DATA;
      this.innerWindow.addChild(local1);
    }

    private function addPanel() : void {
      var local1:int = CommonQuestView.IMAGE_HEIGHT + CommonQuestView.IMAGE_PADDING * 2;
      var local2:int = CommonQuestTab.QUEST_PANEL_HEIGHT - QuestWindow.INNER_MARGIN - local1;
      this.greenPanel = new GreenPanel(this.width - QuestWindow.INNER_MARGIN * 2,local2);
      this.greenPanel.x = QuestWindow.INNER_MARGIN;
      this.greenPanel.y = local1;
      this.innerWindow.addChild(this.greenPanel);
    }

    private function addLabel(param1:String) : void {
      this.noQuestsLabel = new LabelBase();
      this.noQuestsLabel.color = this.TEXT_WHITE_COLOR;
      this.noQuestsLabel.align = TextFormatAlign.CENTER;
      this.noQuestsLabel.wordWrap = true;
      this.noQuestsLabel.htmlText = param1;
      this.noQuestsLabel.width = this.greenPanel.width - QuestWindow.INNER_MARGIN * 2;
      this.noQuestsLabel.height = this.greenPanel.height;
      this.noQuestsLabel.x = int(this.greenPanel.width / 2 - this.noQuestsLabel.width / 2);
      this.noQuestsLabel.y = int((this.greenPanel.height - this.noQuestsLabel.height) / 2);
      this.greenPanel.addChild(this.noQuestsLabel);
    }

    private function addDisabledButton() : void {
      var local1:DailyQuestDisabledPrizeButton = new DailyQuestDisabledPrizeButton();
      local1.y = CommonQuestTab.QUEST_PANEL_HEIGHT + QuestWindow.INNER_MARGIN;
      local1.x = int(CommonQuestTab.QUEST_VIEW_WIDTH / 2 - local1.width / 2);
      local1.enabled = false;
      addChild(local1);
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function get height() : Number {
      return this._height;
    }

    public function destroy() : void {
      if(this.timer != null) {
        this.timer.destroy();
        this.timer = null;
      }
    }
  }
}
