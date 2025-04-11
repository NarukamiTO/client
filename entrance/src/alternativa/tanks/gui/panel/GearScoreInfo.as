package alternativa.tanks.gui.panel {
  import alternativa.tanks.gui.panel.helpers.PlayerInfoHelper;
  import controls.Label;
  import flash.display.Sprite;

  public class GearScoreInfo extends Sprite {
    private static const OFFSET_IN_RATINGS:int = 3;
    private static const TEXT_COLOR:uint = 1244928;
    private static const TEXT_SIZE:uint = 11;
    private static const Y_OFFSET:uint = 1;

    private var ratingCode:Label = new Label();
    private var ratingValue:Label = new Label();
    private var previousLabel:Label;
    private var score:int;

    public function GearScoreInfo() {
      super();
    }

    public function updateScore(param1:int) : void {
      this.score = param1;
      this.update();
    }

    public function update() : void {
      this.clearAll();
      this.addLabels(this.ratingCode,this.ratingValue,"GS: ",String(this.score));
    }

    protected function clearAll() : void {
      this.previousLabel = null;
      while(numChildren > 0) {
        removeChildAt(0);
      }
    }

    protected function addLabels(param1:Label, param2:Label, param3:String, param4:String) : void {
      this.addRatingCodeLabel(param1,param3);
      this.addRatingValueLabel(param2,param4);
    }

    private function addRatingCodeLabel(param1:Label, param2:String) : void {
      param1.color = TEXT_COLOR;
      param1.text = param2;
      PlayerInfoHelper.setDefaultSharpnessAndThickness(param1);
      if(this.previousLabel != null) {
        this.updateLabelPosition(param1,this.previousLabel);
      }
      addChild(param1);
      this.previousLabel = param1;
    }

    private function addRatingValueLabel(param1:Label, param2:String) : void {
      param1.size = TEXT_SIZE;
      param1.y = Y_OFFSET;
      this.addRatingCodeLabel(param1,param2);
    }

    private function updateLabelPosition(param1:Label, param2:Label) : void {
      param1.x = param2.x + param2.textWidth + OFFSET_IN_RATINGS;
    }
  }
}
