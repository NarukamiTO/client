package alternativa.tanks.models.battle.gui.gui.statistics.field.score {
  import controls.Label;
  import controls.resultassets.WhiteFrame;
  import flash.display.GradientType;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.display.SpreadMethod;
  import flash.display.Sprite;
  import flash.geom.Matrix;
  import flash.text.TextFieldAutoSize;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class TeamScoreFieldBase extends Sprite {
    private static const LABEL_Y:int = 6;

    protected static const BG_COLOR_RED:uint = 9249024;
    protected static const FONT_COLOR_RED:uint = 16742221;
    protected static const BG_COLOR_BLUE:uint = 16256;
    protected static const FONT_COLOR_BLUE:uint = 4760319;

    protected var _scoreRed:int;
    protected var _scoreBlue:int;
    protected var labelRed:Label;
    protected var labelBlue:Label;

    private var background:Shape;

    protected var border:WhiteFrame;

    public function TeamScoreFieldBase() {
      super();
      addChild(this.background = new Shape());
      addChild(this.border = new WhiteFrame());
      this.labelRed = this.createLabel(FONT_COLOR_RED);
      this.labelBlue = this.createLabel(FONT_COLOR_BLUE);
    }

    public function setScore(param1:int, param2:int) : void {
      this._scoreRed = param1;
      this.labelRed.text = param1.toString();
      this._scoreBlue = param2;
      this.labelBlue.text = param2.toString();
      this.update();
    }

    public function setTeamScore(param1:BattleTeam, param2:int) : void {
      switch(param1) {
        case BattleTeam.RED:
          this.scoreRed = param2;
          break;
        case BattleTeam.BLUE:
          this.scoreBlue = param2;
      }
      this.update();
    }

    public function set scoreRed(param1:int) : void {
      this._scoreRed = param1;
      this.labelRed.text = param1.toString();
      this.update();
    }

    public function set scoreBlue(param1:int) : void {
      this._scoreBlue = param1;
      this.labelBlue.text = param1.toString();
      this.update();
    }

    public function update() : void {
      this.updateBgAndBorder(this.calculateWidth());
    }

    protected function calculateWidth() : int {
      return 0;
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
      local8.createGradientBox(param1 - local7,this.border.height - local7,0,0,0);
      var local9:String = SpreadMethod.PAD;
      var local10:Graphics = this.background.graphics;
      local10.clear();
      local10.beginGradientFill(local2,local3,local4,local6,local8,local9);
      local10.drawRect(local7,local7,param1 - 2 * local7,this.border.height - local7 - 1);
      local10.endFill();
    }

    private function createLabel(param1:uint) : Label {
      var local2:Label = new Label();
      local2.color = param1;
      local2.size = 18;
      local2.bold = true;
      local2.autoSize = TextFieldAutoSize.CENTER;
      local2.y = LABEL_Y;
      addChild(local2);
      return local2;
    }
  }
}
