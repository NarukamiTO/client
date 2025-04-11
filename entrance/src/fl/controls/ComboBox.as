package fl.controls {
  import fl.controls.listClasses.ICellRenderer;
  import fl.core.InvalidationType;
  import fl.core.UIComponent;
  import fl.data.DataProvider;
  import fl.data.SimpleCollectionItem;
  import fl.events.ComponentEvent;
  import fl.events.DataChangeEvent;
  import fl.events.ListEvent;
  import fl.managers.IFocusManagerComponent;
  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.text.TextFormat;
  import flash.ui.Keyboard;

  [Style(name="embedFonts",type="Boolean")]
  [Style(name="repeatInterval",type="Number",format="Time")]
  [Style(name="repeatDelay",type="Number",format="Time")]
  [Style(name="thumbIcon",type="Class")]
  [Style(name="upArrowUpSkin",type="Class")]
  [Style(name="upArrowOverSkin",type="Class")]
  [Style(name="upArrowDownSkin",type="Class")]
  [Style(name="upArrowDisabledSkin",type="Class")]
  [Style(name="trackUpSkin",type="Class")]
  [Style(name="trackOverSkin",type="Class")]
  [Style(name="trackDownSkin",type="Class")]
  [Style(name="trackDisabledSkin",type="Class")]
  [Style(name="thumbArrowUpSkin",type="Class")]
  [Style(name="thumbOverSkin",type="Class")]
  [Style(name="thumbDownSkin",type="Class")]
  [Style(name="thumbDisabledSkin",type="Class")]
  [Style(name="downArrowUpSkin",type="Class")]
  [Style(name="downArrowOverSkin",type="Class")]
  [Style(name="downArrowDownSkin",type="Class")]
  [Style(name="downArrowDisabledSkin",type="Class")]
  [Style(name="disabledAlpha",type="Class")]
  [Style(name="contentPadding",type="Number",format="Length")]
  [Style(name="cellRenderer",type="Class")]
  [Style(name="disabledSkin",type="Class")]
  [Style(name="downSkin",type="Class")]
  [Style(name="overSkin",type="Class")]
  [Style(name="upSkin",type="Class")]
  [Style(name="textPadding",type="Number",format="Length")]
  [Style(name="buttonWidth",type="Number",format="Length")]
  [Event(name="scroll",type="fl.events.ScrollEvent")]
  [Event(name="open",type="flash.events.Event")]
  [Event(name="enter",type="fl.events.ComponentEvent")]
  [Event(name="close",type="flash.events.Event")]
  [Event(name="itemRollOut",type="fl.events.ListEvent")]
  [Event(name="itemRollOver",type="fl.events.ListEvent")]
  [Event(name="change",type="flash.events.Event")]
  [Embed(source="/_assets/assets.swf", symbol="symbol1197")]
  public class ComboBox extends UIComponent implements IFocusManagerComponent {
    public static var createAccessibilityImplementation:Function;

    private static var defaultStyles:Object = {
      "upSkin":"ComboBox_upSkin",
      "downSkin":"ComboBox_downSkin",
      "overSkin":"ComboBox_overSkin",
      "disabledSkin":"ComboBox_disabledSkin",
      "focusRectSkin":null,
      "focusRectPadding":null,
      "textFormat":null,
      "disabledTextFormat":null,
      "textPadding":3,
      "buttonWidth":24,
      "disabledAlpha":null,
      "listSkin":null
    };

    protected static const LIST_STYLES:Object = {
      "upSkin":"comboListUpSkin",
      "overSkin":"comboListOverSkin",
      "downSkin":"comobListDownSkin",
      "disabledSkin":"comboListDisabledSkin",
      "downArrowDisabledSkin":"downArrowDisabledSkin",
      "downArrowDownSkin":"downArrowDownSkin",
      "downArrowOverSkin":"downArrowOverSkin",
      "downArrowUpSkin":"downArrowUpSkin",
      "upArrowDisabledSkin":"upArrowDisabledSkin",
      "upArrowDownSkin":"upArrowDownSkin",
      "upArrowOverSkin":"upArrowOverSkin",
      "upArrowUpSkin":"upArrowUpSkin",
      "thumbDisabledSkin":"thumbDisabledSkin",
      "thumbDownSkin":"thumbDownSkin",
      "thumbOverSkin":"thumbOverSkin",
      "thumbUpSkin":"thumbUpSkin",
      "thumbIcon":"thumbIcon",
      "trackDisabledSkin":"trackDisabledSkin",
      "trackDownSkin":"trackDownSkin",
      "trackOverSkin":"trackOverSkin",
      "trackUpSkin":"trackUpSkin",
      "repeatDelay":"repeatDelay",
      "repeatInterval":"repeatInterval",
      "textFormat":"textFormat",
      "disabledAlpha":"disabledAlpha",
      "skin":"listSkin"
    };

    protected static const BACKGROUND_STYLES:Object = {
      "overSkin":"overSkin",
      "downSkin":"downSkin",
      "upSkin":"upSkin",
      "disabledSkin":"disabledSkin",
      "repeatInterval":"repeatInterval"
    };

    protected var isKeyDown:Boolean = false;
    protected var _labels:Array;
    protected var background:BaseButton;
    protected var _dropdownWidth:Number;
    protected var inputField:TextInput;
    protected var highlightedCell:int = -1;
    protected var listOverIndex:uint;
    protected var editableValue:String;
    protected var _prompt:String;
    protected var isOpen:Boolean = false;
    protected var list:List;
    protected var _rowCount:uint = 5;
    protected var _editable:Boolean = false;

    private var collectionItemImport:SimpleCollectionItem;

    protected var currentIndex:int;

    public function ComboBox() {
      super();
    }

    public static function getStyleDefinition() : Object {
      return mergeStyles(defaultStyles,List.getStyleDefinition());
    }

    protected function drawList() : void {
      list.rowCount = Math.max(0,Math.min(_rowCount,list.dataProvider.length));
    }

    public function get imeMode() : String {
      return inputField.imeMode;
    }

    protected function onInputFieldFocusOut(param1:FocusEvent) : void {
      inputField.removeEventListener(ComponentEvent.ENTER,onEnter);
      selectedIndex = selectedIndex;
    }

    public function set imeMode(param1:String) : void {
      inputField.imeMode = param1;
    }

    protected function passEvent(param1:Event) : void {
      dispatchEvent(param1);
    }

    protected function calculateAvailableHeight() : Number {
      var local1:Number = Number(getStyleValue("contentPadding"));
      return list.height - local1 * 2;
    }

    public function get dropdown() : List {
      return list;
    }

    override protected function focusOutHandler(param1:FocusEvent) : void {
      isKeyDown = false;
      if(isOpen) {
        if(!param1.relatedObject || !list.contains(param1.relatedObject)) {
          if(highlightedCell != -1 && highlightedCell != selectedIndex) {
            selectedIndex = highlightedCell;
            dispatchEvent(new Event(Event.CHANGE));
          }
          close();
        }
      }
      super.focusOutHandler(param1);
    }

    public function get selectedLabel() : String {
      if(editableValue != null) {
        return editableValue;
      }
      if(selectedIndex == -1) {
        return null;
      }
      return itemToLabel(selectedItem);
    }

    protected function onListChange(param1:Event) : void {
      editableValue = null;
      dispatchEvent(param1);
      invalidate(InvalidationType.SELECTED);
      if(isKeyDown) {
        return;
      }
      close();
    }

    public function get text() : String {
      return inputField.text;
    }

    protected function onEnter(param1:ComponentEvent) : void {
      param1.stopPropagation();
    }

    public function sortItemsOn(param1:String, param2:Object = null) : * {
      return list.sortItemsOn(param1,param2);
    }

    protected function handleDataChange(param1:DataChangeEvent) : void {
      invalidate(InvalidationType.DATA);
    }

    protected function onToggleListVisibility(param1:MouseEvent) : void {
      param1.stopPropagation();
      dispatchEvent(param1);
      if(isOpen) {
        close();
      } else {
        open();
        stage.addEventListener(MouseEvent.MOUSE_UP,onListItemUp,false,0,true);
      }
    }

    public function get dropdownWidth() : Number {
      return list.width;
    }

    protected function highlightCell(param1:int = -1) : void {
      var local2:ICellRenderer = null;
      if(highlightedCell > -1) {
        local2 = list.itemToCellRenderer(getItemAt(highlightedCell));
        if(local2 != null) {
          local2.setMouseState("up");
        }
      }
      if(param1 == -1) {
        return;
      }
      list.scrollToIndex(param1);
      list.drawNow();
      local2 = list.itemToCellRenderer(getItemAt(param1));
      if(local2 != null) {
        local2.setMouseState("over");
        highlightedCell = param1;
      }
    }

    public function removeItemAt(param1:uint) : void {
      list.removeItemAt(param1);
      invalidate(InvalidationType.DATA);
    }

    override protected function draw() : void {
      var local1:* = selectedIndex;
      if(local1 == -1 && (prompt != null || editable || length == 0)) {
        local1 = Math.max(-1,Math.min(local1,length - 1));
      } else {
        editableValue = null;
        local1 = Math.max(0,Math.min(local1,length - 1));
      }
      if(list.selectedIndex != local1) {
        list.selectedIndex = local1;
        invalidate(InvalidationType.SELECTED,false);
      }
      if(isInvalid(InvalidationType.STYLES)) {
        setStyles();
        setEmbedFonts();
        invalidate(InvalidationType.SIZE,false);
      }
      if(isInvalid(InvalidationType.SIZE,InvalidationType.DATA,InvalidationType.STATE)) {
        drawTextFormat();
        drawLayout();
        invalidate(InvalidationType.DATA);
      }
      if(isInvalid(InvalidationType.DATA)) {
        drawList();
        invalidate(InvalidationType.SELECTED,true);
      }
      if(isInvalid(InvalidationType.SELECTED)) {
        if(local1 == -1 && editableValue != null) {
          inputField.text = editableValue;
        } else if(local1 > -1) {
          if(length > 0) {
            inputField.horizontalScrollPosition = 0;
            inputField.text = itemToLabel(list.selectedItem);
          }
        } else if(local1 == -1 && _prompt != null) {
          showPrompt();
        } else {
          inputField.text = "";
        }
        if(editable && selectedIndex > -1 && stage.focus == inputField.textField) {
          inputField.setSelection(0,inputField.length);
        }
      }
      drawTextField();
      super.draw();
    }

    public function get selectedItem() : Object {
      return list.selectedItem;
    }

    public function open() : void {
      currentIndex = selectedIndex;
      if(isOpen || length == 0) {
        return;
      }
      dispatchEvent(new Event(Event.OPEN));
      isOpen = true;
      addEventListener(Event.ENTER_FRAME,addCloseListener,false,0,true);
      positionList();
      list.scrollToSelected();
      stage.addChild(list);
    }

    override protected function configUI() : void {
      super.configUI();
      background = new BaseButton();
      background.focusEnabled = false;
      copyStylesToChild(background,BACKGROUND_STYLES);
      background.addEventListener(MouseEvent.MOUSE_DOWN,onToggleListVisibility,false,0,true);
      addChild(background);
      inputField = new TextInput();
      inputField.focusTarget = this as IFocusManagerComponent;
      inputField.focusEnabled = false;
      inputField.addEventListener(Event.CHANGE,onTextInput,false,0,true);
      addChild(inputField);
      list = new List();
      list.focusEnabled = false;
      copyStylesToChild(list,LIST_STYLES);
      list.addEventListener(Event.CHANGE,onListChange,false,0,true);
      list.addEventListener(ListEvent.ITEM_CLICK,onListChange,false,0,true);
      list.addEventListener(ListEvent.ITEM_ROLL_OUT,passEvent,false,0,true);
      list.addEventListener(ListEvent.ITEM_ROLL_OVER,passEvent,false,0,true);
      list.verticalScrollBar.addEventListener(Event.SCROLL,passEvent,false,0,true);
    }

    public function set text(param1:String) : void {
      if(!editable) {
        return;
      }
      inputField.text = param1;
    }

    public function addItem(param1:Object) : void {
      list.addItem(param1);
      invalidate(InvalidationType.DATA);
    }

    [Inspectable(defaultValue="false")]
    public function get editable() : Boolean {
      return _editable;
    }

    public function get labelField() : String {
      return list.labelField;
    }

    protected function positionList() : void {
      var local1:Point = localToGlobal(new Point(0,0));
      list.x = local1.x;
      if(local1.y + height + list.height > stage.stageHeight) {
        list.y = local1.y - list.height;
      } else {
        list.y = local1.y + height;
      }
    }

    protected function onStageClick(param1:MouseEvent) : void {
      if(!isOpen) {
        return;
      }
      if(!contains(param1.target as DisplayObject) && !list.contains(param1.target as DisplayObject)) {
        if(highlightedCell != -1) {
          selectedIndex = highlightedCell;
          dispatchEvent(new Event(Event.CHANGE));
        }
        close();
      }
    }

    public function set dropdownWidth(param1:Number) : void {
      _dropdownWidth = param1;
      invalidate(InvalidationType.SIZE);
    }

    [Inspectable(defaultValue="")]
    public function get prompt() : String {
      return _prompt;
    }

    override protected function keyDownHandler(param1:KeyboardEvent) : void {
      isKeyDown = true;
      if(param1.ctrlKey) {
        switch(param1.keyCode) {
          case Keyboard.UP:
            if(highlightedCell > -1) {
              selectedIndex = highlightedCell;
              dispatchEvent(new Event(Event.CHANGE));
            }
            close();
            break;
          case Keyboard.DOWN:
            open();
        }
        return;
      }
      param1.stopPropagation();
      var local2:int = Math.max(calculateAvailableHeight() / list.rowHeight << 0,1);
      var local3:uint = uint(selectedIndex);
      var local4:Number = highlightedCell == -1 ? selectedIndex : highlightedCell;
      var local5:int = -1;
      switch(param1.keyCode) {
        case Keyboard.SPACE:
          if(isOpen) {
            close();
          } else {
            open();
          }
          return;
        case Keyboard.ESCAPE:
          if(isOpen) {
            if(highlightedCell > -1) {
              selectedIndex = selectedIndex;
            }
            close();
          }
          return;
        case Keyboard.UP:
          local5 = Math.max(0,local4 - 1);
          break;
        case Keyboard.DOWN:
          local5 = Math.min(length - 1,local4 + 1);
          break;
        case Keyboard.PAGE_UP:
          local5 = Math.max(local4 - local2,0);
          break;
        case Keyboard.PAGE_DOWN:
          local5 = Math.min(local4 + local2,length - 1);
          break;
        case Keyboard.HOME:
          local5 = 0;
          break;
        case Keyboard.END:
          local5 = length - 1;
          break;
        case Keyboard.ENTER:
          if(_editable && highlightedCell == -1) {
            editableValue = inputField.text;
            selectedIndex = -1;
          } else if(isOpen && highlightedCell > -1) {
            editableValue = null;
            selectedIndex = highlightedCell;
            dispatchEvent(new Event(Event.CHANGE));
          }
          dispatchEvent(new ComponentEvent(ComponentEvent.ENTER));
          close();
          return;
        default:
          if(editable) {
            break;
          }
          local5 = list.getNextIndexAtLetter(String.fromCharCode(param1.keyCode),local4);
          break;
      }
      if(local5 > -1) {
        if(isOpen) {
          highlightCell(local5);
          inputField.text = list.itemToLabel(getItemAt(local5));
        } else {
          highlightCell();
          selectedIndex = local5;
          dispatchEvent(new Event(Event.CHANGE));
        }
      }
    }

    public function get value() : String {
      var local1:Object = null;
      if(editableValue != null) {
        return editableValue;
      }
      local1 = selectedItem;
      if(!_editable && local1.data != null) {
        return local1.data;
      }
      return itemToLabel(local1);
    }

    override protected function focusInHandler(param1:FocusEvent) : void {
      super.focusInHandler(param1);
      if(editable) {
        stage.focus = inputField.textField;
      }
    }

    public function set dataProvider(param1:DataProvider) : void {
      param1.addEventListener(DataChangeEvent.DATA_CHANGE,handleDataChange,false,0,true);
      list.dataProvider = param1;
      invalidate(InvalidationType.DATA);
    }

    [Inspectable(defaultValue="5")]
    public function get rowCount() : uint {
      return _rowCount;
    }

    public function set restrict(param1:String) : void {
      if(componentInspectorSetting && param1 == "") {
        param1 = null;
      }
      if(!_editable) {
        return;
      }
      inputField.restrict = param1;
    }

    public function replaceItemAt(param1:Object, param2:uint) : Object {
      return list.replaceItemAt(param1,param2);
    }

    public function removeAll() : void {
      list.removeAll();
      inputField.text = "";
      invalidate(InvalidationType.DATA);
    }

    protected function onTextInput(param1:Event) : void {
      param1.stopPropagation();
      if(!_editable) {
        return;
      }
      editableValue = inputField.text;
      selectedIndex = -1;
      dispatchEvent(new Event(Event.CHANGE));
    }

    protected function onInputFieldFocus(param1:FocusEvent) : void {
      inputField.addEventListener(ComponentEvent.ENTER,onEnter,false,0,true);
      close();
    }

    protected function onListItemUp(param1:MouseEvent) : void {
      stage.removeEventListener(MouseEvent.MOUSE_UP,onListItemUp);
      if(!(param1.target is ICellRenderer) || !list.contains(param1.target as DisplayObject)) {
        return;
      }
      editableValue = null;
      var local2:* = selectedIndex;
      selectedIndex = param1.target.listData.index;
      if(local2 != selectedIndex) {
        dispatchEvent(new Event(Event.CHANGE));
      }
      close();
    }

    override protected function keyUpHandler(param1:KeyboardEvent) : void {
      isKeyDown = false;
    }

    protected function drawLayout() : void {
      var local1:Number = getStyleValue("buttonWidth") as Number;
      var local2:Number = getStyleValue("textPadding") as Number;
      background.setSize(width,height);
      inputField.x = inputField.y = local2;
      inputField.setSize(width - local1 - local2,height - local2);
      list.width = isNaN(_dropdownWidth) ? width : _dropdownWidth;
      background.enabled = enabled;
      background.drawNow();
    }

    public function set selectedItem(param1:Object) : void {
      list.selectedItem = param1;
      invalidate(InvalidationType.SELECTED);
    }

    public function getItemAt(param1:uint) : Object {
      return list.getItemAt(param1);
    }

    override protected function initializeAccessibility() : void {
      if(ComboBox.createAccessibilityImplementation != null) {
        ComboBox.createAccessibilityImplementation(this);
      }
    }

    public function itemToLabel(param1:Object) : String {
      if(param1 == null) {
        return "";
      }
      return list.itemToLabel(param1);
    }

    public function addItemAt(param1:Object, param2:uint) : void {
      list.addItemAt(param1,param2);
      invalidate(InvalidationType.DATA);
    }

    private function addCloseListener(param1:Event) : * {
      removeEventListener(Event.ENTER_FRAME,addCloseListener);
      if(!isOpen) {
        return;
      }
      stage.addEventListener(MouseEvent.MOUSE_DOWN,onStageClick,false,0,true);
    }

    protected function setEmbedFonts() : void {
      var local1:Object = getStyleValue("embedFonts");
      if(local1 != null) {
        inputField.textField.embedFonts = local1;
      }
    }

    public function set rowCount(param1:uint) : void {
      _rowCount = param1;
      invalidate(InvalidationType.SIZE);
    }

    public function removeItem(param1:Object) : Object {
      return list.removeItem(param1);
    }

    [Collection(collectionClass="fl.data.DataProvider",identifier="item",collectionItem="fl.data.SimpleCollectionItem")]
    public function get dataProvider() : DataProvider {
      return list.dataProvider;
    }

    [Inspectable(verbose="1")]
    public function get restrict() : String {
      return inputField.restrict;
    }

    protected function showPrompt() : void {
      inputField.text = _prompt;
    }

    public function sortItems(... rest) : * {
      return list.sortItems.apply(list,rest);
    }

    public function set editable(param1:Boolean) : void {
      _editable = param1;
      drawTextField();
    }

    public function set labelField(param1:String) : void {
      list.labelField = param1;
      invalidate(InvalidationType.DATA);
    }

    public function get textField() : TextInput {
      return inputField;
    }

    public function set prompt(param1:String) : void {
      if(param1 == "") {
        _prompt = null;
      } else {
        _prompt = param1;
      }
      invalidate(InvalidationType.STATE);
    }

    public function set labelFunction(param1:Function) : void {
      list.labelFunction = param1;
      invalidate(InvalidationType.DATA);
    }

    protected function setStyles() : void {
      copyStylesToChild(background,BACKGROUND_STYLES);
      copyStylesToChild(list,LIST_STYLES);
    }

    public function get length() : int {
      return list.length;
    }

    protected function drawTextFormat() : void {
      var local1:TextFormat = getStyleValue(_enabled ? "textFormat" : "disabledTextFormat") as TextFormat;
      if(local1 == null) {
        local1 = new TextFormat();
      }
      inputField.textField.defaultTextFormat = local1;
      inputField.textField.setTextFormat(local1);
      setEmbedFonts();
    }

    protected function drawTextField() : void {
      inputField.setStyle("upSkin","");
      inputField.setStyle("disabledSkin","");
      inputField.enabled = enabled;
      inputField.editable = _editable;
      inputField.textField.selectable = enabled && _editable;
      inputField.mouseEnabled = inputField.mouseChildren = enabled && _editable;
      inputField.focusEnabled = false;
      if(_editable) {
        inputField.addEventListener(FocusEvent.FOCUS_IN,onInputFieldFocus,false,0,true);
        inputField.addEventListener(FocusEvent.FOCUS_OUT,onInputFieldFocusOut,false,0,true);
      } else {
        inputField.removeEventListener(FocusEvent.FOCUS_IN,onInputFieldFocus);
        inputField.removeEventListener(FocusEvent.FOCUS_OUT,onInputFieldFocusOut);
      }
    }

    public function get labelFunction() : Function {
      return list.labelFunction;
    }

    public function set selectedIndex(param1:int) : void {
      list.selectedIndex = param1;
      highlightCell();
      invalidate(InvalidationType.SELECTED);
    }

    public function get selectedIndex() : int {
      return list.selectedIndex;
    }

    public function close() : void {
      highlightCell();
      highlightedCell = -1;
      if(!isOpen) {
        return;
      }
      dispatchEvent(new Event(Event.CLOSE));
      stage.removeEventListener(MouseEvent.MOUSE_DOWN,onStageClick);
      isOpen = false;
      stage.removeChild(list);
    }
  }
}
