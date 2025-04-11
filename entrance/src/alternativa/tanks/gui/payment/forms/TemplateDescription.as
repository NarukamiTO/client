package alternativa.tanks.gui.payment.forms {
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import platform.client.fp10.core.resource.types.ImageResource;

  public class TemplateDescription extends Sprite {
    public var description:LabelBase;
    public var bottomContainer:Sprite;
    public var bottomText:LabelBase;

    protected var _width:Number;
    protected var spaceH:int = 20;
    protected var spaceV:int = 14;

    public function TemplateDescription(param1:int = 16777215) {
      super();
      tabEnabled = false;
      mouseEnabled = false;
      this.description = new LabelBase();
      this.description.color = param1;
      this.description.multiline = true;
      this.description.wordWrap = true;
      addChild(this.description);
      this.bottomContainer = new Sprite();
      this.bottomContainer.tabEnabled = false;
      this.bottomContainer.mouseEnabled = false;
      addChild(this.bottomContainer);
      this.bottomText = new LabelBase();
      this.bottomText.multiline = true;
      this.bottomText.wordWrap = true;
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this.description.width = this._width;
      this.bottomText.width = this._width - this.bottomText.x;
      this.bottomContainer.y = this.description.height + this.spaceV;
    }

    public function setBottomDescription(param1:String, param2:Vector.<ImageResource>) : void {
      var local3:int = 0;
      var local4:ImageResource = null;
      var local5:Bitmap = null;
      while(this.bottomContainer.numChildren > 0) {
        this.bottomContainer.removeChildAt(0);
      }
      local3 = this.spaceH;
      for each(local4 in param2) {
        local5 = new Bitmap(local4.data);
        local5.x = local3;
        local5.y = 0;
        local3 += local5.bitmapData.width + this.spaceH;
        this.bottomContainer.addChild(local5);
      }
      this.bottomText.x = local3;
      this.bottomText.htmlText = param1;
      this.bottomContainer.addChild(this.bottomText);
      this.width = this._width;
    }

    public function hideBottomDescription() : void {
      while(this.bottomContainer.numChildren > 0) {
        this.bottomContainer.removeChildAt(0);
      }
    }
  }
}
