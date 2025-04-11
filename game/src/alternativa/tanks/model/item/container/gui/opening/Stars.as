package alternativa.tanks.model.item.container.gui.opening {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.BlendMode;
  import flash.display.PixelSnapping;
  import flash.display.Sprite;
  import flash.geom.ColorTransform;

  public class Stars extends Sprite {
    private var stars:Array;
    private var count:int;
    private var radius:Number;

    public function Stars(param1:BitmapData, param2:BitmapData, param3:int, param4:Number) {
      var local6:Sprite = null;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      this.stars = new Array();
      super();
      this.count = param3;
      this.radius = param4;
      var local5:int = 0;
      while(local5 < param3) {
        local6 = new Sprite();
        local6.addChild(new Bitmap(param1,PixelSnapping.NEVER,true));
        local6.addChild(new Bitmap(param2,PixelSnapping.NEVER,true));
        local7 = 0.4 + Math.random();
        local6.getChildAt(0).scaleX = local7;
        local6.getChildAt(0).scaleY = local7;
        local6.getChildAt(0).x = -local6.getChildAt(0).width / 2;
        local6.getChildAt(0).y = -local6.getChildAt(0).height / 2;
        local6.getChildAt(0).blendMode = BlendMode.ADD;
        local6.getChildAt(1).scaleX = local7;
        local6.getChildAt(1).scaleY = local7;
        local6.getChildAt(1).x = -local6.getChildAt(1).width / 2;
        local6.getChildAt(1).y = -local6.getChildAt(1).height / 2;
        addChild(local6);
        this.stars.push(local6);
        local8 = Math.random() * Math.PI * 2;
        local9 = param4 / 3 + Math.random() * param4 * 2 / 3;
        local6.x = Math.cos(local8) * local9;
        local6.y = Math.sin(local8) * local9;
        if(local5 == 0) {
          local6.x = 0;
          local6.y = 0;
        }
        local6.rotation = Math.random() * 180;
        local5++;
      }
    }

    public function update() : void {
      var local1:Number = NaN;
      var local2:Number = NaN;
      var local4:Sprite = null;
      var local3:int = 0;
      while(local3 < this.count) {
        local4 = this.stars[local3];
        local4.rotation += 2;
        if(local4.rotation > 180) {
          local4.rotation = 0;
        }
        if(local4.rotation < 90) {
          local1 = local4.rotation / 90;
        } else {
          local1 = 1 - (local4.rotation - 90) / 90;
        }
        local2 = 0.2 + 0.8 * local1;
        local4.alpha = local1;
        local4.scaleX = local2;
        local4.scaleY = local2;
        local3++;
      }
    }

    public function colorize(param1:ColorTransform) : void {
      var local3:Sprite = null;
      var local2:int = 0;
      while(local2 < this.count) {
        local3 = this.stars[local2];
        local3.getChildAt(0).transform.colorTransform = param1;
        local2++;
      }
    }
  }
}
