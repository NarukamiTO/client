package fl.controls {
  import fl.core.InvalidationType;
  import fl.core.UIComponent;
  import fl.events.ComponentEvent;
  import fl.managers.IFocusManager;
  import fl.managers.IFocusManagerComponent;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.KeyboardEvent;
  import flash.events.TextEvent;
  import flash.text.TextField;
  import flash.text.TextFieldType;
  import flash.text.TextFormat;
  import flash.text.TextLineMetrics;
  import flash.ui.Keyboard;

  [Style(name="embedFonts",type="Boolean")]
  [Style(name="disabledSkin",type="Class")]
  [Style(name="textPadding",type="Number",format="Length")]
  [Style(name="upSkin",type="Class")]
  [Event(name="textInput",type="flash.events.TextEvent")]
  [Event(name="enter",type="fl.events.ComponentEvent")]
  [Event(name="change",type="flash.events.Event")]
  [Embed(source="/_assets/assets.swf", symbol="symbol85")]
  public class TextInput extends UIComponent implements IFocusManagerComponent {
    public static var createAccessibilityImplementation:Function;

    private static var defaultStyles:Object = {
      "upSkin":"TextInput_upSkin",
      "disabledSkin":"TextInput_disabledSkin",
      "focusRectSkin":null,
      "focusRectPadding":null,
      "textFormat":null,
      "disabledTextFormat":null,
      "textPadding":0,
      "embedFonts":false
    };

    protected var _html:Boolean = false;
    protected var background:DisplayObject;
    protected var _savedHTML:String;
    protected var _editable:Boolean = true;

    public var textField:TextField;

    public function TextInput() {
      super();
    }

    public static function getStyleDefinition() : Object {
      return defaultStyles;
    }

    public function set alwaysShowSelection(param1:Boolean) : void {
      textField.alwaysShowSelection = param1;
    }

    override public function set enabled(param1:Boolean) : void {
      super.enabled = param1;
      updateTextFieldType();
    }

    public function get imeMode() : String {
      return _imeMode;
    }

    protected function handleChange(param1:Event) : void {
      param1.stopPropagation();
      dispatchEvent(new Event(Event.CHANGE,true));
    }

    public function set imeMode(param1:String) : void {
      _imeMode = param1;
    }

    protected function setEmbedFont() : * {
      var local1:Object = getStyleValue("embedFonts");
      if(local1 != null) {
        textField.embedFonts = local1;
      }
    }

    protected function drawLayout() : void {
      var local1:Number = Number(getStyleValue("textPadding"));
      if(background != null) {
        background.width = width;
        background.height = height;
      }
      textField.width = width - 2 * local1;
      textField.height = height - 2 * local1;
      textField.x = textField.y = local1;
    }

    public function set condenseWhite(param1:Boolean) : void {
      textField.condenseWhite = param1;
    }

    public function get textWidth() : Number {
      return textField.textWidth;
    }

    override protected function focusOutHandler(param1:FocusEvent) : void {
      super.focusOutHandler(param1);
      if(editable) {
        setIMEMode(false);
      }
    }

    override public function setFocus() : void {
      stage.focus = textField;
    }

    public function set displayAsPassword(param1:Boolean) : void {
      textField.displayAsPassword = param1;
    }

    protected function drawBackground() : void {
      var local1:DisplayObject = background;
      var local2:String = enabled ? "upSkin" : "disabledSkin";
      background = getDisplayObjectInstance(getStyleValue(local2));
      if(background == null) {
        return;
      }
      addChildAt(background,0);
      if(local1 != null && local1 != background && contains(local1)) {
        removeChild(local1);
      }
    }

    [Inspectable(defaultValue="")]
    public function get text() : String {
      return textField.text;
    }

    public function set maxChars(param1:int) : void {
      textField.maxChars = param1;
    }

    public function set horizontalScrollPosition(param1:int) : void {
      textField.scrollH = param1;
    }

    override protected function isOurFocus(param1:DisplayObject) : Boolean {
      return param1 == textField || super.isOurFocus(param1);
    }

    public function get textHeight() : Number {
      return textField.textHeight;
    }

    [Inspectable(defaultValue="")]
    public function get restrict() : String {
      return textField.restrict;
    }

    public function get alwaysShowSelection() : Boolean {
      return textField.alwaysShowSelection;
    }

    [Inspectable(defaultValue="true",verbose="1")]
    override public function get enabled() : Boolean {
      return super.enabled;
    }

    override protected function draw() : void {
      var local1:Object = null;
      if(isInvalid(InvalidationType.STYLES,InvalidationType.STATE)) {
        drawTextFormat();
        drawBackground();
        local1 = getStyleValue("embedFonts");
        if(local1 != null) {
          textField.embedFonts = local1;
        }
        invalidate(InvalidationType.SIZE,false);
      }
      if(isInvalid(InvalidationType.SIZE)) {
        drawLayout();
      }
      super.draw();
    }

    public function set editable(param1:Boolean) : void {
      _editable = param1;
      updateTextFieldType();
    }

    public function setSelection(param1:int, param2:int) : void {
      textField.setSelection(param1,param2);
    }

    public function get condenseWhite() : Boolean {
      return textField.condenseWhite;
    }

    [Inspectable(defaultValue="false")]
    public function get displayAsPassword() : Boolean {
      return textField.displayAsPassword;
    }

    public function get selectionBeginIndex() : int {
      return textField.selectionBeginIndex;
    }

    override protected function configUI() : void {
      super.configUI();
      tabChildren = true;
      textField = new TextField();
      addChild(textField);
      updateTextFieldType();
      textField.addEventListener(TextEvent.TEXT_INPUT,handleTextInput,false,0,true);
      textField.addEventListener(Event.CHANGE,handleChange,false,0,true);
      textField.addEventListener(KeyboardEvent.KEY_DOWN,handleKeyDown,false,0,true);
    }

    [Inspectable(defaultValue="0")]
    public function get maxChars() : int {
      return textField.maxChars;
    }

    public function set text(param1:String) : void {
      textField.text = param1;
      _html = false;
      invalidate(InvalidationType.DATA);
      invalidate(InvalidationType.STYLES);
    }

    protected function updateTextFieldType() : void {
      textField.type = enabled && editable ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
      textField.selectable = enabled;
    }

    protected function handleKeyDown(param1:KeyboardEvent) : void {
      if(param1.keyCode == Keyboard.ENTER) {
        dispatchEvent(new ComponentEvent(ComponentEvent.ENTER,true));
      }
    }

    public function get horizontalScrollPosition() : int {
      return textField.scrollH;
    }

    public function get selectionEndIndex() : int {
      return textField.selectionEndIndex;
    }

    [Inspectable(defaultValue="true")]
    public function get editable() : Boolean {
      return _editable;
    }

    public function get maxHorizontalScrollPosition() : int {
      return textField.maxScrollH;
    }

    public function appendText(param1:String) : void {
      textField.appendText(param1);
    }

    protected function drawTextFormat() : void {
      var local1:Object = UIComponent.getStyleDefinition();
      var local2:TextFormat = enabled ? local1.defaultTextFormat as TextFormat : local1.defaultDisabledTextFormat as TextFormat;
      textField.setTextFormat(local2);
      var local3:TextFormat = getStyleValue(enabled ? "textFormat" : "disabledTextFormat") as TextFormat;
      if(local3 != null) {
        textField.setTextFormat(local3);
      } else {
        local3 = local2;
      }
      textField.defaultTextFormat = local3;
      setEmbedFont();
      if(_html) {
        textField.htmlText = _savedHTML;
      }
    }

    public function get length() : int {
      return textField.length;
    }

    public function set htmlText(param1:String) : void {
      if(param1 == "") {
        text = "";
        return;
      }
      _html = true;
      _savedHTML = param1;
      textField.htmlText = param1;
      invalidate(InvalidationType.DATA);
      invalidate(InvalidationType.STYLES);
    }

    protected function handleTextInput(param1:TextEvent) : void {
      param1.stopPropagation();
      dispatchEvent(new TextEvent(TextEvent.TEXT_INPUT,true,false,param1.text));
    }

    public function set restrict(param1:String) : void {
      if(componentInspectorSetting && param1 == "") {
        param1 = null;
      }
      textField.restrict = param1;
    }

    public function getLineMetrics(param1:int) : TextLineMetrics {
      return textField.getLineMetrics(param1);
    }

    override public function drawFocus(param1:Boolean) : void {
      if(focusTarget != null) {
        focusTarget.drawFocus(param1);
        return;
      }
      super.drawFocus(param1);
    }

    override protected function focusInHandler(param1:FocusEvent) : void {
      if(param1.target == this) {
        stage.focus = textField;
      }
      var local2:IFocusManager = focusManager;
      if(editable && Boolean(local2)) {
        local2.showFocusIndicator = true;
        if(textField.selectable && textField.selectionBeginIndex == textField.selectionBeginIndex) {
          setSelection(0,textField.length);
        }
      }
      super.focusInHandler(param1);
      if(editable) {
        setIMEMode(true);
      }
    }

    public function get htmlText() : String {
      return textField.htmlText;
    }
  }
}
