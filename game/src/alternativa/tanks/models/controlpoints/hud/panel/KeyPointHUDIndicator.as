package alternativa.tanks.models.controlpoints.hud.panel {
  import alternativa.tanks.display.Flash;
  import alternativa.tanks.display.SquareSectorIndicator;
  import alternativa.tanks.models.controlpoints.hud.KeyPoint;
  import controls.Label;
  import flash.display.Sprite;
  import flash.geom.ColorTransform;
  import flash.utils.getTimer;
  import projects.tanks.client.battlefield.models.battle.cp.ControlPointState;

  public class KeyPointHUDIndicator extends Sprite {
    private static const SIZE:int = 36;
    private static const FONT_COLOR_RED:uint = 16742221;
    private static const FONT_COLOR_BLUE:uint = 4760319;
    private static const FONT_COLOR_NEUTRAL:uint = 16777215;
    private static const BG_COLOR_RED:uint = 9249024;
    private static const BG_COLOR_BLUE:uint = 16256;

    private var point:KeyPoint;
    private var label:Label;
    private var progressIndicator:SquareSectorIndicator;
    private var pointState:ControlPointState = ControlPointState.NEUTRAL;
    private var score:Number = 0;

    private const flash:Flash = Flash.getDefault();

    public function KeyPointHUDIndicator(param1:KeyPoint) {
      super();
      this.point = param1;
      this.createProgressIndicator();
      this.createLabel();
      this.update();
    }

    public static function getColor(param1:ControlPointState) : uint {
      switch(param1) {
        case ControlPointState.BLUE:
          return FONT_COLOR_BLUE;
        case ControlPointState.RED:
          return FONT_COLOR_RED;
        default:
          return FONT_COLOR_NEUTRAL;
      }
    }

    private function createProgressIndicator() : void {
      this.progressIndicator = new SquareSectorIndicator(SIZE,0,0,0);
      addChild(this.progressIndicator);
    }

    private function createLabel() : void {
      this.label = new Label();
      this.label.size = 18;
      this.label.bold = true;
      this.label.color = getColor(this.point.getCaptureState());
      this.label.text = this.point.getName();
    }

    public function getLabel() : Label {
      return this.label;
    }

    public function update() : void {
      this.updatePointState();
      this.updateScore();
    }

    private function setColorOffset(param1:uint) : void {
      var local2:ColorTransform = this.progressIndicator.transform.colorTransform;
      local2.redOffset = param1;
      local2.greenOffset = param1;
      local2.blueOffset = param1;
      this.progressIndicator.transform.colorTransform = local2;
    }

    private function updatePointState() : void {
      if(this.pointState != this.point.getCaptureState()) {
        this.pointState = this.point.getCaptureState();
        this.label.color = this.getLabelColor();
        if(this.pointState != ControlPointState.NEUTRAL) {
          this.flash.init();
        }
      }
      if(this.flash.isActive()) {
        this.setColorOffset(this.flash.getColorOffset(getTimer()));
      }
    }

    private function getLabelColor() : uint {
      switch(this.pointState) {
        case ControlPointState.BLUE:
          return FONT_COLOR_BLUE;
        case ControlPointState.RED:
          return FONT_COLOR_RED;
        default:
          return FONT_COLOR_NEUTRAL;
      }
    }

    private function updateScore() : void {
      if(this.score != this.point.getClientProgress()) {
        this.score = this.point.getClientProgress();
        if(this.score < 0) {
          this.progressIndicator.setColor(BG_COLOR_RED,1);
        } else if(this.score > 0) {
          this.progressIndicator.setColor(BG_COLOR_BLUE,1);
        } else {
          this.progressIndicator.setColor(0,0);
        }
        this.progressIndicator.setProgress(Math.abs(this.score) / 100);
      }
    }

    [Obfuscation(rename="false")]
    override public function get width() : Number {
      return SIZE;
    }

    [Obfuscation(rename="false")]
    override public function get height() : Number {
      return SIZE;
    }
  }
}
