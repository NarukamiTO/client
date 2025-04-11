package controls.chat {
  import controls.Label;
  import controls.base.TextFieldUtf8Base;
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.TextEvent;
  import flash.system.Capabilities;
  import flash.text.AntiAliasType;
  import flash.text.GridFitType;
  import flash.text.TextField;
  import flash.text.TextFieldType;
  import flash.text.TextFormat;
  import fonts.TanksFontService;
  import forms.ColorConstants;
  import forms.events.LoginFormEvent;

  public class BattleChatInput extends Sprite {
    private static const bitmapBC:Class = BattleChatInput_bitmapBC;
    private static const bgBC:BitmapData = new bitmapBC().bitmapData;
    private static const bitmapBL:Class = BattleChatInput_bitmapBL;
    private static const bgBL:BitmapData = new bitmapBL().bitmapData;
    private static const bitmapBR:Class = BattleChatInput_bitmapBR;
    private static const bgBR:BitmapData = new bitmapBR().bitmapData;
    private static const bitmapRC:Class = BattleChatInput_bitmapRC;
    private static const bgRC:BitmapData = new bitmapRC().bitmapData;
    private static const bitmapRL:Class = BattleChatInput_bitmapRL;
    private static const bgRL:BitmapData = new bitmapRL().bitmapData;
    private static const bitmapRR:Class = BattleChatInput_bitmapRR;
    private static const bgRR:BitmapData = new bitmapRR().bitmapData;
    private static const bitmapNR:Class = BattleChatInput_bitmapNR;
    private static const bgNR:BitmapData = new bitmapNR().bitmapData;
    private static const bitmapNC:Class = BattleChatInput_bitmapNC;
    private static const bgNC:BitmapData = new bitmapNC().bitmapData;
    private static const bitmapNL:Class = BattleChatInput_bitmapNL;
    private static const bgNL:BitmapData = new bitmapNL().bitmapData;
    private static const bitmapSL:Class = BattleChatInput_bitmapSL;
    private static const bgSL:BitmapData = new bitmapSL().bitmapData;
    private static const bitmapSC:Class = BattleChatInput_bitmapSC;
    private static const bgSC:BitmapData = new bitmapSC().bitmapData;
    private static const bitmapSR:Class = BattleChatInput_bitmapSR;
    private static const bgSR:BitmapData = new bitmapSR().bitmapData;

    private const format:TextFormat = TanksFontService.getTextFormat(12);

    private var bg:Sprite = new Sprite();
    private var l:Shape = new Shape();
    private var c:Shape = new Shape();
    private var r:Shape = new Shape();
    private var bmpLeft:BitmapData;
    private var bmpCenter:BitmapData;
    private var bmpRight:BitmapData;

    public var channelLabel:Label;
    public var textField:TextField;

    private var _width:int;
    private var _height:int;

    public function BattleChatInput() {
      super();
      this.bmpLeft = bgBL;
      this.bmpRight = bgBR;
      this.bmpCenter = bgBC;
      addChild(this.bg);
      this.bg.addChild(this.l);
      this.bg.addChild(this.c);
      this.bg.addChild(this.r);
      this.channelLabel = new Label();
      this.channelLabel.text = "Команде:";
      this.channelLabel.x = 3;
      this.channelLabel.y = 7;
      this.channelLabel.tabEnabled = false;
      this.channelLabel.antiAliasType = AntiAliasType.ADVANCED;
      this.channelLabel.thickness = 150;
      this.channelLabel.sharpness = 200;
      addChild(this.channelLabel);
      var local1:String = Capabilities.version;
      var local2:RegExp = /^(\w*) (\d*),(\d*),(\d*),(\d*)$/;
      var local3:Object = local2.exec(local1);
      if(local3 != null && Number(local3[2] + "." + local3[3]) < 10.1) {
        this.textField = new TextFieldUtf8Base();
      } else {
        this.textField = new TextField();
      }
      addChild(this.textField);
      this.format.color = 14540253;
      this.textField.tabEnabled = false;
      this.textField.defaultTextFormat = this.format;
      this.textField.antiAliasType = AntiAliasType.ADVANCED;
      this.textField.thickness = 150;
      this.textField.sharpness = 200;
      this.textField.gridFitType = GridFitType.PIXEL;
      this.textField.embedFonts = TanksFontService.isEmbedFonts();
      this.textField.type = TextFieldType.INPUT;
      this.textField.x = this.channelLabel.width + 6;
      this.textField.y = 7;
      this.textField.height = 20;
      this.textField.addEventListener(Event.CHANGE,this.sendEvent);
      this.width = 212;
      tabEnabled = false;
      tabChildren = false;
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.textField.width = this._width - 6;
      this.draw();
    }

    override public function set height(param1:Number) : void {
      this._height = int(param1);
      this.draw();
    }

    public function set align(param1:String) : void {
      this.format.align = param1;
      this.updateformat();
    }

    private function updateformat() : void {
      this.textField.defaultTextFormat = this.format;
      this.textField.setTextFormat(this.format);
    }

    public function clear() : void {
      this.textField.text = "";
    }

    public function get value() : String {
      return this.textField.text;
    }

    public function set value(param1:String) : void {
      this.textField.text = param1;
    }

    private function sendEvent(param1:Event) : void {
      dispatchEvent(new LoginFormEvent(LoginFormEvent.TEXT_CHANGED));
    }

    public function hide(param1:Event) : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.hide);
      this.textField.removeEventListener(TextEvent.TEXT_INPUT,this.sendEvent);
    }

    private function draw() : void {
      var local1:Graphics = null;
      local1 = this.l.graphics;
      local1.clear();
      local1.beginBitmapFill(this.bmpLeft);
      local1.drawRect(0,0,5,30);
      local1.endFill();
      this.l.x = 0;
      this.l.y = 0;
      local1 = this.c.graphics;
      local1.clear();
      local1.beginBitmapFill(this.bmpCenter);
      local1.drawRect(0,0,this._width - 10,30);
      local1.endFill();
      this.c.x = 5;
      this.c.y = 0;
      local1 = this.r.graphics;
      local1.clear();
      local1.beginBitmapFill(this.bmpRight);
      local1.drawRect(0,0,5,30);
      local1.endFill();
      this.r.x = this._width - 5;
      this.r.y = 0;
    }

    public function setInputType(param1:ChatInputType) : void {
      switch(param1) {
        case ChatInputType.BLUE:
          this.bmpLeft = bgBL;
          this.bmpRight = bgBR;
          this.bmpCenter = bgBC;
          this.channelLabel.textColor = ColorConstants.USER_TITLE_BLUE;
          this.textField.textColor = MessageColor.BLUE;
          break;
        case ChatInputType.RED:
          this.bmpLeft = bgRL;
          this.bmpRight = bgRR;
          this.bmpCenter = bgRC;
          this.channelLabel.textColor = ColorConstants.USER_TITLE_RED;
          this.textField.textColor = MessageColor.RED;
          break;
        case ChatInputType.STANDART:
          this.bmpLeft = bgNL;
          this.bmpRight = bgNR;
          this.bmpCenter = bgNC;
          this.channelLabel.textColor = MessageColor.WHITE;
          this.textField.textColor = MessageColor.WHITE;
          break;
        case ChatInputType.YELLOW:
          this.bmpLeft = bgSL;
          this.bmpRight = bgSR;
          this.bmpCenter = bgSC;
          this.channelLabel.textColor = 16776960;
          this.textField.textColor = MessageColor.YELLOW;
      }
      this.draw();
    }

    public function setChannelText(param1:String) : void {
      this.channelLabel.text = param1 + ":";
      this.textField.x = this.channelLabel.width + 6;
      this.textField.width = this._width - this.channelLabel.width - 9;
    }
  }
}
