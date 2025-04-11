package controls {
  import flash.display.Graphics;
  import flash.display.Sprite;

  public class Hint extends Sprite {
    private const MAX_WIDTH:* = 200;
    private const COLOR:* = 16777215;
    private const ALPHA:* = 0.4;

    private var _label:Label = new Label();

    public function Hint() {
      super();
      addChild(this._label);
      this._label.size = 11;
    }

    public function set text(param1:String) : void {
      var local2:Graphics = this.graphics;
      this._label.text = param1;
      if(this._label.textWidth > this.MAX_WIDTH) {
        this._label.width = this.MAX_WIDTH;
        this._label.multiline = true;
        this._label.wordWrap = true;
      }
      local2.clear();
      local2.beginFill(this.COLOR,this.ALPHA);
      local2.drawRect(-3,-3,this._label.textWidth + 9,this._label.textHeight + 9);
      local2.endFill();
    }
  }
}
