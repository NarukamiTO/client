package alternativa.tanks.display.usertitle {
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.filters.BitmapFilterQuality;
  import flash.filters.GlowFilter;

  public class RadialBar extends Sprite {
    private const SEGMENTS_COUNT:int = 45;

    private var canvas:Shape = new Shape();
    private var value:Number;
    private var color:uint;
    private var backColor:uint;
    private var radius:int;
    private var thickness:Number;
    private var mirrored:Boolean;

    public function RadialBar(param1:uint, param2:uint, param3:int, param4:Number, param5:Boolean = false) {
      super();
      this.color = param1;
      this.backColor = param2;
      this.radius = param3;
      this.thickness = param4;
      this.mirrored = param5;
      this.canvas.filters = [new GlowFilter(0,0.6,3,3,2,BitmapFilterQuality.HIGH)];
      addChild(this.canvas);
    }

    public function setValue(param1:Number) : void {
      this.value = Math.max(0,Math.min(1,param1));
      this.draw();
    }

    public function draw() : void {
      var local3:int = 0;
      var local4:Number = NaN;
      var local1:Graphics = this.canvas.graphics;
      local1.clear();
      local1.moveTo(0,0 - this.radius);
      var local2:int = this.SEGMENTS_COUNT * this.value;
      local1.moveTo(0,0 - this.radius);
      local1.lineStyle(this.thickness,this.backColor);
      local3 = this.SEGMENTS_COUNT;
      while(local3 >= 0) {
        local4 = local3 * 2 * Math.PI / 180;
        if(local3 == local2 - 1) {
          local1.lineStyle(this.thickness,this.color);
        }
        local1.lineTo(0 - Math.cos(local4) * this.radius * (this.mirrored ? -1 : 1),0 - Math.sin(local4) * this.radius);
        local3--;
      }
    }
  }
}
