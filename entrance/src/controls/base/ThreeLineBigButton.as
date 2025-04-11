package controls.base {
  import base.DiscreteSprite;
  import controls.labels.MouseDisabledLabel;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.filters.DropShadowFilter;

  public class ThreeLineBigButton extends BigButtonBase {
    protected var infoContainer:Sprite = new DiscreteSprite();
    protected var captionLabel:MouseDisabledLabel = new MouseDisabledLabel();

    public function ThreeLineBigButton() {
      super();
      addChild(this.infoContainer);
      this.infoContainer.addChild(this.captionLabel);
      this.showInOneRow(this.captionLabel);
      this.captionLabel.size = 14;
      this.infoContainer.mouseEnabled = false;
      this.infoContainer.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
    }

    public function setText(param1:String) : void {
      this.captionLabel.text = param1;
      this.captionLabel.x = (_width - this.captionLabel.width) * 0.5;
    }

    override public function set width(param1:Number) : void {
      super.width = param1;
      this.captionLabel.x = (_width - this.captionLabel.width) * 0.5;
    }

    protected function showInOneRow(param1:DisplayObject) : void {
      param1.y = 15;
    }

    protected function showInTwoRows(param1:DisplayObject, param2:DisplayObject) : void {
      param1.y = 8;
      param2.y = 25;
    }

    protected function showInThreeRows(param1:DisplayObject, param2:DisplayObject, param3:DisplayObject) : void {
      param1.y = 3;
      param2.y = 16;
      param3.y = 28;
    }
  }
}
