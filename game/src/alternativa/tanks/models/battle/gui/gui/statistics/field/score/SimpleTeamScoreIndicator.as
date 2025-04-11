package alternativa.tanks.models.battle.gui.gui.statistics.field.score {
  import controls.Label;
  import controls.resultassets.WhiteFrame;
  import flash.display.Bitmap;
  import flash.display.GradientType;
  import flash.display.Graphics;
  import flash.display.SpreadMethod;
  import flash.display.Sprite;
  import flash.geom.Matrix;
  import flash.text.TextFieldAutoSize;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class SimpleTeamScoreIndicator extends Sprite implements TeamScoreIndicator {
    private static const FONT_COLOR_RED:uint = 16742221;
    private static const FONT_COLOR_BLUE:uint = 4760319;
    private static const BG_COLOR_RED:uint = 9249024;
    private static const BG_COLOR_BLUE:uint = 16256;
    private static const ICON_WIDTH:int = 30;
    private static const LABEL_Y:int = 6;

    private var border:WhiteFrame;
    private var redScoreIcon:Bitmap;
    private var blueScoreIcon:Bitmap;
    private var labelRed:Label;
    private var labelBlue:Label;

    public function SimpleTeamScoreIndicator() {
      super();
      this.border = new WhiteFrame();
      addChild(this.border);
      this.labelRed = this.createLabel(FONT_COLOR_RED);
      this.labelBlue = this.createLabel(FONT_COLOR_BLUE);
      this.redScoreIcon = this.getRedScoreIcon();
      this.redScoreIcon.y = 5;
      addChild(this.redScoreIcon);
      this.blueScoreIcon = this.getBlueScoreIcon();
      this.blueScoreIcon.y = 5;
      addChild(this.blueScoreIcon);
      this.update();
    }

    protected function getRedScoreIcon() : Bitmap {
      throw new Error();
    }

    protected function getBlueScoreIcon() : Bitmap {
      throw new Error();
    }

    public function setScore(param1:int, param2:int) : void {
      this.labelRed.text = param1.toString();
      this.labelBlue.text = param2.toString();
      this.update();
    }

    public function set redScore(param1:int) : void {
      if(int(this.labelRed.text) == param1) {
        return;
      }
      this.labelRed.text = param1.toString();
      this.update();
    }

    public function set blueScore(param1:int) : void {
      if(int(this.labelBlue.text) == param1) {
        return;
      }
      this.labelBlue.text = param1.toString();
      this.update();
    }

    public function setTeamScore(param1:BattleTeam, param2:int) : void {
      switch(param1) {
        case BattleTeam.BLUE:
          this.blueScore = param2;
          break;
        case BattleTeam.RED:
          this.redScore = param2;
      }
    }

    private function update() : void {
      var local3:int = 0;
      var local1:int = 5;
      var local2:int = this.labelRed.width > this.labelBlue.width ? int(this.labelRed.width) : int(this.labelBlue.width);
      this.redScoreIcon.x = local1 + local1;
      local3 = this.redScoreIcon.x + ICON_WIDTH;
      this.labelRed.x = local3 + (local2 - this.labelRed.width >> 1);
      local3 += local2 + local1 + local1;
      this.labelBlue.x = local3 + (local2 - this.labelBlue.width >> 1);
      local3 += local2 + local1;
      this.blueScoreIcon.x = local3;
      local3 += 22 + local1 + local1;
      this.updateBgAndBorder(local3 + local1);
    }

    private function updateBgAndBorder(param1:int) : void {
      this.border.width = param1;
      var local2:String = GradientType.LINEAR;
      var local3:Array = [BG_COLOR_RED,BG_COLOR_BLUE];
      var local4:Array = [1,1];
      var local5:int = 8 / param1 * 255;
      var local6:Array = [127 - local5,127 + local5];
      var local7:int = 2;
      var local8:Matrix = new Matrix();
      local8.createGradientBox(param1 - 2 * local7,this.border.height - 2 * local7,0,0,0);
      var local9:String = SpreadMethod.PAD;
      var local10:Graphics = graphics;
      local10.clear();
      local10.beginGradientFill(local2,local3,local4,local6,local8,local9);
      local10.drawRect(local7,local7,param1 - 2 * local7,this.border.height - 2 * local7);
      local10.endFill();
    }

    private function createLabel(param1:uint) : Label {
      var local2:Label = null;
      local2 = new Label();
      local2.color = param1;
      local2.size = 18;
      local2.bold = true;
      local2.autoSize = TextFieldAutoSize.CENTER;
      local2.y = LABEL_Y;
      local2.text = "0";
      addChild(local2);
      return local2;
    }
  }
}
