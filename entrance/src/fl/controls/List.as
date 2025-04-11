package fl.controls {
  import fl.controls.listClasses.ICellRenderer;
  import fl.controls.listClasses.ListData;
  import fl.core.InvalidationType;
  import fl.core.UIComponent;
  import fl.managers.IFocusManagerComponent;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.geom.Rectangle;
  import flash.ui.Keyboard;
  import flash.utils.Dictionary;

  [Embed(source="/_assets/assets.swf", symbol="symbol50")]
  public class List extends SelectableList implements IFocusManagerComponent {
    public static var createAccessibilityImplementation:Function;

    private static var defaultStyles:Object = {
      "focusRectSkin":null,
      "focusRectPadding":null
    };

    protected var _iconField:String = "icon";
    protected var _labelField:String = "label";
    protected var _iconFunction:Function;
    protected var _rowHeight:Number = 20;
    protected var _cellRenderer:Object;
    protected var _labelFunction:Function;

    public function List() {
      super();
    }

    public static function getStyleDefinition() : Object {
      return mergeStyles(defaultStyles,SelectableList.getStyleDefinition());
    }

    public function get iconField() : String {
      return _iconField;
    }

    public function set iconField(param1:String) : void {
      if(param1 == _iconField) {
        return;
      }
      _iconField = param1;
      invalidate(InvalidationType.DATA);
    }

    public function set labelField(param1:String) : void {
      if(param1 == _labelField) {
        return;
      }
      _labelField = param1;
      invalidate(InvalidationType.DATA);
    }

    public function set rowHeight(param1:Number) : void {
      _rowHeight = param1;
      invalidate(InvalidationType.SIZE);
    }

    override protected function draw() : void {
      var local1:Boolean = contentHeight != rowHeight * length;
      contentHeight = rowHeight * length;
      if(isInvalid(InvalidationType.STYLES)) {
        setStyles();
        drawBackground();
        if(contentPadding != getStyleValue("contentPadding")) {
          invalidate(InvalidationType.SIZE,false);
        }
        if(_cellRenderer != getStyleValue("cellRenderer")) {
          _invalidateList();
          _cellRenderer = getStyleValue("cellRenderer");
        }
      }
      if(isInvalid(InvalidationType.SIZE,InvalidationType.STATE) || local1) {
        drawLayout();
      }
      if(isInvalid(InvalidationType.RENDERER_STYLES)) {
        updateRendererStyles();
      }
      if(isInvalid(InvalidationType.STYLES,InvalidationType.SIZE,InvalidationType.DATA,InvalidationType.SCROLL,InvalidationType.SELECTED)) {
        drawList();
      }
      updateChildren();
      validate();
    }

    override public function get rowCount() : uint {
      return Math.ceil(calculateAvailableHeight() / rowHeight);
    }

    override protected function configUI() : void {
      useFixedHorizontalScrolling = true;
      _horizontalScrollPolicy = ScrollPolicy.AUTO;
      _verticalScrollPolicy = ScrollPolicy.AUTO;
      super.configUI();
    }

    public function set labelFunction(param1:Function) : void {
      if(_labelFunction == param1) {
        return;
      }
      _labelFunction = param1;
      invalidate(InvalidationType.DATA);
    }

    override public function scrollToIndex(param1:int) : void {
      drawNow();
      var local2:uint = Math.floor((_verticalScrollPosition + availableHeight) / rowHeight) - 1;
      var local3:uint = Math.ceil(_verticalScrollPosition / rowHeight);
      if(param1 < local3) {
        verticalScrollPosition = param1 * rowHeight;
      } else if(param1 > local2) {
        verticalScrollPosition = (param1 + 1) * rowHeight - availableHeight;
      }
    }

    override protected function moveSelectionHorizontally(param1:uint, param2:Boolean, param3:Boolean) : void {
    }

    override protected function setHorizontalScrollPosition(param1:Number, param2:Boolean = false) : void {
      list.x = -param1;
      super.setHorizontalScrollPosition(param1,true);
    }

    override protected function moveSelectionVertically(param1:uint, param2:Boolean, param3:Boolean) : void {
      var local4:int = Math.max(Math.floor(calculateAvailableHeight() / rowHeight),1);
      var local5:int = -1;
      var local6:int = 0;
      switch(param1) {
        case Keyboard.UP:
          if(caretIndex > 0) {
            local5 = caretIndex - 1;
          }
          break;
        case Keyboard.DOWN:
          if(caretIndex < length - 1) {
            local5 = caretIndex + 1;
          }
          break;
        case Keyboard.PAGE_UP:
          if(caretIndex > 0) {
            local5 = Math.max(caretIndex - local4,0);
          }
          break;
        case Keyboard.PAGE_DOWN:
          if(caretIndex < length - 1) {
            local5 = Math.min(caretIndex + local4,length - 1);
          }
          break;
        case Keyboard.HOME:
          if(caretIndex > 0) {
            local5 = 0;
          }
          break;
        case Keyboard.END:
          if(caretIndex < length - 1) {
            local5 = length - 1;
          }
      }
      if(local5 >= 0) {
        doKeySelection(local5,param2,param3);
        scrollToSelected();
      }
    }

    protected function doKeySelection(param1:int, param2:Boolean, param3:Boolean) : void {
      var local5:int = 0;
      var local6:Array = null;
      var local7:int = 0;
      var local8:int = 0;
      var local4:Boolean = false;
      if(param2) {
        local6 = [];
        local7 = lastCaretIndex;
        local8 = param1;
        if(local7 == -1) {
          local7 = caretIndex != -1 ? caretIndex : param1;
        }
        if(local7 > local8) {
          local8 = local7;
          local7 = param1;
        }
        local5 = local7;
        while(local5 <= local8) {
          local6.push(local5);
          local5++;
        }
        selectedIndices = local6;
        caretIndex = param1;
        local4 = true;
      } else {
        selectedIndex = param1;
        caretIndex = lastCaretIndex = param1;
        local4 = true;
      }
      if(local4) {
        dispatchEvent(new Event(Event.CHANGE));
      }
      invalidate(InvalidationType.DATA);
    }

    public function get rowHeight() : Number {
      return _rowHeight;
    }

    override protected function initializeAccessibility() : void {
      if(List.createAccessibilityImplementation != null) {
        List.createAccessibilityImplementation(this);
      }
    }

    public function get labelField() : String {
      return _labelField;
    }

    public function set iconFunction(param1:Function) : void {
      if(_iconFunction == param1) {
        return;
      }
      _iconFunction = param1;
      invalidate(InvalidationType.DATA);
    }

    public function set rowCount(param1:uint) : void {
      var local2:Number = Number(getStyleValue("contentPadding"));
      var local3:Number = _horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO && _maxHorizontalScrollPosition > 0 ? 15 : 0;
      height = rowHeight * param1 + 2 * local2 + local3;
    }

    public function get labelFunction() : Function {
      return _labelFunction;
    }

    override protected function setVerticalScrollPosition(param1:Number, param2:Boolean = false) : void {
      invalidate(InvalidationType.SCROLL);
      super.setVerticalScrollPosition(param1,true);
    }

    override protected function drawList() : void {
      var local4:uint = 0;
      var local5:Object = null;
      var local6:ICellRenderer = null;
      var local9:Boolean = false;
      var local10:String = null;
      var local11:Object = null;
      var local12:Sprite = null;
      var local13:String = null;
      listHolder.x = listHolder.y = contentPadding;
      var local1:Rectangle = listHolder.scrollRect;
      local1.x = _horizontalScrollPosition;
      local1.y = Math.floor(_verticalScrollPosition) % rowHeight;
      listHolder.scrollRect = local1;
      listHolder.cacheAsBitmap = useBitmapScrolling;
      var local2:uint = Math.floor(_verticalScrollPosition / rowHeight);
      var local3:uint = Math.min(length,local2 + rowCount + 1);
      var local7:Dictionary = renderedItems = new Dictionary(true);
      local4 = local2;
      while(local4 < local3) {
        local7[_dataProvider.getItemAt(local4)] = true;
        local4++;
      }
      var local8:Dictionary = new Dictionary(true);
      while(activeCellRenderers.length > 0) {
        local6 = activeCellRenderers.pop() as ICellRenderer;
        local5 = local6.data;
        if(local7[local5] == null || invalidItems[local5] == true) {
          availableCellRenderers.push(local6);
        } else {
          local8[local5] = local6;
          invalidItems[local5] = true;
        }
        list.removeChild(local6 as DisplayObject);
      }
      invalidItems = new Dictionary(true);
      local4 = local2;
      while(local4 < local3) {
        local9 = false;
        local5 = _dataProvider.getItemAt(local4);
        if(local8[local5] != null) {
          local9 = true;
          local6 = local8[local5];
          delete local8[local5];
        } else if(availableCellRenderers.length > 0) {
          local6 = availableCellRenderers.pop() as ICellRenderer;
        } else {
          local6 = getDisplayObjectInstance(getStyleValue("cellRenderer")) as ICellRenderer;
          local12 = local6 as Sprite;
          if(local12 != null) {
            local12.addEventListener(MouseEvent.CLICK,handleCellRendererClick,false,0,true);
            local12.addEventListener(MouseEvent.ROLL_OVER,handleCellRendererMouseEvent,false,0,true);
            local12.addEventListener(MouseEvent.ROLL_OUT,handleCellRendererMouseEvent,false,0,true);
            local12.addEventListener(Event.CHANGE,handleCellRendererChange,false,0,true);
            local12.doubleClickEnabled = true;
            local12.addEventListener(MouseEvent.DOUBLE_CLICK,handleCellRendererDoubleClick,false,0,true);
            if(local12.hasOwnProperty("setStyle")) {
              for(local13 in rendererStyles) {
                local12["setStyle"](local13,rendererStyles[local13]);
              }
            }
          }
        }
        list.addChild(local6 as Sprite);
        activeCellRenderers.push(local6);
        local6.y = rowHeight * (local4 - local2);
        local6.setSize(availableWidth + _maxHorizontalScrollPosition,rowHeight);
        local10 = itemToLabel(local5);
        local11 = null;
        if(_iconFunction != null) {
          local11 = _iconFunction(local5);
        } else if(_iconField != null) {
          local11 = local5[_iconField];
        }
        if(!local9) {
          local6.data = local5;
        }
        local6.listData = new ListData(local10,local11,this,local4,local4,0);
        local6.selected = _selectedIndices.indexOf(local4) != -1;
        if(local6 is UIComponent) {
          (local6 as UIComponent).drawNow();
        }
        local4++;
      }
    }

    override protected function keyDownHandler(param1:KeyboardEvent) : void {
      var local2:int = 0;
      if(!selectable) {
        return;
      }
      switch(param1.keyCode) {
        case Keyboard.UP:
        case Keyboard.DOWN:
        case Keyboard.END:
        case Keyboard.HOME:
        case Keyboard.PAGE_UP:
        case Keyboard.PAGE_DOWN:
          moveSelectionVertically(param1.keyCode,param1.shiftKey && _allowMultipleSelection,param1.ctrlKey && _allowMultipleSelection);
          break;
        case Keyboard.LEFT:
        case Keyboard.RIGHT:
          moveSelectionHorizontally(param1.keyCode,param1.shiftKey && _allowMultipleSelection,param1.ctrlKey && _allowMultipleSelection);
          break;
        case Keyboard.SPACE:
          if(caretIndex == -1) {
            caretIndex = 0;
          }
          doKeySelection(caretIndex,param1.shiftKey,param1.ctrlKey);
          scrollToSelected();
          break;
        default:
          local2 = getNextIndexAtLetter(String.fromCharCode(param1.keyCode),selectedIndex);
          if(local2 > -1) {
            selectedIndex = local2;
            scrollToSelected();
          }
      }
      param1.stopPropagation();
    }

    public function get iconFunction() : Function {
      return _iconFunction;
    }

    override public function itemToLabel(param1:Object) : String {
      if(_labelFunction != null) {
        return String(_labelFunction(param1));
      }
      return param1[_labelField] != null ? String(param1[_labelField]) : "";
    }

    protected function calculateAvailableHeight() : Number {
      var local1:Number = Number(getStyleValue("contentPadding"));
      return height - local1 * 2 - (_horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO && _maxHorizontalScrollPosition > 0 ? 15 : 0);
    }
  }
}
