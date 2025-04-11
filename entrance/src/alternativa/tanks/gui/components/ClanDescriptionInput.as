package alternativa.tanks.gui.components {
  import base.DiscreteSprite;
  import controls.TankWindowInner;
  import controls.base.TextFieldUtf8Base;
  import controls.windowinner.WindowInner;
  import fl.containers.ScrollPane;
  import fl.controls.ScrollPolicy;
  import flash.display.Sprite;
  import flash.events.KeyboardEvent;
  import flash.text.AntiAliasType;
  import flash.text.GridFitType;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFieldType;
  import flash.text.TextFormat;
  import fonts.TanksFontService;
  import utils.FontParamsUtil;
  import utils.ScrollStyleUtils;

  public class ClanDescriptionInput extends DiscreteSprite {
    private static const FRAME:int = 7;

    private var descriptionInner:WindowInner;

    public var description:TextFieldUtf8Base = new TextFieldUtf8Base();

    private var scrollPane:ScrollPane = new ScrollPane();
    private var scrollContainer:Sprite = new Sprite();

    private const format:TextFormat = TanksFontService.getTextFormat(12);

    private var _width:int;
    private var _height:int;

    public function ClanDescriptionInput(param1:String, param2:int) {
      super();
      this.descriptionInner = new WindowInner(0,0,TankWindowInner.GREEN);
      addChild(this.descriptionInner);
      this.format.color = 16777215;
      this.description.defaultTextFormat = this.format;
      this.description.antiAliasType = AntiAliasType.ADVANCED;
      this.description.gridFitType = GridFitType.PIXEL;
      this.description.embedFonts = TanksFontService.isEmbedFonts();
      this.description.sharpness = FontParamsUtil.SHARPNESS_TANK_INPUT_BASE;
      this.description.thickness = FontParamsUtil.THICKNESS_TANK_INPUT_BASE;
      this.description.multiline = true;
      this.description.wordWrap = true;
      this.description.type = TextFieldType.INPUT;
      this.description.selectable = true;
      this.description.autoSize = TextFieldAutoSize.LEFT;
      this.description.text = param1;
      this.description.maxChars = param2;
      this.description.addEventListener(KeyboardEvent.KEY_DOWN,this.onTextChange);
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

    private function onTextChange(param1:KeyboardEvent) : void {
      this.scrollPane.update();
      if(this.description.textHeight > this.descriptionInner.height - FRAME) {
        this.description.autoSize = TextFieldAutoSize.LEFT;
      } else {
        this.description.autoSize = TextFieldAutoSize.NONE;
        this.description.height = this.descriptionInner.height - FRAME;
      }
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
      this.description.width = this.descriptionInner.width - 2 * FRAME - 5;
      if(this.description.textHeight > this.descriptionInner.height - FRAME) {
        this.description.autoSize = TextFieldAutoSize.LEFT;
      } else {
        this.description.autoSize = TextFieldAutoSize.NONE;
        this.description.height = this.descriptionInner.height - FRAME;
      }
      this.scrollPane.setSize(this.descriptionInner.width - 2,this.descriptionInner.height - FRAME);
      this.scrollPane.update();
    }

    public function setDescriptionText(param1:String) : void {
      this.description.text = param1;
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

    public function get text() : String {
      return this.description.text;
    }
  }
}
