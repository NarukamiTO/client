package alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.aim {
  import alternativa.tanks.utils.MathUtils;
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.filters.BitmapFilterQuality;
  import flash.filters.GlowFilter;
  import flash.geom.Matrix;
  import flash.geom.Rectangle;

  public class AimShape extends Sprite {
    private static const halfSquareClass:Class = AimShape_halfSquareClass;
    private static const halfSquare:BitmapData = new halfSquareClass().bitmapData;
    private static const OFFSET_BETWEEN_SQUARES:int = 9;
    private static const CIRCLE_FILL_COLOR:uint = 8056625;
    private static const CIRCLE_BACKGROUND_COLOR:uint = 2456322;
    private static const CIRCLE_THICKNESS:Number = 3;
    private static const CIRCLE_RADIUS:Number = 28;

    private const matrix:Matrix = new Matrix();

    private var circleShape:Shape;
    private var texture:BitmapData;
    private var rectForClearing:Rectangle;

    public function AimShape() {
      super();
      this.createSquare();
      this.createCircleShape();
      this.rectForClearing = new Rectangle(0,0,this.width,this.height);
    }

    private function createSquare() : void {
      var local1:Graphics = graphics;
      local1.beginBitmapFill(halfSquare);
      local1.drawRect(0,0,halfSquare.width,halfSquare.height);
      local1.endFill();
      this.matrix.tx = -OFFSET_BETWEEN_SQUARES;
      this.matrix.ty = -OFFSET_BETWEEN_SQUARES;
      this.matrix.rotate(Math.PI);
      local1.beginBitmapFill(halfSquare,this.matrix);
      local1.drawRect(OFFSET_BETWEEN_SQUARES,OFFSET_BETWEEN_SQUARES,halfSquare.width,halfSquare.height);
      local1.endFill();
    }

    private function createCircleShape() : void {
      this.circleShape = new Shape();
      this.circleShape.filters = [new GlowFilter(0,0.6,2,2,2,BitmapFilterQuality.HIGH)];
      this.circleShape.x = halfSquare.width + OFFSET_BETWEEN_SQUARES >> 1;
      this.circleShape.y = halfSquare.height + OFFSET_BETWEEN_SQUARES >> 1;
      this.circleShape.visible = false;
      addChild(this.circleShape);
      this.matrix.identity();
      this.matrix.tx = this.circleShape.x;
      this.matrix.ty = this.circleShape.y;
    }

    public function setTexture(param1:BitmapData) : void {
      this.texture = param1;
    }

    public function update(param1:Boolean, param2:Number = 0) : void {
      this.texture.fillRect(this.rectForClearing,0);
      this.circleShape.visible = !param1;
      this.drawCircle(param2);
      this.texture.draw(this);
    }

    private function drawCircle(param1:Number) : void {
      var local5:Number = NaN;
      var local6:Number = NaN;
      if(!this.circleShape.visible) {
        return;
      }
      param1 = MathUtils.clamp(param1,0,1);
      var local2:Graphics = this.circleShape.graphics;
      var local3:int = 0;
      var local4:int = 0;
      local2.clear();
      local2.lineStyle(CIRCLE_THICKNESS,CIRCLE_BACKGROUND_COLOR);
      local2.drawCircle(local3,local4,CIRCLE_RADIUS);
      if(param1 > 0) {
        local2.lineStyle(CIRCLE_THICKNESS,CIRCLE_FILL_COLOR);
        local5 = Math.PI / 2;
        local6 = local5 + MathUtils.PI2 * param1;
        this.drawCircleSegment(local2,local3,local4,local5,local6,CIRCLE_RADIUS);
      }
    }

    private function drawCircleSegment(param1:Graphics, param2:int, param3:int, param4:Number, param5:Number, param6:Number) : void {
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      param1.moveTo(param2 + Math.cos(param4) * param6,param3 + Math.sin(param4) * param6);
      var local7:uint = 8;
      var local8:Number = (param5 - param4) / local7;
      var local9:Number = param4;
      var local10:Number = param6 / Math.cos(local8 / 2);
      var local11:int = 0;
      while(local11 < local7) {
        local9 += local8;
        local12 = local9 - local8 / 2;
        local13 = param2 + Math.cos(local12) * local10;
        local14 = param3 + Math.sin(local12) * local10;
        local15 = param2 + Math.cos(local9) * param6;
        local16 = param3 + Math.sin(local9) * param6;
        param1.curveTo(local13,local14,local15,local16);
        local11++;
      }
    }
  }
}
