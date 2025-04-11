package controls.statassets {
  import assets.resultwindow.bres_BG_BLACKCORNER;
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.geom.Matrix;

  public class BlackRoundRect extends StatLineBase {
    public function BlackRoundRect() {
      super();
      tl = new bres_BG_BLACKCORNER(1,1);
      px = new BitmapData(1,1,true,2566914048);
    }

    override protected function draw() : void {
      var local2:Matrix = null;
      var local1:Graphics = this.graphics;
      local1.clear();
      local1.beginBitmapFill(tl);
      local1.drawRect(0,0,8,8);
      local1.endFill();
      local2 = new Matrix();
      local2.rotate(Math.PI * 0.5);
      local2.translate(_width - 8,0);
      local1.beginBitmapFill(tl,local2);
      local1.drawRect(_width - 8,0,8,8);
      local1.endFill();
      local2 = new Matrix();
      local2.rotate(Math.PI);
      local2.translate(_width - 8,_height - 8);
      local1.beginBitmapFill(tl,local2);
      local1.drawRect(_width - 8,_height - 8,8,8);
      local1.endFill();
      local2 = new Matrix();
      local2.rotate(Math.PI * 1.5);
      local2.translate(0,_height - 8);
      local1.beginBitmapFill(tl,local2);
      local1.drawRect(0,_height - 8,8,8);
      local1.endFill();
      local1.beginBitmapFill(px);
      local1.drawRect(8,0,_width - 16,_height);
      local1.drawRect(0,8,8,_height - 16);
      local1.drawRect(_width - 8,8,8,_height - 16);
      local1.endFill();
    }
  }
}
