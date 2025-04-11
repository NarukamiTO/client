package fl.controls {
  import fl.core.InvalidationType;
  import fl.core.UIComponent;
  import fl.managers.IFocusManagerComponent;
  import flash.display.DisplayObject;

  [Style(name="emphasizedPadding",type="Number",format="Length")]
  [Style(name="emphasizedSkin",type="Class")]
  [Embed(source="/_assets/assets.swf", symbol="symbol810")]
  public class Button extends LabelButton implements IFocusManagerComponent {
    public static var createAccessibilityImplementation:Function;

    private static var defaultStyles:Object = {
      "emphasizedSkin":"Button_emphasizedSkin",
      "emphasizedPadding":2
    };

    protected var _emphasized:Boolean = false;
    protected var emphasizedBorder:DisplayObject;

    public function Button() {
      super();
    }

    public static function getStyleDefinition() : Object {
      return UIComponent.mergeStyles(LabelButton.getStyleDefinition(),defaultStyles);
    }

    public function set emphasized(param1:Boolean) : void {
      _emphasized = param1;
      invalidate(InvalidationType.STYLES);
    }

    override protected function initializeAccessibility() : void {
      if(Button.createAccessibilityImplementation != null) {
        Button.createAccessibilityImplementation(this);
      }
    }

    protected function drawEmphasized() : void {
      var local2:Number = NaN;
      if(emphasizedBorder != null) {
        removeChild(emphasizedBorder);
      }
      emphasizedBorder = null;
      if(!_emphasized) {
        return;
      }
      var local1:Object = getStyleValue("emphasizedSkin");
      if(local1 != null) {
        emphasizedBorder = getDisplayObjectInstance(local1);
      }
      if(emphasizedBorder != null) {
        addChildAt(emphasizedBorder,0);
        local2 = Number(getStyleValue("emphasizedPadding"));
        emphasizedBorder.x = emphasizedBorder.y = -local2;
        emphasizedBorder.width = width + local2 * 2;
        emphasizedBorder.height = height + local2 * 2;
      }
    }

    [Inspectable(defaultValue="false")]
    public function get emphasized() : Boolean {
      return _emphasized;
    }

    override protected function draw() : void {
      if(isInvalid(InvalidationType.STYLES) || isInvalid(InvalidationType.SIZE)) {
        drawEmphasized();
      }
      super.draw();
      if(emphasizedBorder != null) {
        setChildIndex(emphasizedBorder,numChildren - 1);
      }
    }

    override public function drawFocus(param1:Boolean) : void {
      var local2:Number = NaN;
      var local3:* = undefined;
      super.drawFocus(param1);
      if(param1) {
        local2 = Number(getStyleValue("emphasizedPadding"));
        if(local2 < 0 || !_emphasized) {
          local2 = 0;
        }
        local3 = getStyleValue("focusRectPadding");
        local3 = local3 == null ? 2 : local3;
        local3 += local2;
        uiFocusRect.x = -local3;
        uiFocusRect.y = -local3;
        uiFocusRect.width = width + local3 * 2;
        uiFocusRect.height = height + local3 * 2;
      }
    }
  }
}
