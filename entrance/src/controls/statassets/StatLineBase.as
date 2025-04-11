package controls.statassets {
  import controls.resultassets.ResultWindowBase;
  import flash.display.Graphics;

  public class StatLineBase extends ResultWindowBase {
    protected var frameColor:uint = 0;

    public function StatLineBase() {
      super();
    }

    override protected function draw() : void {
      var local1:Graphics = null;
      super.draw();
      if(this.frameColor != 0) {
        local1 = this.graphics;
        local1.beginFill(this.frameColor);
        local1.drawRect(4,0,_width - 8,1);
        local1.drawRect(4,_height - 1,_width - 8,1);
        local1.drawRect(0,4,1,_height - 8);
        local1.drawRect(_width - 1,4,1,_height - 8);
        local1.endFill();
      }
    }
  }
}
