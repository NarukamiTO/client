package alternativa.tanks.models.battle.gui.gui.statistics.field.score {
  import alternativa.tanks.models.battle.gui.gui.statistics.field.IconField;
  import controls.Label;
  import controls.resultassets.WhiteFrame;
  import flash.display.DisplayObject;

  public class PlayerScoreField extends IconField {
    private static const ICON_X:int = 9;
    private static const ICON_Y:int = 10;
    private static const LABEL_X:int = 9;
    private static const LABEL_Y:int = 6;
    private static const TEXT_SIZE:int = 18;

    private var whiteFrame:WhiteFrame;

    public function PlayerScoreField(param1:DisplayObject) {
      super(param1);
    }

    override protected function init() : void {
      this.whiteFrame = new WhiteFrame();
      addChild(this.whiteFrame);
      if(Boolean(icon)) {
        addChild(icon);
        icon.x = ICON_X;
        icon.y = ICON_Y;
      }
      label = new Label();
      label.color = 16777215;
      addChild(label);
      if(Boolean(icon)) {
        label.x = icon.x + icon.width + LABEL_X;
      } else {
        label.x = LABEL_X;
      }
      label.y = LABEL_Y;
      label.size = TEXT_SIZE;
      label.bold = true;
      this.setScore(0);
    }

    public function setScore(param1:int) : void {
      text = param1.toString();
      this.whiteFrame.width = label.x + label.width + 10;
    }
  }
}
