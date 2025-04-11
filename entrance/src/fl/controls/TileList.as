package fl.controls {
  import fl.controls.listClasses.ICellRenderer;
  import fl.controls.listClasses.ImageCell;
  import fl.controls.listClasses.ListData;
  import fl.controls.listClasses.TileListData;
  import fl.core.InvalidationType;
  import fl.core.UIComponent;
  import fl.data.DataProvider;
  import fl.data.TileListCollectionItem;
  import fl.managers.IFocusManagerComponent;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.ui.Keyboard;
  import flash.utils.Dictionary;

  [Style(name="cellRenderer",type="Class")]
  [Style(name="skin",type="Class")]
  [Embed(source="/_assets/assets.swf", symbol="symbol286")]
  public class TileList extends SelectableList implements IFocusManagerComponent {
    public static var createAccessibilityImplementation:Function;

    private static var defaultStyles:Object = {
      "cellRenderer":ImageCell,
      "focusRectSkin":null,
      "focusRectPadding":null,
      "skin":"TileList_skin"
    };

    protected var _iconField:String = "icon";
    protected var _labelField:String = "label";
    protected var _rowHeight:Number = 50;
    protected var _cellRenderer:Object;
    protected var __rowCount:uint = 0;
    protected var _sourceFunction:Function;
    protected var _scrollPolicy:String = "auto";
    protected var _iconFunction:Function;
    protected var _columnWidth:Number = 50;

    private var collectionItemImport:TileListCollectionItem;

    protected var _sourceField:String = "source";
    protected var _scrollDirection:String = "horizontal";
    protected var oldLength:uint = 0;
    protected var __columnCount:uint = 0;
    protected var _labelFunction:Function;

    public function TileList() {
      super();
    }

    public static function getStyleDefinition() : Object {
      return mergeStyles(defaultStyles,SelectableList.getStyleDefinition(),ScrollBar.getStyleDefinition());
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

    override public function set verticalScrollPolicy(param1:String) : void {
    }

    override protected function drawLayout() : void {
      var local1:uint = 0;
      var local2:uint = 0;
      _horizontalScrollPolicy = _scrollDirection == ScrollBarDirection.HORIZONTAL ? _scrollPolicy : ScrollPolicy.OFF;
      _verticalScrollPolicy = _scrollDirection != ScrollBarDirection.HORIZONTAL ? _scrollPolicy : ScrollPolicy.OFF;
      if(_scrollDirection == ScrollBarDirection.HORIZONTAL) {
        local1 = rowCount;
        contentHeight = local1 * _rowHeight;
        contentWidth = _columnWidth * Math.ceil(length / local1);
      } else {
        local2 = columnCount;
        contentWidth = local2 * _columnWidth;
        contentHeight = _rowHeight * Math.ceil(length / local2);
      }
      super.drawLayout();
    }

    [Inspectable(defaultValue="50")]
    public function get columnWidth() : Number {
      return _columnWidth;
    }

    override public function scrollToIndex(param1:int) : void {
      var local3:Number = NaN;
      var local4:Number = NaN;
      drawNow();
      var local2:uint = Math.max(1,contentWidth / _columnWidth << 0);
      if(_scrollDirection == ScrollBarDirection.VERTICAL) {
        if(rowHeight > availableHeight) {
          return;
        }
        local3 = (param1 / local2 >> 0) * rowHeight;
        if(local3 < verticalScrollPosition) {
          verticalScrollPosition = local3;
        } else if(local3 > verticalScrollPosition + availableHeight - rowHeight) {
          verticalScrollPosition = local3 + rowHeight - availableHeight;
        }
      } else {
        if(columnWidth > availableWidth) {
          return;
        }
        local4 = param1 % local2 * columnWidth;
        if(local4 < horizontalScrollPosition) {
          horizontalScrollPosition = local4;
        } else if(local4 > horizontalScrollPosition + availableWidth - columnWidth) {
          horizontalScrollPosition = local4 + columnWidth - availableWidth;
        }
      }
    }

    public function get sourceFunction() : Function {
      return _sourceFunction;
    }

    public function get innerWidth() : Number {
      drawNow();
      var local1:Number = getStyleValue("contentPadding") as Number;
      return width - local1 * 2 - (_verticalScrollBar.visible ? _verticalScrollBar.width : 0);
    }

    protected function doKeySelection(param1:uint, param2:Boolean, param3:Boolean) : void {
      var local6:uint = 0;
      var local7:int = 0;
      var local4:Array = selectedIndices;
      var local5:Boolean = false;
      if(!(param1 < 0 || param1 > length - 1)) {
        if(param2 && local4.length > 0 && param1 != local4[0]) {
          local6 = uint(local4[0]);
          local4 = [];
          if(param1 < local6) {
            local7 = int(local6);
            while(local7 >= param1) {
              local4.push(local7);
              local7--;
            }
          } else {
            local7 = int(local6);
            while(local7 <= param1) {
              local4.push(local7);
              local7++;
            }
          }
          local5 = true;
        } else {
          local4 = [param1];
          caretIndex = param1;
          local5 = true;
        }
      }
      selectedIndices = local4;
      if(local5) {
        dispatchEvent(new Event(Event.CHANGE));
      }
      invalidate(InvalidationType.DATA);
    }

    protected function calculateAvailableHeight() : Number {
      var local1:Number = Number(getStyleValue("contentPadding"));
      return height - local1 * 2 - (_horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO && _maxHorizontalScrollPosition > 0 ? 15 : 0);
    }

    override protected function drawList() : void {
      var local1:uint = 0;
      var local2:uint = 0;
      var local3:Object = null;
      var local4:ICellRenderer = null;
      var local11:uint = 0;
      var local12:uint = 0;
      var local15:Dictionary = null;
      var local16:uint = 0;
      var local17:uint = 0;
      var local18:uint = 0;
      var local19:uint = 0;
      var local20:Boolean = false;
      var local21:String = null;
      var local22:Object = null;
      var local23:Object = null;
      var local24:Sprite = null;
      var local25:String = null;
      var local26:UIComponent = null;
      var local5:uint = rowCount;
      var local6:uint = columnCount;
      var local7:Number = columnWidth;
      var local8:Number = rowHeight;
      var local9:Number = 0;
      var local10:Number = 0;
      listHolder.x = listHolder.y = contentPadding;
      contentScrollRect = listHolder.scrollRect;
      contentScrollRect.x = Math.floor(_horizontalScrollPosition) % local7;
      contentScrollRect.y = Math.floor(_verticalScrollPosition) % local8;
      listHolder.scrollRect = contentScrollRect;
      listHolder.cacheAsBitmap = useBitmapScrolling;
      var local13:Array = [];
      if(_scrollDirection == ScrollBarDirection.HORIZONTAL) {
        local16 = uint(availableWidth / local7 << 0);
        local17 = Math.max(local16,Math.ceil(length / local5));
        local9 = _horizontalScrollPosition / local7 << 0;
        local6 = Math.max(local16,Math.min(local17 - local9,local6 + 1));
        local12 = 0;
        while(local12 < local5) {
          local11 = 0;
          while(local11 < local6) {
            local2 = local12 * local17 + local9 + local11;
            if(local2 >= length) {
              break;
            }
            local13.push(local2);
            local11++;
          }
          local12++;
        }
      } else {
        local5++;
        local10 = _verticalScrollPosition / local8 << 0;
        local18 = Math.floor(local10 * local6);
        local19 = Math.min(length,local18 + local5 * local6);
        local1 = local18;
        while(local1 < local19) {
          local13.push(local1);
          local1++;
        }
      }
      var local14:Dictionary = renderedItems = new Dictionary(true);
      for each(local2 in local13) {
        local14[_dataProvider.getItemAt(local2)] = true;
      }
      local15 = new Dictionary(true);
      while(activeCellRenderers.length > 0) {
        local4 = activeCellRenderers.pop();
        local3 = local4.data;
        if(local14[local3] == null || invalidItems[local3] == true) {
          availableCellRenderers.push(local4);
        } else {
          local15[local3] = local4;
          invalidItems[local3] = true;
        }
        list.removeChild(local4 as DisplayObject);
      }
      invalidItems = new Dictionary(true);
      local1 = 0;
      for each(local2 in local13) {
        local11 = local1 % local6;
        local12 = uint(local1 / local6 << 0);
        local20 = false;
        local3 = _dataProvider.getItemAt(local2);
        if(local15[local3] != null) {
          local20 = true;
          local4 = local15[local3];
          delete local15[local3];
        } else if(availableCellRenderers.length > 0) {
          local4 = availableCellRenderers.pop() as ICellRenderer;
        } else {
          local4 = getDisplayObjectInstance(getStyleValue("cellRenderer")) as ICellRenderer;
          local24 = local4 as Sprite;
          if(local24 != null) {
            local24.addEventListener(MouseEvent.CLICK,handleCellRendererClick,false,0,true);
            local24.addEventListener(MouseEvent.ROLL_OVER,handleCellRendererMouseEvent,false,0,true);
            local24.addEventListener(MouseEvent.ROLL_OUT,handleCellRendererMouseEvent,false,0,true);
            local24.addEventListener(Event.CHANGE,handleCellRendererChange,false,0,true);
            local24.doubleClickEnabled = true;
            local24.addEventListener(MouseEvent.DOUBLE_CLICK,handleCellRendererDoubleClick,false,0,true);
            if(local24["setStyle"] != null) {
              for(local25 in rendererStyles) {
                local24["setStyle"](local25,rendererStyles[local25]);
              }
            }
          }
        }
        list.addChild(local4 as Sprite);
        activeCellRenderers.push(local4);
        local4.y = local8 * local12;
        local4.x = local7 * local11;
        local4.setSize(columnWidth,rowHeight);
        local21 = itemToLabel(local3);
        local22 = null;
        if(_iconFunction != null) {
          local22 = _iconFunction(local3);
        } else if(_iconField != null) {
          local22 = local3[_iconField];
        }
        local23 = null;
        if(_sourceFunction != null) {
          local23 = _sourceFunction(local3);
        } else if(_sourceField != null) {
          local23 = local3[_sourceField];
        }
        if(!local20) {
          local4.data = local3;
        }
        local4.listData = new TileListData(local21,local22,local23,this,local2,local10 + local12,local9 + local11) as ListData;
        local4.selected = _selectedIndices.indexOf(local2) != -1;
        if(local4 is UIComponent) {
          local26 = local4 as UIComponent;
          local26.drawNow();
        }
        local1++;
      }
    }

    override protected function moveSelectionHorizontally(param1:uint, param2:Boolean, param3:Boolean) : void {
      var local4:uint = 0;
      var local5:int = 0;
      var local6:int = 0;
      var local7:* = undefined;
      local4 = Math.ceil(Math.max(rowCount * columnCount,length) / rowCount);
      switch(param1) {
        case Keyboard.LEFT:
          local5 = Math.max(0,selectedIndex - 1);
          break;
        case Keyboard.RIGHT:
          local5 = Math.min(length - 1,selectedIndex + 1);
          break;
        case Keyboard.HOME:
          local5 = 0;
          break;
        case Keyboard.END:
          local5 = length - 1;
          break;
        case Keyboard.PAGE_UP:
          local6 = selectedIndex - selectedIndex % local4;
          local5 = Math.max(0,Math.max(local6,selectedIndex - columnCount));
          break;
        case Keyboard.PAGE_DOWN:
          local7 = selectedIndex - selectedIndex % local4 + local4 - 1;
          local5 = Math.min(length - 1,Math.min(local7,selectedIndex + local4));
      }
      doKeySelection(local5,param2,param3);
      scrollToSelected();
    }

    public function get innerHeight() : Number {
      drawNow();
      var local1:Number = getStyleValue("contentPadding") as Number;
      return height - local1 * 2 - (_horizontalScrollBar.visible ? _horizontalScrollBar.height : 0);
    }

    override protected function moveSelectionVertically(param1:uint, param2:Boolean, param3:Boolean) : void {
      var local7:int = 0;
      var local8:int = 0;
      var local4:uint = Math.max(1,Math.max(contentHeight,availableHeight) / _rowHeight << 0);
      var local5:uint = Math.ceil(Math.max(columnCount * rowCount,length) / local4);
      var local6:uint = Math.ceil(length / local5);
      switch(param1) {
        case Keyboard.UP:
          local7 = selectedIndex - local5;
          break;
        case Keyboard.DOWN:
          local7 = selectedIndex + local5;
          break;
        case Keyboard.HOME:
          local7 = 0;
          break;
        case Keyboard.END:
          local7 = length - 1;
          break;
        case Keyboard.PAGE_DOWN:
          local8 = selectedIndex + local5 * (local6 - 1);
          if(local8 >= length) {
            local8 -= local5;
          }
          local7 = Math.min(length - 1,local8);
          break;
        case Keyboard.PAGE_UP:
          local8 = selectedIndex - local5 * (local6 - 1);
          if(local8 < 0) {
            local8 += local5;
          }
          local7 = Math.max(0,local8);
      }
      doKeySelection(local7,param2,param3);
      scrollToSelected();
    }

    public function get sourceField() : String {
      return _sourceField;
    }

    [Inspectable(defaultValue="50")]
    public function get rowHeight() : Number {
      return _rowHeight;
    }

    override public function get horizontalScrollPolicy() : String {
      return null;
    }

    override protected function initializeAccessibility() : void {
      if(TileList.createAccessibilityImplementation != null) {
        TileList.createAccessibilityImplementation(this);
      }
    }

    public function set sourceFunction(param1:Function) : void {
      _sourceFunction = param1;
      invalidate(InvalidationType.DATA);
    }

    public function set columnWidth(param1:Number) : void {
      if(_columnWidth == param1) {
        return;
      }
      _columnWidth = param1;
      invalidate(InvalidationType.SIZE);
    }

    public function set rowCount(param1:uint) : void {
      if(param1 == 0) {
        return;
      }
      if(componentInspectorSetting) {
        __rowCount = param1;
        return;
      }
      __rowCount = 0;
      var local2:Number = Number(getStyleValue("contentPadding"));
      var local3:* = Math.ceil(length / param1) > width / columnWidth >> 0 && _scrollPolicy == ScrollPolicy.AUTO || _scrollPolicy == ScrollPolicy.ON;
      height = rowHeight * param1 + 2 * local2 + (_scrollDirection == ScrollBarDirection.HORIZONTAL && local3 ? ScrollBar.WIDTH : 0);
    }

    override public function itemToLabel(param1:Object) : String {
      if(_labelFunction != null) {
        return String(_labelFunction(param1));
      }
      if(param1[_labelField] == null) {
        return "";
      }
      return String(param1[_labelField]);
    }

    override protected function setVerticalScrollPosition(param1:Number, param2:Boolean = false) : void {
      invalidate(InvalidationType.SCROLL);
      super.setVerticalScrollPosition(param1,true);
    }

    public function set columnCount(param1:uint) : void {
      if(param1 == 0) {
        return;
      }
      if(componentInspectorSetting) {
        __columnCount = param1;
        return;
      }
      __columnCount = 0;
      var local2:Number = Number(getStyleValue("contentPadding"));
      var local3:Boolean = Math.ceil(length / param1) > height / rowHeight >> 0 && _scrollPolicy == ScrollPolicy.AUTO || _scrollPolicy == ScrollPolicy.ON;
      width = columnWidth * param1 + 2 * local2 + (_scrollDirection == ScrollBarDirection.VERTICAL && local3 ? 15 : 0);
    }

    [Collection(collectionClass="fl.data.DataProvider",collectionItem="fl.data.TileListCollectionItem",identifier="item")]
    override public function get dataProvider() : DataProvider {
      return super.dataProvider;
    }

    override public function set maxHorizontalScrollPosition(param1:Number) : void {
    }

    public function set sourceField(param1:String) : void {
      _sourceField = param1;
      invalidate(InvalidationType.DATA);
    }

    public function set rowHeight(param1:Number) : void {
      if(_rowHeight == param1) {
        return;
      }
      _rowHeight = param1;
      invalidate(InvalidationType.SIZE);
    }

    override public function set horizontalScrollPolicy(param1:String) : void {
    }

    override protected function draw() : void {
      if(direction == ScrollBarDirection.VERTICAL) {
        if(__rowCount > 0) {
          rowCount = __rowCount;
        }
        if(__columnCount > 0) {
          columnCount = __columnCount;
        }
      } else {
        if(__columnCount > 0) {
          columnCount = __columnCount;
        }
        if(__rowCount > 0) {
          rowCount = __rowCount;
        }
      }
      var local1:Boolean = oldLength != length;
      oldLength = length;
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
        _maxHorizontalScrollPosition = Math.max(0,contentWidth - availableWidth);
      }
      updateChildren();
      validate();
    }

    public function set labelField(param1:String) : void {
      if(param1 == _labelField) {
        return;
      }
      _labelField = param1;
      invalidate(InvalidationType.DATA);
    }

    public function set scrollPolicy(param1:String) : void {
      if(!componentInspectorSetting && _scrollPolicy == param1) {
        return;
      }
      _scrollPolicy = param1;
      if(direction == ScrollBarDirection.HORIZONTAL) {
        _horizontalScrollPolicy = param1;
        _verticalScrollPolicy = ScrollPolicy.OFF;
      } else {
        _verticalScrollPolicy = param1;
        _horizontalScrollPolicy = ScrollPolicy.OFF;
      }
      invalidate(InvalidationType.SIZE);
    }

    [Inspectable(defaultValue="0",type="Number")]
    override public function get rowCount() : uint {
      var local1:Number = Number(getStyleValue("contentPadding"));
      var local2:uint = Math.max(1,(_width - 2 * local1) / _columnWidth << 0);
      var local3:uint = Math.max(1,(_height - 2 * local1) / _rowHeight << 0);
      if(_scrollDirection == ScrollBarDirection.HORIZONTAL) {
        if(_scrollPolicy == ScrollPolicy.ON || _scrollPolicy == ScrollPolicy.AUTO && length > local2 * local3) {
          local3 = Math.max(1,(_height - 2 * local1 - 15) / _rowHeight << 0);
        }
      } else {
        local3 = Math.max(1,Math.ceil((_height - 2 * local1) / _rowHeight));
      }
      return local3;
    }

    public function set labelFunction(param1:Function) : void {
      if(_labelFunction == param1) {
        return;
      }
      _labelFunction = param1;
      invalidate(InvalidationType.DATA);
    }

    [Inspectable(defaultValue="0",type="Number")]
    public function get columnCount() : uint {
      var local1:Number = Number(getStyleValue("contentPadding"));
      var local2:uint = Math.max(1,(_width - 2 * local1) / _columnWidth << 0);
      var local3:uint = Math.max(1,(_height - 2 * local1) / _rowHeight << 0);
      if(_scrollDirection != ScrollBarDirection.HORIZONTAL) {
        if(_scrollPolicy == ScrollPolicy.ON || _scrollPolicy == ScrollPolicy.AUTO && length > local2 * local3) {
          local2 = Math.max(1,(_width - 2 * local1 - 15) / _columnWidth << 0);
        }
      } else {
        local2 = Math.max(1,Math.ceil((_width - 2 * local1) / _columnWidth));
      }
      return local2;
    }

    override protected function setHorizontalScrollPosition(param1:Number, param2:Boolean = false) : void {
      invalidate(InvalidationType.SCROLL);
      super.setHorizontalScrollPosition(param1,true);
    }

    override protected function configUI() : void {
      super.configUI();
      _horizontalScrollPolicy = scrollPolicy;
      _verticalScrollPolicy = ScrollPolicy.OFF;
    }

    override public function get maxHorizontalScrollPosition() : Number {
      drawNow();
      return _maxHorizontalScrollPosition;
    }

    [Inspectable(enumeration="auto,on,off",defaultValue="auto")]
    public function get scrollPolicy() : String {
      return _scrollPolicy;
    }

    public function set iconFunction(param1:Function) : void {
      if(_iconFunction == param1) {
        return;
      }
      _iconFunction = param1;
      invalidate(InvalidationType.DATA);
    }

    public function get labelField() : String {
      return _labelField;
    }

    override protected function keyDownHandler(param1:KeyboardEvent) : void {
      var local2:int = 0;
      param1.stopPropagation();
      if(!selectable) {
        return;
      }
      switch(param1.keyCode) {
        case Keyboard.UP:
        case Keyboard.DOWN:
          moveSelectionVertically(param1.keyCode,param1.shiftKey && _allowMultipleSelection,param1.ctrlKey && _allowMultipleSelection);
          break;
        case Keyboard.PAGE_UP:
        case Keyboard.PAGE_DOWN:
        case Keyboard.END:
        case Keyboard.HOME:
          if(_scrollDirection == ScrollBarDirection.HORIZONTAL) {
            moveSelectionHorizontally(param1.keyCode,param1.shiftKey && _allowMultipleSelection,param1.ctrlKey && _allowMultipleSelection);
          } else {
            moveSelectionVertically(param1.keyCode,param1.shiftKey && _allowMultipleSelection,param1.ctrlKey && _allowMultipleSelection);
          }
          break;
        case Keyboard.LEFT:
        case Keyboard.RIGHT:
          moveSelectionHorizontally(param1.keyCode,param1.shiftKey && _allowMultipleSelection,param1.ctrlKey && _allowMultipleSelection);
          break;
        default:
          local2 = getNextIndexAtLetter(String.fromCharCode(param1.keyCode),selectedIndex);
          if(local2 > -1) {
            selectedIndex = local2;
            scrollToSelected();
          }
      }
    }

    public function get labelFunction() : Function {
      return _labelFunction;
    }

    public function get iconFunction() : Function {
      return _iconFunction;
    }

    override public function get verticalScrollPolicy() : String {
      return null;
    }

    override public function set dataProvider(param1:DataProvider) : void {
      super.dataProvider = param1;
    }

    public function set direction(param1:String) : void {
      if(_scrollDirection == param1) {
        return;
      }
      _scrollDirection = param1;
      invalidate(InvalidationType.SIZE);
    }

    [Inspectable(enumeration="horizontal,vertical",defaultValue="horizontal")]
    public function get direction() : String {
      return _scrollDirection;
    }
  }
}
