package alternativa.tanks.view {
  import flash.display.DisplayObject;
  import flash.display.Sprite;

  public class TipBlock extends Sprite {
    private var tipsContainer:Sprite;

    public function TipBlock() {
      super();
      this.tipsContainer = new Sprite();
      this.tipsContainer.x = 8;
      this.tipsContainer.y = 9;
      addChild(this.tipsContainer);
    }

    public function showTip(param1:DisplayObject) : void {
      if(this.tipsContainer.numChildren > 0) {
        this.tipsContainer.removeChildAt(0);
      }
      this.tipsContainer.addChild(param1);
    }
  }
}
