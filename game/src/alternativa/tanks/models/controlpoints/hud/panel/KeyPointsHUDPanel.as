package alternativa.tanks.models.controlpoints.hud.panel {
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.LayoutManager;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.Widget;
  import alternativa.tanks.models.controlpoints.hud.*;
  import controls.Label;
  import controls.resultassets.WhiteFrame;
  import flash.display.Shape;
  import flash.display.Sprite;

  public class KeyPointsHUDPanel extends Sprite implements Renderer, Widget {
    private static const SPACING:int = 1;

    private var shape:Shape = new Shape();
    private var indicators:Vector.<KeyPointHUDIndicator>;
    private var _width:int;
    private var _height:int;

    public function KeyPointsHUDPanel(param1:Vector.<KeyPoint>) {
      super();
      this.createIndicators(param1);
      this.createBorder(param1.length);
      addChild(this.shape);
      this.bringLabelsToFront();
    }

    public function removeFromParent() : void {
      if(parent != null) {
        parent.removeChild(this);
      }
    }

    private function bringLabelsToFront() : void {
      var local1:KeyPointHUDIndicator = null;
      for each(local1 in this.indicators) {
        addChild(local1.getLabel());
      }
    }

    public function setLayoutManager(param1:LayoutManager) : void {
    }

    public function render(param1:int, param2:int) : void {
      this.update();
    }

    public function update() : void {
      var local1:KeyPointHUDIndicator = null;
      for each(local1 in this.indicators) {
        local1.update();
      }
    }

    private function createIndicators(param1:Vector.<KeyPoint>) : void {
      var local5:KeyPoint = null;
      var local6:KeyPointHUDIndicator = null;
      var local7:Label = null;
      var local2:Vector.<KeyPoint> = this.sortPoints(param1);
      var local3:int = 2;
      this.indicators = new Vector.<KeyPointHUDIndicator>(param1.length);
      var local4:int = 0;
      while(local4 < local2.length) {
        local5 = local2[local4];
        local6 = new KeyPointHUDIndicator(local5);
        local6.x = local3;
        local6.y = 2;
        addChild(local6);
        local7 = local6.getLabel();
        local7.y = 8;
        local7.x = int(local6.x + (local6.width - local7.width) / 2);
        if(local4 < local2.length - 1) {
          this.shape.graphics.lineStyle(0,16777215);
          this.shape.graphics.moveTo(local6.x + 36,2);
          this.shape.graphics.lineTo(local6.x + 36,38);
        }
        this.indicators[local4] = local6;
        local3 += local6.width + SPACING;
        local4++;
      }
    }

    private function sortPoints(param1:Vector.<KeyPoint>) : Vector.<KeyPoint> {
      var points:Vector.<KeyPoint> = param1;
      return points.concat().sort(function(param1:KeyPoint, param2:KeyPoint):Number {
        if(param1.getName() < param2.getName()) {
          return -1;
        }
        if(param1.getName() > param2.getName()) {
          return 1;
        }
        return 0;
      });
    }

    private function createBorder(param1:int) : void {
      var local2:WhiteFrame = new WhiteFrame();
      local2.width = param1 * (36 + SPACING) - SPACING + 4;
      addChild(local2);
      this._width = local2.width;
      this._height = local2.height;
    }

    [Obfuscation(rename="false")]
    override public function get width() : Number {
      return this._width;
    }

    [Obfuscation(rename="false")]
    override public function get height() : Number {
      return this._height;
    }
  }
}
