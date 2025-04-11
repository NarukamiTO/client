package alternativa.tanks.display.usertitle {
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.geom.Matrix;
  import flash.geom.Rectangle;

  public class ProgressBar {
    private static var matrix:Matrix = new Matrix();

    private var maxValue:int;
    private var barWidth:int;
    private var shadowTipWidth:int;
    private var shadowHeight:int;
    private var barOffsetX:int;
    private var barOffsetY:int;
    private var skin:ProgressBarSkin;
    private var barTipWidth:int;
    private var barHeight:int;
    private var _progress:int;
    private var canvas:Shape = new Shape();
    private var x:int;
    private var y:int;
    private var rect:Rectangle;

    public function ProgressBar(param1:int, param2:int, param3:int, param4:int, param5:ProgressBarSkin) {
      super();
      this.x = param1;
      this.y = param2;
      this.maxValue = param3;
      this.barWidth = param4;
      this.setSkin(param5);
      this.rect = new Rectangle(param1,param2,2 * this.shadowTipWidth + param4,this.shadowHeight);
    }

    public function setSkin(param1:ProgressBarSkin) : void {
      this.skin = param1;
      this.barTipWidth = param1.leftTipBg.width;
      this.barHeight = param1.leftTipBg.height;
      this.shadowTipWidth = param1.shadowLeftTip.width;
      this.shadowHeight = param1.shadow.height;
      this.barOffsetX = this.shadowTipWidth - this.barTipWidth;
      this.barOffsetY = this.shadowHeight - this.barHeight >> 1;
    }

    public function get progress() : int {
      return this._progress;
    }

    public function set progress(param1:int) : void {
      if(param1 < 0) {
        param1 = 0;
      } else if(param1 > this.maxValue) {
        param1 = this.maxValue;
      }
      this._progress = param1;
    }

    public function draw(param1:BitmapData) : void {
      var local4:int = 0;
      var local2:Graphics = this.canvas.graphics;
      local2.clear();
      local2.beginBitmapFill(this.skin.shadowLeftTip);
      local2.drawRect(0,0,this.shadowTipWidth,this.shadowHeight);
      local2.beginBitmapFill(this.skin.shadow);
      local2.drawRect(this.shadowTipWidth,0,this.barWidth - 2 * this.barTipWidth,this.shadowHeight);
      local2.beginBitmapFill(this.skin.shadowRightTip);
      local2.drawRect(this.shadowTipWidth + this.barWidth - 2 * this.barTipWidth,0,this.shadowTipWidth,this.shadowHeight);
      local2.endFill();
      var local3:int = this.barWidth * this._progress / this.maxValue;
      var local5:int = this.barWidth - this.barTipWidth;
      if(local3 >= this.barTipWidth) {
        if(local3 == this.barWidth) {
          this.drawFullBar(local2,this.skin.color,this.skin.leftTipFg,this.skin.rightTipFg);
          local4 = local3;
        } else {
          matrix.tx = this.barOffsetX;
          matrix.ty = this.barOffsetY;
          local2.beginBitmapFill(this.skin.leftTipFg,matrix,false);
          local2.drawRect(this.barOffsetX,this.barOffsetY,this.barTipWidth,this.barHeight);
          if(local3 > this.barTipWidth) {
            if(local3 > local5) {
              local3 = local5;
            }
            local4 = local3;
            local2.beginFill(this.skin.color);
            local2.drawRect(this.barOffsetX + this.barTipWidth,this.barOffsetY,local3 - this.barTipWidth,this.barHeight);
          } else {
            local4 = this.barTipWidth;
          }
        }
      }
      if(local4 == 0) {
        this.drawFullBar(local2,this.skin.bgColor,this.skin.leftTipBg,this.skin.rightTipBg);
      } else if(local4 < this.barWidth) {
        local2.beginFill(this.skin.bgColor);
        local2.drawRect(this.barOffsetX + local4,this.barOffsetY,local5 - local4,this.barHeight);
        matrix.tx = this.barOffsetX + local5;
        matrix.ty = this.barOffsetY;
        local2.beginBitmapFill(this.skin.rightTipBg,matrix,false);
        local2.drawRect(this.barOffsetX + local5,this.barOffsetY,this.barTipWidth,this.barHeight);
      }
      local2.endFill();
      param1.fillRect(this.rect,0);
      matrix.tx = this.x;
      matrix.ty = this.y;
      param1.draw(this.canvas,matrix);
    }

    private function drawFullBar(param1:Graphics, param2:uint, param3:BitmapData, param4:BitmapData) : void {
      var local5:int = this.barWidth - this.barTipWidth;
      matrix.tx = this.barOffsetX;
      matrix.ty = this.barOffsetY;
      param1.beginBitmapFill(param3,matrix,false);
      param1.drawRect(this.barOffsetX,this.barOffsetY,this.barTipWidth,this.barHeight);
      param1.beginFill(param2);
      param1.drawRect(this.barOffsetX + this.barTipWidth,this.barOffsetY,local5 - this.barTipWidth,this.barHeight);
      matrix.tx = this.barOffsetX + local5;
      param1.beginBitmapFill(param4,matrix,false);
      param1.drawRect(this.barOffsetX + local5,this.barOffsetY,this.barTipWidth,this.barHeight);
    }
  }
}
