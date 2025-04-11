package fl.controls {
  import fl.containers.BaseScrollPane;
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ICellRenderer;
  import fl.core.InvalidationType;
  import fl.data.DataProvider;
  import fl.data.SimpleCollectionItem;
  import fl.events.DataChangeEvent;
  import fl.events.DataChangeType;
  import fl.events.ListEvent;
  import fl.events.ScrollEvent;
  import fl.managers.IFocusManagerComponent;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.ui.Keyboard;
  import flash.utils.Dictionary;

  [Style(name="contentPadding",type="Number",format="Length")]
  [Style(name="disabledAlpha",type="Number")]
  [Style(name="cellRenderer",type="Class")]
  [Style(name="skin",type="Class")]
  [Event(name="scroll",type="fl.events.ScrollEvent")]
  [Event(name="change",type="flash.events.Event")]
  [Event(name="itemDoubleClick",type="fl.events.ListEvent")]
  [Event(name="itemClick",type="fl.events.ListEvent")]
  [Event(name="rollOut",type="flash.events.MouseEvent")]
  [Event(name="rollOver",type="flash.events.MouseEvent")]
  [Event(name="itemRollOver",type="fl.events.ListEvent")]
  [Event(name="itemRollOut",type="fl.events.ListEvent")]
  public class SelectableList extends BaseScrollPane implements IFocusManagerComponent {
    public static var createAccessibilityImplementation:Function;

    private static var defaultStyles:Object = {
      "skin":"List_skin",
      "cellRenderer":CellRenderer,
      "contentPadding":null,
      "disabledAlpha":null
    };

    protected var invalidItems:Dictionary;
    protected var renderedItems:Dictionary;
    protected var caretIndex:int = -1;
    protected var updatedRendererStyles:Object;
    protected var _allowMultipleSelection:Boolean = false;
    protected var lastCaretIndex:int = -1;
    protected var _verticalScrollPosition:Number;
    protected var _selectedIndices:Array;
    protected var preChangeItems:Array;
    protected var activeCellRenderers:Array;
    protected var availableCellRenderers:Array;
    protected var rendererStyles:Object;
    protected var list:Sprite;
    protected var _dataProvider:DataProvider;
    protected var _horizontalScrollPosition:Number;

    private var collectionItemImport:SimpleCollectionItem;

    protected var listHolder:Sprite;
    protected var _selectable:Boolean = true;

    public function SelectableList() {
      super();
      activeCellRenderers = [];
      availableCellRenderers = [];
      invalidItems = new Dictionary(true);
      renderedItems = new Dictionary(true);
      _selectedIndices = [];
      if(dataProvider == null) {
        dataProvider = new DataProvider();
      }
      verticalScrollPolicy = ScrollPolicy.AUTO;
      rendererStyles = {};
      updatedRendererStyles = {};
    }

    public static function getStyleDefinition() : Object {
      return mergeStyles(defaultStyles,BaseScrollPane.getStyleDefinition());
    }

    protected function drawList() : void {
    }

    protected function moveSelectionHorizontally(param1:uint, param2:Boolean, param3:Boolean) : void {
    }

    [Inspectable(defaultValue="false")]
    public function get allowMultipleSelection() : Boolean {
      return _allowMultipleSelection;
    }

    protected function onPreChange(param1:DataChangeEvent) : void {
      switch(param1.changeType) {
        case DataChangeType.REMOVE:
        case DataChangeType.ADD:
        case DataChangeType.INVALIDATE:
        case DataChangeType.REMOVE_ALL:
        case DataChangeType.REPLACE:
        case DataChangeType.INVALIDATE_ALL:
          break;
        default:
          preChangeItems = selectedItems;
      }
    }

    public function set selectedIndices(param1:Array) : void {
      if(!_selectable) {
        return;
      }
      _selectedIndices = param1 == null ? [] : param1.concat();
      invalidate(InvalidationType.SELECTED);
    }

    public function isItemSelected(param1:Object) : Boolean {
      return selectedItems.indexOf(param1) > -1;
    }

    public function set allowMultipleSelection(param1:Boolean) : void {
      if(param1 == _allowMultipleSelection) {
        return;
      }
      _allowMultipleSelection = param1;
      if(!param1 && _selectedIndices.length > 1) {
        _selectedIndices = [_selectedIndices.pop()];
        invalidate(InvalidationType.DATA);
      }
    }

    override protected function setVerticalScrollPosition(param1:Number, param2:Boolean = false) : void {
      if(param1 == _verticalScrollPosition) {
        return;
      }
      var local3:Number = param1 - _verticalScrollPosition;
      _verticalScrollPosition = param1;
      if(param2) {
        dispatchEvent(new ScrollEvent(ScrollBarDirection.VERTICAL,local3,param1));
      }
    }

    public function sortItemsOn(param1:String, param2:Object = null) : * {
      return _dataProvider.sortOn(param1,param2);
    }

    public function getNextIndexAtLetter(param1:String, param2:int = -1) : int {
      var local5:Number = NaN;
      var local6:Object = null;
      var local7:String = null;
      if(length == 0) {
        return -1;
      }
      param1 = param1.toUpperCase();
      var local3:int = length - 1;
      var local4:Number = 0;
      while(local4 < local3) {
        local5 = param2 + 1 + local4;
        if(local5 > length - 1) {
          local5 -= length;
        }
        local6 = getItemAt(local5);
        if(local6 == null) {
          break;
        }
        local7 = itemToLabel(local6);
        if(local7 != null) {
          if(local7.charAt(0).toUpperCase() == param1) {
            return local5;
          }
        }
        local4++;
      }
      return -1;
    }

    override protected function draw() : void {
      super.draw();
    }

    public function removeItemAt(param1:uint) : Object {
      return _dataProvider.removeItemAt(param1);
    }

    public function get selectedItem() : Object {
      return _selectedIndices.length == 0 ? null : _dataProvider.getItemAt(selectedIndex);
    }

    protected function handleDataChange(param1:DataChangeEvent) : void {
      var local5:uint = 0;
      var local2:int = int(param1.startIndex);
      var local3:int = int(param1.endIndex);
      var local4:String = param1.changeType;
      if(local4 == DataChangeType.INVALIDATE_ALL) {
        clearSelection();
        invalidateList();
      } else if(local4 == DataChangeType.INVALIDATE) {
        local5 = 0;
        while(local5 < param1.items.length) {
          invalidateItem(param1.items[local5]);
          local5++;
        }
      } else if(local4 == DataChangeType.ADD) {
        local5 = 0;
        while(local5 < _selectedIndices.length) {
          if(_selectedIndices[local5] >= local2) {
            _selectedIndices[local5] += local2 - local3;
          }
          local5++;
        }
      } else if(local4 == DataChangeType.REMOVE) {
        local5 = 0;
        while(local5 < _selectedIndices.length) {
          if(_selectedIndices[local5] >= local2) {
            if(_selectedIndices[local5] <= local3) {
              delete _selectedIndices[local5];
            } else {
              _selectedIndices[local5] -= local2 - local3 + 1;
            }
          }
          local5++;
        }
      } else if(local4 == DataChangeType.REMOVE_ALL) {
        clearSelection();
      } else if(local4 != DataChangeType.REPLACE) {
        selectedItems = preChangeItems;
        preChangeItems = null;
      }
      invalidate(InvalidationType.DATA);
    }

    public function itemToCellRenderer(param1:Object) : ICellRenderer {
      var local2:* = undefined;
      var local3:ICellRenderer = null;
      if(param1 != null) {
        for(local2 in activeCellRenderers) {
          local3 = activeCellRenderers[local2] as ICellRenderer;
          if(local3.data == param1) {
            return local3;
          }
        }
      }
      return null;
    }

    public function addItem(param1:Object) : void {
      _dataProvider.addItem(param1);
      invalidateList();
    }

    public function get rowCount() : uint {
      return 0;
    }

    override protected function configUI() : void {
      super.configUI();
      listHolder = new Sprite();
      addChild(listHolder);
      listHolder.scrollRect = contentScrollRect;
      list = new Sprite();
      listHolder.addChild(list);
    }

    public function get selectable() : Boolean {
      return _selectable;
    }

    public function clearRendererStyle(param1:String, param2:int = -1) : void {
      delete rendererStyles[param1];
      updatedRendererStyles[param1] = null;
      invalidate(InvalidationType.RENDERER_STYLES);
    }

    protected function handleCellRendererMouseEvent(param1:MouseEvent) : void {
      var local2:ICellRenderer = param1.target as ICellRenderer;
      var local3:String = param1.type == MouseEvent.ROLL_OVER ? ListEvent.ITEM_ROLL_OVER : ListEvent.ITEM_ROLL_OUT;
      dispatchEvent(new ListEvent(local3,false,false,local2.listData.column,local2.listData.row,local2.listData.index,local2.data));
    }

    override protected function keyDownHandler(param1:KeyboardEvent) : void {
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
          param1.stopPropagation();
          break;
        case Keyboard.LEFT:
        case Keyboard.RIGHT:
          moveSelectionHorizontally(param1.keyCode,param1.shiftKey && _allowMultipleSelection,param1.ctrlKey && _allowMultipleSelection);
          param1.stopPropagation();
      }
    }

    protected function handleCellRendererDoubleClick(param1:MouseEvent) : void {
      if(!_enabled) {
        return;
      }
      var local2:ICellRenderer = param1.currentTarget as ICellRenderer;
      var local3:uint = uint(local2.listData.index);
      dispatchEvent(new ListEvent(ListEvent.ITEM_DOUBLE_CLICK,false,true,local2.listData.column,local2.listData.row,local3,local2.data));
    }

    public function setRendererStyle(param1:String, param2:Object, param3:uint = 0) : void {
      if(rendererStyles[param1] == param2) {
        return;
      }
      updatedRendererStyles[param1] = param2;
      rendererStyles[param1] = param2;
      invalidate(InvalidationType.RENDERER_STYLES);
    }

    [Collection(collectionClass="fl.data.DataProvider",collectionItem="fl.data.SimpleCollectionItem",identifier="item")]
    public function set dataProvider(param1:DataProvider) : void {
      if(_dataProvider != null) {
        _dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE,handleDataChange);
        _dataProvider.removeEventListener(DataChangeEvent.PRE_DATA_CHANGE,onPreChange);
      }
      _dataProvider = param1;
      _dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE,handleDataChange,false,0,true);
      _dataProvider.addEventListener(DataChangeEvent.PRE_DATA_CHANGE,onPreChange,false,0,true);
      clearSelection();
      invalidateList();
    }

    public function invalidateList() : void {
      _invalidateList();
      invalidate(InvalidationType.DATA);
    }

    public function replaceItemAt(param1:Object, param2:uint) : Object {
      return _dataProvider.replaceItemAt(param1,param2);
    }

    public function removeAll() : void {
      _dataProvider.removeAll();
    }

    [Inspectable(defaultValue="true",verbose="1")]
    override public function set enabled(param1:Boolean) : void {
      super.enabled = param1;
      list.mouseChildren = _enabled;
    }

    public function scrollToIndex(param1:int) : void {
    }

    public function get selectedIndices() : Array {
      return _selectedIndices.concat();
    }

    override protected function drawLayout() : void {
      super.drawLayout();
      contentScrollRect = listHolder.scrollRect;
      contentScrollRect.width = availableWidth;
      contentScrollRect.height = availableHeight;
      listHolder.scrollRect = contentScrollRect;
    }

    protected function _invalidateList() : void {
      availableCellRenderers = [];
      while(activeCellRenderers.length > 0) {
        list.removeChild(activeCellRenderers.pop() as DisplayObject);
      }
    }

    public function set selectedItem(param1:Object) : void {
      var local2:int = _dataProvider.getItemIndex(param1);
      selectedIndex = local2;
    }

    public function getItemAt(param1:uint) : Object {
      return _dataProvider.getItemAt(param1);
    }

    protected function handleCellRendererChange(param1:Event) : void {
      var local2:ICellRenderer = param1.currentTarget as ICellRenderer;
      var local3:uint = uint(local2.listData.index);
      _dataProvider.invalidateItemAt(local3);
    }

    protected function moveSelectionVertically(param1:uint, param2:Boolean, param3:Boolean) : void {
    }

    public function itemToLabel(param1:Object) : String {
      return param1["label"];
    }

    public function addItemAt(param1:Object, param2:uint) : void {
      _dataProvider.addItemAt(param1,param2);
      invalidateList();
    }

    override protected function initializeAccessibility() : void {
      if(SelectableList.createAccessibilityImplementation != null) {
        SelectableList.createAccessibilityImplementation(this);
      }
    }

    protected function updateRendererStyles() : void {
      var local4:String = null;
      var local1:Array = availableCellRenderers.concat(activeCellRenderers);
      var local2:uint = local1.length;
      var local3:uint = 0;
      while(local3 < local2) {
        if(local1[local3].setStyle != null) {
          for(local4 in updatedRendererStyles) {
            local1[local3].setStyle(local4,updatedRendererStyles[local4]);
          }
          local1[local3].drawNow();
        }
        local3++;
      }
      updatedRendererStyles = {};
    }

    public function set selectable(param1:Boolean) : void {
      if(param1 == _selectable) {
        return;
      }
      if(!param1) {
        selectedIndices = [];
      }
      _selectable = param1;
    }

    public function removeItem(param1:Object) : Object {
      return _dataProvider.removeItem(param1);
    }

    public function get dataProvider() : DataProvider {
      return _dataProvider;
    }

    public function set maxHorizontalScrollPosition(param1:Number) : void {
      _maxHorizontalScrollPosition = param1;
      invalidate(InvalidationType.SIZE);
    }

    public function clearSelection() : void {
      selectedIndex = -1;
    }

    public function invalidateItemAt(param1:uint) : void {
      var local2:Object = _dataProvider.getItemAt(param1);
      if(local2 != null) {
        invalidateItem(local2);
      }
    }

    public function sortItems(... rest) : * {
      return _dataProvider.sort.apply(_dataProvider,rest);
    }

    public function set selectedItems(param1:Array) : void {
      var local4:int = 0;
      if(param1 == null) {
        selectedIndices = null;
        return;
      }
      var local2:Array = [];
      var local3:uint = 0;
      while(local3 < param1.length) {
        local4 = _dataProvider.getItemIndex(param1[local3]);
        if(local4 != -1) {
          local2.push(local4);
        }
        local3++;
      }
      selectedIndices = local2;
    }

    override protected function setHorizontalScrollPosition(param1:Number, param2:Boolean = false) : void {
      if(param1 == _horizontalScrollPosition) {
        return;
      }
      var local3:Number = param1 - _horizontalScrollPosition;
      _horizontalScrollPosition = param1;
      if(param2) {
        dispatchEvent(new ScrollEvent(ScrollBarDirection.HORIZONTAL,local3,param1));
      }
    }

    override public function get maxHorizontalScrollPosition() : Number {
      return _maxHorizontalScrollPosition;
    }

    public function scrollToSelected() : void {
      scrollToIndex(selectedIndex);
    }

    public function get selectedItems() : Array {
      var local1:Array = [];
      var local2:uint = 0;
      while(local2 < _selectedIndices.length) {
        local1.push(_dataProvider.getItemAt(_selectedIndices[local2]));
        local2++;
      }
      return local1;
    }

    public function get length() : uint {
      return _dataProvider.length;
    }

    public function invalidateItem(param1:Object) : void {
      if(renderedItems[param1] == null) {
        return;
      }
      invalidItems[param1] = true;
      invalidate(InvalidationType.DATA);
    }

    public function set selectedIndex(param1:int) : void {
      selectedIndices = param1 == -1 ? null : [param1];
    }

    public function get selectedIndex() : int {
      return _selectedIndices.length == 0 ? -1 : int(_selectedIndices[_selectedIndices.length - 1]);
    }

    public function getRendererStyle(param1:String, param2:int = -1) : Object {
      return rendererStyles[param1];
    }

    protected function handleCellRendererClick(param1:MouseEvent) : void {
      var local5:int = 0;
      var local6:uint = 0;
      if(!_enabled) {
        return;
      }
      var local2:ICellRenderer = param1.currentTarget as ICellRenderer;
      var local3:uint = uint(local2.listData.index);
      if(!dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK,false,true,local2.listData.column,local2.listData.row,local3,local2.data)) || !_selectable) {
        return;
      }
      var local4:int = int(selectedIndices.indexOf(local3));
      if(!_allowMultipleSelection) {
        if(local4 != -1) {
          return;
        }
        local2.selected = true;
        _selectedIndices = [local3];
        lastCaretIndex = caretIndex = local3;
      } else if(param1.shiftKey) {
        local6 = _selectedIndices.length > 0 ? uint(_selectedIndices[0]) : local3;
        _selectedIndices = [];
        if(local6 > local3) {
          local5 = int(local6);
          while(local5 >= local3) {
            _selectedIndices.push(local5);
            local5--;
          }
        } else {
          local5 = int(local6);
          while(local5 <= local3) {
            _selectedIndices.push(local5);
            local5++;
          }
        }
        caretIndex = local3;
      } else if(param1.ctrlKey) {
        if(local4 != -1) {
          local2.selected = false;
          _selectedIndices.splice(local4,1);
        } else {
          local2.selected = true;
          _selectedIndices.push(local3);
        }
        caretIndex = local3;
      } else {
        _selectedIndices = [local3];
        lastCaretIndex = caretIndex = local3;
      }
      dispatchEvent(new Event(Event.CHANGE));
      invalidate(InvalidationType.DATA);
    }
  }
}
