package utils {
  import alternativa.osgi.service.command.FormattedOutput;
  import alternativa.osgi.service.display.IDisplay;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.ui.Keyboard;
  import flash.utils.clearInterval;
  import flash.utils.setInterval;

  public class GUIDebugger {
    [Inject]
    public static var display:IDisplay;

    private static var isGuiDebugEnabled:Boolean = false;
    private static var isAutoClickEnabled:Boolean = false;
    private static var clickId:int = -1;
    private static var bounds:Sprite = new Sprite();
    private static var object:DisplayObject = null;
    private static var visibleStack:Vector.<DisplayObject> = new Vector.<DisplayObject>();
    private static var parentStack:Vector.<DisplayObject> = new Vector.<DisplayObject>();

    public function GUIDebugger() {
      super();
    }

    public static function debug(param1:FormattedOutput) : void {
      isGuiDebugEnabled = !isGuiDebugEnabled;
      if(isGuiDebugEnabled) {
        display.stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
        display.stage.addChild(bounds);
        display.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
      } else {
        display.stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
        display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown);
        display.stage.removeChild(bounds);
      }
      if(param1 != null) {
        param1.addText(" GUI DEBUG: " + (isGuiDebugEnabled ? "enabled" : "disabled"));
      }
    }

    public static function autoClick(param1:FormattedOutput) : void {
      isAutoClickEnabled = !isAutoClickEnabled;
      if(isAutoClickEnabled) {
        display.stage.focus = display.stage;
        display.stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveForClickHandler);
        display.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
        display.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
      } else {
        if(clickId != -1) {
          clearInterval(clickId);
        }
        display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
        display.stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp);
        display.stage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMoveForClickHandler);
      }
      if(param1 != null) {
        param1.addText(" AutoClick: " + (isAutoClickEnabled ? "enabled" : "disabled"));
      }
    }

    private static function mouseMoveForClickHandler(param1:MouseEvent) : void {
      if(param1.target != display.stage) {
        object = param1.target as DisplayObject;
      }
    }

    private static function mouseMove(param1:MouseEvent) : void {
      if(param1.target != display.stage) {
        if(parentStack.length > 0) {
          parentStack = new Vector.<DisplayObject>();
        }
        drawBounds(param1.target as DisplayObject);
      }
    }

    private static function drawBounds(param1:DisplayObject) : void {
      object = param1;
      var local2:Point = object.localToGlobal(new Point(0,0));
      var local3:Rectangle = new Rectangle(local2.x,local2.y,object.width,object.height);
      bounds.mouseEnabled = false;
      bounds.graphics.clear();
      bounds.graphics.beginFill(11149858,0.6);
      bounds.graphics.drawRect(local3.x,local3.y,local3.width,local3.height);
      bounds.graphics.endFill();
      bounds.removeChildren();
      createTextFields(object);
    }

    private static function onKeyDown(param1:KeyboardEvent) : void {
      if(param1.keyCode == Keyboard.G) {
        if(clickId != -1) {
          clearInterval(clickId);
        }
        clickId = setInterval(doClick,5);
      }
    }

    private static function onKeyUp(param1:KeyboardEvent) : void {
      if(param1.keyCode == Keyboard.G) {
        if(clickId != -1) {
          clearInterval(clickId);
        }
      }
    }

    private static function doClick() : void {
      if(object == null) {
        return;
      }
      var local1:MouseEvent = new MouseEvent(MouseEvent.CLICK);
      setPosition(local1,object.mouseX,object.mouseY);
      object.dispatchEvent(local1);
    }

    private static function setPosition(param1:MouseEvent, param2:int, param3:int) : void {
      param1.localX = param2;
      param1.localY = param3;
    }

    private static function keyDown(param1:KeyboardEvent) : void {
      var local2:DisplayObject = null;
      var local3:String = null;
      if(param1.keyCode == Keyboard.DOWN) {
        if(visibleStack.length > 0) {
          object = visibleStack.pop();
        }
      }
      if(object == null) {
        return;
      }
      switch(param1.keyCode) {
        case Keyboard.PAGE_UP:
          if(parentStack.length > 0) {
            object = parentStack.pop();
          }
          break;
        case Keyboard.PAGE_DOWN:
          if(object.parent != null) {
            parentStack.push(object);
            object = object.parent;
          }
          break;
        case Keyboard.P:
          local2 = object;
          local3 = "object";
          while(local2 != null) {
            local3 += ".parent";
            local2 = local2.parent;
          }
          break;
        case Keyboard.SPACE:
          break;
        case Keyboard.EQUAL:
          object.visible = false;
          visibleStack.push(object);
          break;
        case Keyboard.MINUS:
          object.visible = true;
          break;
        case Keyboard.DOWN:
          object.y += 1;
          break;
        case Keyboard.UP:
          object.y -= 1;
          break;
        case Keyboard.LEFT:
          object.x -= 1;
          break;
        case Keyboard.RIGHT:
          object.x += 1;
          break;
        case Keyboard.NUMPAD_4:
          object.width -= 1;
          break;
        case Keyboard.NUMPAD_6:
          object.width += 1;
          break;
        case Keyboard.NUMPAD_8:
          object.height -= 1;
          break;
        case Keyboard.NUMPAD_2:
          object.height += 1;
          break;
        case Keyboard.ESCAPE:
          debug(null);
      }
      drawBounds(object);
    }

    private static function createTextFields(param1:DisplayObject) : void {
      var local3:TextField = null;
      var local2:Point = param1.localToGlobal(new Point(0,0));
      local3 = new TextField();
      local3.mouseEnabled = false;
      local3.autoSize = TextFieldAutoSize.LEFT;
      local3.selectable = false;
      local3.textColor = 16776960;
      local3.text = "(" + local2.x.toString() + ", " + local2.y.toString() + ")";
      local3.x = local2.x - local3.width / 2;
      local3.y = local2.y - local3.height / 2;
      bounds.addChild(local3);
      local3 = new TextField();
      local3.mouseEnabled = false;
      local3.autoSize = TextFieldAutoSize.LEFT;
      local3.selectable = false;
      local3.textColor = 16776960;
      local3.text = "(" + (local2.x + param1.width).toString() + ", " + (local2.y + param1.height).toString() + ")";
      local3.x = local2.x + param1.width - local3.width / 2;
      local3.y = local2.y + param1.height - local3.height / 2;
      bounds.addChild(local3);
      local3 = new TextField();
      local3.mouseEnabled = false;
      local3.autoSize = TextFieldAutoSize.LEFT;
      local3.selectable = false;
      local3.textColor = 16776960;
      local3.text = param1.width.toString() + " x " + param1.height.toString();
      local3.x = local2.x + param1.width / 2 - local3.width / 2;
      local3.y = local2.y + param1.height / 2 - local3.height / 2;
      bounds.addChild(local3);
    }
  }
}
