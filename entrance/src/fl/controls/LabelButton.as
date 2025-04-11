package fl.controls {
  import fl.core.InvalidationType;
  import fl.core.UIComponent;
  import fl.events.ComponentEvent;
  import fl.managers.IFocusManagerComponent;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import flash.text.TextFieldType;
  import flash.text.TextFormat;
  import flash.ui.Keyboard;

  [Style(name="embedFonts",type="Boolean")]
  [Style(name="selectedOverIcon",type="Class")]
  [Style(name="selectedDownIcon",type="Class")]
  [Style(name="selectedUpIcon",type="Class")]
  [Style(name="selectedDisabledIcon",type="Class")]
  [Style(name="disabledIcon",type="Class")]
  [Style(name="overIcon",type="Class")]
  [Style(name="downIcon",type="Class")]
  [Style(name="upIcon",type="Class")]
  [Style(name="icon",type="Class")]
  [Style(name="repeatInterval",type="Number",format="Time")]
  [Style(name="repeatDelay",type="Number",format="Time")]
  [Style(name="textPadding",type="Number",format="Length")]
  [Style(name="selectedOverSkin",type="Class")]
  [Style(name="selectedDownSkin",type="Class")]
  [Style(name="selectedUpSkin",type="Class")]
  [Style(name="selectedDisabledSkin",type="Class")]
  [Style(name="overSkin",type="Class")]
  [Style(name="downSkin",type="Class")]
  [Style(name="upSkin",type="Class")]
  [Style(name="disabledSkin",type="Class")]
  [Event(name="labelChange",type="fl.events.ComponentEvent")]
  [Event(name="click",type="flash.events.MouseEvent")]
  public class LabelButton extends BaseButton implements IFocusManagerComponent {
    public static var createAccessibilityImplementation:Function;

    private static var defaultStyles:Object = {
      "icon":null,
      "upIcon":null,
      "downIcon":null,
      "overIcon":null,
      "disabledIcon":null,
      "selectedDisabledIcon":null,
      "selectedUpIcon":null,
      "selectedDownIcon":null,
      "selectedOverIcon":null,
      "textFormat":null,
      "disabledTextFormat":null,
      "textPadding":5,
      "embedFonts":false
    };

    protected var _toggle:Boolean = false;

    public var textField:TextField;

    protected var mode:String = "center";
    protected var _labelPlacement:String = "right";
    protected var oldMouseState:String;
    protected var _label:String = "Label";
    protected var icon:DisplayObject;

    public function LabelButton() {
      super();
    }

    public static function getStyleDefinition() : Object {
      return mergeStyles(defaultStyles,BaseButton.getStyleDefinition());
    }

    override protected function draw() : void {
      if(textField.text != _label) {
        label = _label;
      }
      if(isInvalid(InvalidationType.STYLES,InvalidationType.STATE)) {
        drawBackground();
        drawIcon();
        drawTextFormat();
        invalidate(InvalidationType.SIZE,false);
      }
      if(isInvalid(InvalidationType.SIZE)) {
        drawLayout();
      }
      if(isInvalid(InvalidationType.SIZE,InvalidationType.STYLES)) {
        if(isFocused && Boolean(focusManager.showFocusIndicator)) {
          drawFocus(true);
        }
      }
      validate();
    }

    override protected function drawLayout() : void {
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local1:Number = Number(getStyleValue("textPadding"));
      var local2:String = icon == null && mode == "center" ? ButtonLabelPlacement.TOP : _labelPlacement;
      textField.height = textField.textHeight + 4;
      var local3:Number = textField.textWidth + 4;
      var local4:Number = textField.textHeight + 4;
      var local5:Number = icon == null ? 0 : icon.width + local1;
      var local6:Number = icon == null ? 0 : icon.height + local1;
      textField.visible = label.length > 0;
      if(icon != null) {
        icon.x = Math.round((width - icon.width) / 2);
        icon.y = Math.round((height - icon.height) / 2);
      }
      if(textField.visible == false) {
        textField.width = 0;
        textField.height = 0;
      } else if(local2 == ButtonLabelPlacement.BOTTOM || local2 == ButtonLabelPlacement.TOP) {
        local7 = Math.max(0,Math.min(local3,width - 2 * local1));
        if(height - 2 > local4) {
          local8 = local4;
        } else {
          local8 = height - 2;
        }
        textField.width = local3 = local7;
        textField.height = local4 = local8;
        textField.x = Math.round((width - local3) / 2);
        textField.y = Math.round((height - textField.height - local6) / 2 + (local2 == ButtonLabelPlacement.BOTTOM ? local6 : 0));
        if(icon != null) {
          icon.y = Math.round(local2 == ButtonLabelPlacement.BOTTOM ? textField.y - local6 : textField.y + textField.height + local1);
        }
      } else {
        local7 = Math.max(0,Math.min(local3,width - local5 - 2 * local1));
        textField.width = local3 = local7;
        textField.x = Math.round((width - local3 - local5) / 2 + (local2 != ButtonLabelPlacement.LEFT ? local5 : 0));
        textField.y = Math.round((height - textField.height) / 2);
        if(icon != null) {
          icon.x = Math.round(local2 != ButtonLabelPlacement.LEFT ? textField.x - local5 : textField.x + local3 + local1);
        }
      }
      super.drawLayout();
    }

    protected function toggleSelected(param1:MouseEvent) : void {
      selected = !selected;
      dispatchEvent(new Event(Event.CHANGE,true));
    }

    override protected function keyUpHandler(param1:KeyboardEvent) : void {
      if(!enabled) {
        return;
      }
      if(param1.keyCode == Keyboard.SPACE) {
        setMouseState(oldMouseState);
        oldMouseState = null;
        endPress();
        dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
    }

    [Inspectable(enumeration="left,right,top,bottom",defaultValue="right",name="labelPlacement")]
    public function get labelPlacement() : String {
      return _labelPlacement;
    }

    [Inspectable(defaultValue="false")]
    public function get toggle() : Boolean {
      return _toggle;
    }

    protected function setEmbedFont() : * {
      var local1:Object = getStyleValue("embedFonts");
      if(local1 != null) {
        textField.embedFonts = local1;
      }
    }

    [Inspectable(defaultValue="false")]
    override public function get selected() : Boolean {
      return _toggle ? _selected : false;
    }

    override protected function configUI() : void {
      super.configUI();
      textField = new TextField();
      textField.type = TextFieldType.DYNAMIC;
      textField.selectable = false;
      addChild(textField);
    }

    override protected function initializeAccessibility() : void {
      if(LabelButton.createAccessibilityImplementation != null) {
        LabelButton.createAccessibilityImplementation(this);
      }
    }

    public function set labelPlacement(param1:String) : void {
      _labelPlacement = param1;
      invalidate(InvalidationType.SIZE);
    }

    protected function drawIcon() : void {
      var local1:DisplayObject = icon;
      var local2:String = enabled ? mouseState : "disabled";
      if(selected) {
        local2 = "selected" + local2.substr(0,1).toUpperCase() + local2.substr(1);
      }
      local2 += "Icon";
      var local3:Object = getStyleValue(local2);
      if(local3 == null) {
        local3 = getStyleValue("icon");
      }
      if(local3 != null) {
        icon = getDisplayObjectInstance(local3);
      }
      if(icon != null) {
        addChildAt(icon,1);
      }
      if(local1 != null && local1 != icon) {
        removeChild(local1);
      }
    }

    public function set label(param1:String) : void {
      _label = param1;
      if(textField.text != _label) {
        textField.text = _label;
        dispatchEvent(new ComponentEvent(ComponentEvent.LABEL_CHANGE));
      }
      invalidate(InvalidationType.SIZE);
      invalidate(InvalidationType.STYLES);
    }

    override protected function keyDownHandler(param1:KeyboardEvent) : void {
      if(!enabled) {
        return;
      }
      if(param1.keyCode == Keyboard.SPACE) {
        if(oldMouseState == null) {
          oldMouseState = mouseState;
        }
        setMouseState("down");
        startPress();
      }
    }

    public function set toggle(param1:Boolean) : void {
      if(!param1 && super.selected) {
        selected = false;
      }
      _toggle = param1;
      if(_toggle) {
        addEventListener(MouseEvent.CLICK,toggleSelected,false,0,true);
      } else {
        removeEventListener(MouseEvent.CLICK,toggleSelected);
      }
      invalidate(InvalidationType.STATE);
    }

    override public function set selected(param1:Boolean) : void {
      _selected = param1;
      if(_toggle) {
        invalidate(InvalidationType.STATE);
      }
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
    }

    [Inspectable(defaultValue="Label")]
    public function get label() : String {
      return _label;
    }
  }
}
