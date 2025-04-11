package alternativa.tanks.view.timeleftindicator {
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import utils.graphics.SectorMask;

  public class TimeLeftIndicator extends Sprite {
    protected var imageFull:Bitmap;
    protected var sectorMask:SectorMask;

    private var container:Sprite = new Sprite();

    public function TimeLeftIndicator() {
      super();
      addChild(this.container);
      this.sectorMask = new SectorMask(this.imageFull.width);
      this.container.addChild(this.sectorMask);
      this.paintEmpty();
    }

    public function setPercentLeft(param1:Number) : void {
      param1 = Math.max(0,Math.min(1,param1));
      param1 = this.getNormalized(param1);
      if(param1 == 0) {
        this.paintEmpty();
      } else {
        this.sectorMask.setProgress(1 - param1,1);
        this.paintNotEmpty();
      }
    }

    private function getNormalized(param1:Number) : Number {
      var local2:Number = 0;
      while(param1 > 0) {
        local2 += 0.125;
        param1 -= 0.125;
      }
      return local2;
    }

    private function paintEmpty() : void {
      this.container.visible = false;
    }

    private function paintNotEmpty() : void {
      this.container.visible = true;
      if(this.imageFull.parent == null) {
        this.container.addChild(this.imageFull);
      }
      this.container.mask = this.sectorMask;
    }

    override public function get width() : Number {
      return this.imageFull.width;
    }
  }
}
