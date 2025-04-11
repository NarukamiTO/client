package alternativa.tanks.models.battle.gui.inventory.cooldown {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import utils.graphics.SectorMask;

  public class CooldownIndicator extends Sprite {
    private var _sectorMask:SectorMask;

    public function CooldownIndicator(param1:BitmapData) {
      super();
      var local2:Bitmap = new Bitmap(param1);
      addChild(local2);
      this._sectorMask = new SectorMask(local2.width);
      addChild(this._sectorMask);
      mask = this._sectorMask;
    }

    public function setProgress(param1:Number, param2:Number) : void {
      this._sectorMask.setProgress(param1,param2);
    }
  }
}
