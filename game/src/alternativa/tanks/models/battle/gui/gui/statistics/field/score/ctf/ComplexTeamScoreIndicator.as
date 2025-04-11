package alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf {
  import alternativa.tanks.models.battle.gui.gui.statistics.field.score.ctf.flagindicator.FlagIndicator;
  import controls.Label;
  import controls.resultassets.WhiteFrame;
  import flash.display.Bitmap;
  import flash.display.GradientType;
  import flash.display.Graphics;
  import flash.display.SpreadMethod;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.Matrix;
  import flash.text.TextFieldAutoSize;
  import flash.utils.getTimer;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class ComplexTeamScoreIndicator extends Sprite {
    private static const FONT_COLOR_RED:uint = 16742221;
    private static const FONT_COLOR_BLUE:uint = 4760319;
    private static const BG_COLOR_RED:uint = 9249024;
    private static const BG_COLOR_BLUE:uint = 16256;
    private static const ICON_WIDTH:int = 30;
    private static const LABEL_Y:int = 6;

    private var border:WhiteFrame;
    private var blueIndicator:FlagIndicator;
    private var redIndicator:FlagIndicator;
    private var labelRed:Label;
    private var labelBlue:Label;
    private var time:int;
    private var redInterpolator:ColorInterpolator = new ColorInterpolator(FONT_COLOR_RED,16777215);
    private var blueInterpolator:ColorInterpolator = new ColorInterpolator(FONT_COLOR_BLUE,16777215);
    private var blinker:CTFScoreIndicatorBlinker = new CTFScoreIndicatorBlinker(0,1,Vector.<int>([200,600]),Vector.<Number>([10,1.1]));
    private var flashingScore:Boolean;

    public function ComplexTeamScoreIndicator(param1:Bitmap, param2:Bitmap, param3:Bitmap, param4:Bitmap, param5:Bitmap, param6:Bitmap, param7:Boolean = true) {
      super();
      this.flashingScore = param7;
      this.border = new WhiteFrame();
      addChild(this.border);
      this.labelRed = this.createLabel(FONT_COLOR_RED);
      this.labelBlue = this.createLabel(FONT_COLOR_BLUE);
      this.blueIndicator = new FlagIndicator(param1,param2,param3,this.blinker);
      this.blueIndicator.y = 5;
      addChild(this.blueIndicator);
      this.redIndicator = new FlagIndicator(param4,param5,param6,this.blinker);
      this.redIndicator.y = 5;
      addChild(this.redIndicator);
      this.update();
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
    }

    private static function updateScoreColor(param1:Label, param2:ColorInterpolator, param3:Bitmap) : void {
      var local4:uint = 0;
      if(param3.visible) {
        local4 = param2.interpolate(param3.alpha);
      } else {
        local4 = param2.startColor;
      }
      if(local4 != param1.textColor) {
        param1.textColor = local4;
      }
    }

    public function setScore(param1:int, param2:int) : void {
      this.labelRed.text = param1.toString();
      this.labelBlue.text = param2.toString();
      this.redIndicator.setState(FlagIndicator.STATE_DEFAULT);
      this.blueIndicator.setState(FlagIndicator.STATE_DEFAULT);
      this.update();
    }

    public function set redScore(param1:int) : void {
      if(int(this.labelRed.text) == param1) {
        return;
      }
      this.labelRed.text = param1.toString();
      if(this.flashingScore) {
        this.blueIndicator.setState(FlagIndicator.STATE_FLASHING);
      }
      this.update();
    }

    public function set blueScore(param1:int) : void {
      if(int(this.labelBlue.text) == param1) {
        return;
      }
      this.labelBlue.text = param1.toString();
      if(this.flashingScore) {
        this.redIndicator.setState(FlagIndicator.STATE_FLASHING);
      }
      this.update();
    }

    public function setBothIndicatorsState(param1:int, param2:int) : void {
      this.redIndicator.setState(param1);
      this.blueIndicator.setState(param2);
    }

    public function setIndicatorState(param1:BattleTeam, param2:int) : void {
      var local3:FlagIndicator = this.getFlagInficator(param1);
      local3.setState(param2);
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
      this.redIndicator.x = local1 + local1;
      local3 = this.redIndicator.x + ICON_WIDTH + local1;
      this.labelRed.x = local3 + (local2 - this.labelRed.width >> 1);
      local3 += local2 + local1 + local1;
      this.labelBlue.x = local3 + (local2 - this.labelBlue.width >> 1);
      local3 += local2 + local1;
      this.blueIndicator.x = local3;
      local3 += ICON_WIDTH + local1 + local1;
      this.updateBgAndBorder(local3);
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
      var local2:Label = new Label();
      local2.color = param1;
      local2.size = 18;
      local2.bold = true;
      local2.autoSize = TextFieldAutoSize.CENTER;
      local2.y = LABEL_Y;
      local2.text = "0";
      addChild(local2);
      return local2;
    }

    private function onAddedToStage(param1:Event) : void {
      this.update();
      this.time = getTimer();
      stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
    }

    private function onRemovedFromStage(param1:Event) : void {
      stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
    }

    private function onEnterFrame(param1:Event) : void {
      var local2:int = getTimer();
      var local3:int = local2 - this.time;
      this.time = local2;
      this.blinker.update(local2,local3);
      this.redIndicator.update(local2,local3);
      this.blueIndicator.update(local2,local3);
      updateScoreColor(this.labelRed,this.redInterpolator,this.blueIndicator.flashBitmap);
      updateScoreColor(this.labelBlue,this.blueInterpolator,this.redIndicator.flashBitmap);
    }

    private function getFlagInficator(param1:BattleTeam) : FlagIndicator {
      switch(param1) {
        case BattleTeam.BLUE:
          return this.blueIndicator;
        case BattleTeam.RED:
          return this.redIndicator;
        default:
          throw new ArgumentError("Unsupported team type");
      }
    }
  }
}
