package alternativa.tanks.gui.clanmanagement {
  import base.DiscreteSprite;
  import controls.TankWindowInner;
  import controls.windowinner.WindowInner;
  import fl.containers.ScrollPane;
  import fl.controls.ScrollPolicy;
  import flash.display.Sprite;
  import flash.text.AntiAliasType;
  import flash.text.TextFieldAutoSize;
  import utils.ScrollStyleUtils;

  public class ClanDescriptionPanel extends DiscreteSprite {
    private static const FRAME:int = 7;

    private var descriptionInner:WindowInner;
    private var description:ClanDescriptionText = new ClanDescriptionText();
    private var scrollPane:ScrollPane = new ScrollPane();
    private var scrollContainer:Sprite = new Sprite();
    private var _width:int;
    private var _height:int;

    public function ClanDescriptionPanel(param1:String) {
      super();
      this.descriptionInner = new WindowInner(0,0,TankWindowInner.GREEN);
      addChild(this.descriptionInner);
      this.description.autoSize = TextFieldAutoSize.LEFT;
      this.description.antiAliasType = AntiAliasType.ADVANCED;
      this.description.multiline = true;
      this.description.wordWrap = true;
      if(param1 != null) {
        this.description.text = param1;
      }
      this.scrollContainer.addChild(this.description);
      this.descriptionInner.addChild(this.scrollPane);
      ScrollStyleUtils.setGreenStyle(this.scrollPane);
      this.scrollPane.horizontalScrollPolicy = ScrollPolicy.OFF;
      this.scrollPane.verticalScrollPolicy = ScrollPolicy.ON;
      this.scrollPane.source = this.scrollContainer;
      this.scrollPane.update();
      this.scrollPane.focusEnabled = false;
      this.onResize();
    }

    public function onResize() : void {
      this.descriptionInner.x = 0;
      this.descriptionInner.y = 0;
      this.descriptionInner.width = this.width;
      this.descriptionInner.height = this.height;
      this.scrollPane.x = FRAME;
      this.scrollPane.y = 3;
      this.scrollContainer.x = 0;
      this.scrollContainer.y = 0;
      this.description.x = 0;
      this.description.y = 0;
      if(this.scrollContainer.height < this.height) {
        this.scrollPane.verticalScrollPolicy = ScrollPolicy.OFF;
        this.description.width = this.descriptionInner.width - 2 * FRAME;
      } else {
        this.scrollPane.verticalScrollPolicy = ScrollPolicy.ON;
        this.description.width = this.descriptionInner.width - 2 * FRAME - 5;
      }
      this.scrollPane.setSize(this.descriptionInner.width - 2,this.descriptionInner.height - FRAME);
      this.scrollPane.update();
    }

    public function setDescriptionText(param1:String) : void {
      if(param1 != null) {
        this.description.text = param1;
      }
      this.onResize();
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this.onResize();
    }

    override public function get height() : Number {
      return this._height;
    }

    override public function set height(param1:Number) : void {
      this._height = param1;
      this.onResize();
    }
  }
}
