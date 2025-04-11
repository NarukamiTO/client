package alternativa.tanks.display {
  import flash.display.Sprite;
  import utils.graphics.SectorMask;

  public class SquareSectorIndicator extends Sprite {
    private var size:Number;
    private var ellipseWidth:Number;
    private var sectorMask:SectorMask;

    public function SquareSectorIndicator(param1:int, param2:Number, param3:uint, param4:Number) {
      super();
      this.size = param1;
      this.ellipseWidth = param2;
      this.drawShape(param3,param4);
      this.sectorMask = new SectorMask(param1);
      addChild(this.sectorMask);
      mask = this.sectorMask;
    }

    private function drawShape(param1:uint, param2:Number) : void {
      graphics.clear();
      graphics.beginFill(param1,param2);
      graphics.drawRoundRect(0,0,this.size,this.size,this.ellipseWidth);
      graphics.endFill();
    }

    public function setProgress(param1:Number) : void {
      this.sectorMask.setProgress(1 - param1,1);
    }

    public function setColor(param1:uint, param2:Number) : void {
      this.drawShape(param1,param2);
    }
  }
}
