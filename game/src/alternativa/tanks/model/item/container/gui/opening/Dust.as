package alternativa.tanks.model.item.container.gui.opening {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.BlendMode;
  import flash.display.PixelSnapping;
  import flash.display.Sprite;

  public class Dust extends Sprite {
    private var motes:Array;
    private var count:int;
    private var bottom:Number;

    public function Dust(param1:BitmapData, param2:int, param3:Number, param4:Number) {
      var local7:Bitmap = null;
      var local8:Number = NaN;
      this.motes = new Array();
      super();
      this.count = param2;
      this.bottom = param4;
      var local5:Number = param3 / param2;
      var local6:int = 0;
      while(local6 < param2) {
        local7 = new Bitmap(param1,PixelSnapping.NEVER,true);
        local7.x = local6 * local5;
        local7.y = Math.random() * param3;
        local8 = 0.2 + Math.random();
        local7.scaleX = local8;
        local7.scaleY = local8;
        local7.blendMode = BlendMode.ADD;
        addChild(local7);
        this.motes.push(local7);
        local6++;
      }
    }

    public function update() : void {
      var local4:Bitmap = null;
      var local1:Number = this.bottom / 3;
      var local2:Number = local1 + local1;
      var local3:int = 0;
      while(local3 < this.count) {
        local4 = this.motes[local3];
        local4.y += 2;
        if(local4.y > this.bottom) {
          local4.y = 0;
        }
        if(local4.y < local1) {
          local4.alpha = local4.y / local1;
        } else if(local4.y < local2) {
          local4.alpha = 1;
        } else {
          local4.alpha = 1 - (local4.y - local2) / local1;
        }
        local3++;
      }
    }
  }
}
