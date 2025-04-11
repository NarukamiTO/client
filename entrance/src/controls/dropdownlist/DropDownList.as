package controls.dropdownlist {
  import alternativa.osgi.service.display.IDisplay;
  import base.DiscreteSprite;
  import controls.ComboButton;
  import controls.base.LabelBase;
  import fl.controls.List;
  import fl.data.DataProvider;
  import fl.events.ListEvent;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFieldType;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.AlertUtils;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.removeDisplayObject;
  import utils.ScrollStyleUtils;

  public class DropDownList extends DiscreteSprite {
    [Inject]
    public static var display:IDisplay;

    protected var button:ComboButton = new ComboButton();
    protected var _listBg:DPLBackground;
    protected var list:List = new List();
    protected var dp:DataProvider = new DataProvider();

    private var _label:LabelBase;
    private var hiddenInput:TextField;

    protected var _selectedItem:Object;
    protected var _selectedIndex:int = 0;

    private var _width:int;
    private var _listWidthExtension:int;
    private var _height:int = 151;

    protected var _value:Object;

    private var _isOpen:Boolean;
    private var _isOver:Boolean;
    private var viewName:String;

    public function DropDownList(param1:String = "gameName") {
      super();
      this.viewName = param1;
      this.init();
    }

    protected function init() : void {
      this.hiddenInput = new TextField();
      this.hiddenInput.visible = false;
      this.hiddenInput.type = TextFieldType.INPUT;
      this._label = new LabelBase();
      this._label.x = -10;
      this._label.y = 7;
      addChild(this.listBg);
      addChild(this.list);
      addChild(this.button);
      addChild(this._label);
      this.listBg.y = 5;
      this.list.y = 33;
      this.list.x = 3;
      this.list.setSize(144,241);
      this.list.rowHeight = 20;
      this.list.dataProvider = this.dp;
      this.setRenderer(ComboR);
      ScrollStyleUtils.setGrayStyle(this.list);
      this.list.focusEnabled = false;
      this.list.visible = false;
      this.listBg.visible = false;
      this.button._label.x;
      this.button.addEventListener(MouseEvent.CLICK,this.onButtonClick);
    }

    public function setRenderer(param1:Class) : void {
      this.list.setStyle("cellRenderer",param1);
    }

    protected function onButtonClick(param1:MouseEvent) : void {
      if(this.isOpen) {
        this.close();
      } else {
        this.open();
      }
    }

    protected function open() : void {
      if(!this.isOpen) {
        this.setEvent();
        this.listBg.visible = this.list.visible = true;
        display.stage.focus = this.hiddenInput;
        display.stage.addChild(this.hiddenInput);
        this._isOpen = true;
        this._isOver = true;
        dispatchEvent(new Event(Event.OPEN));
      }
    }

    public function get isOpen() : Boolean {
      return this._isOpen;
    }

    private function setEvent() : void {
      this.list.addEventListener(ListEvent.ITEM_CLICK,this.onItemClick);
      this.hiddenInput.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHiddenInput);
      display.stage.addEventListener(MouseEvent.CLICK,this.onClickStage);
      this.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
      this.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
    }

    private function onClickStage(param1:MouseEvent) : void {
      if(!this._isOver) {
        this.close();
      }
    }

    private function onRollOver(param1:MouseEvent) : void {
      this._isOver = true;
    }

    private function onRollOut(param1:MouseEvent) : void {
      this._isOver = false;
    }

    protected function close() : void {
      if(this.isOpen) {
        this.removeEvents();
        this.listBg.visible = this.list.visible = false;
        removeDisplayObject(this.hiddenInput);
        this.clearFocus();
        this._isOpen = false;
      }
    }

    private function removeEvents() : void {
      this.hiddenInput.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHiddenInput);
      this.list.removeEventListener(ListEvent.ITEM_CLICK,this.onItemClick);
      display.stage.removeEventListener(MouseEvent.CLICK,this.onClickStage);
      this.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
      this.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
    }

    private function clearFocus() : void {
      if(display.stage.focus == this.hiddenInput) {
        display.stage.focus = null;
      }
    }

    public function get selectedItem() : Object {
      return this._selectedItem;
    }

    public function set selectedItem(param1:Object) : void {
      if(param1 == null) {
        this._selectedItem = null;
        this.button.label = "";
      } else {
        this._selectedIndex = this.dp.getItemIndex(param1);
        this._selectedItem = this.dp.getItemAt(this._selectedIndex);
        this.button.label = param1[this.viewName];
      }
      dispatchEvent(new Event(Event.CHANGE));
    }

    public function get selectedIndex() : int {
      return this._selectedIndex;
    }

    public function set label(param1:String) : void {
      this._label.text = param1;
      this._label.autoSize = TextFieldAutoSize.RIGHT;
    }

    public function getLabelWidth() : int {
      return this._label.width;
    }

    protected function onItemClick(param1:ListEvent) : void {
      var local2:Object = param1.item;
      this._selectedIndex = param1.index;
      if(local2.rang == 0) {
        this.button.label = local2[this.viewName];
        this._selectedItem = local2;
      }
      this.close();
      dispatchEvent(new Event(Event.CHANGE));
    }

    public function addItem(param1:Object) : void {
      var local2:Object = null;
      this.dp.addItem(param1);
      local2 = this.dp.getItemAt(0);
      this._selectedItem = local2;
      this.button.label = local2[this.viewName];
    }

    public function replaceItemAt(param1:Object, param2:int) : void {
      this.dp.replaceItemAt(param1,param2);
    }

    public function sortOn(param1:Object, param2:Object = null) : void {
      var local3:Object = null;
      this.dp.sortOn(param1,param2);
      if(this.dp.length > 0) {
        local3 = this.dp.getItemAt(0);
        this._selectedItem = local3;
        this._value = this._selectedItem[this.viewName];
        this.button.label = local3[this.viewName];
      }
    }

    public function clear() : void {
      this.dp = new DataProvider();
      this.list.dataProvider = this.dp;
      this.button.label = "";
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this.draw();
    }

    public function set listWidthExtension(param1:Number) : void {
      this._listWidthExtension = param1;
      this.draw();
    }

    override public function set height(param1:Number) : void {
      this._height = param1;
      this.draw();
    }

    protected function draw() : void {
      this.listBg.width = this._width + this._listWidthExtension;
      this.listBg.height = this._height - 2;
      this.button.width = this._width;
      this.list.setSize(this._width + this._listWidthExtension,this._height - 34);
      this.list.invalidate();
    }

    public function set value(param1:Object) : void {
      var local2:Object = null;
      this._value = "";
      this.button.label = this._value.toString();
      this._selectedItem = null;
      var local3:int = 0;
      while(local3 < this.dp.length) {
        local2 = this.dp.getItemAt(local3);
        if(local2[this.viewName] == param1) {
          this._selectedItem = local2;
          this._value = this._selectedItem[this.viewName];
          this.button.label = this._value.toString();
          this.list.selectedIndex = local3;
          this.list.scrollToSelected();
        }
        local3++;
      }
      dispatchEvent(new Event(Event.CHANGE));
    }

    public function selectItemByField(param1:String, param2:Object) : void {
      var local3:int = this.findItemIndexByField(param1,param2);
      if(local3 != -1) {
        this._selectedItem = this.dp.getItemAt(local3);
        this._value = this._selectedItem[this.viewName];
        this.button.label = this._value.toString();
        this.list.selectedIndex = local3;
        this.list.scrollToSelected();
        dispatchEvent(new Event(Event.CHANGE));
      }
    }

    public function selectItemAt(param1:int) : void {
      if(param1 >= this.dp.length) {
        return;
      }
      this._selectedItem = this.dp.getItemAt(param1);
      this._value = this._selectedItem[this.viewName];
      this.button.label = this._value.toString();
      this.list.selectedIndex = param1;
      this.list.scrollToSelected();
      dispatchEvent(new Event(Event.CHANGE));
    }

    public function findItemIndexByField(param1:String, param2:Object) : int {
      var local4:Object = null;
      var local3:int = 0;
      while(local3 < this.dp.length) {
        local4 = this.dp.getItemAt(local3);
        if(local4[param1] == param2) {
          return local3;
        }
        local3++;
      }
      return -1;
    }

    public function get value() : Object {
      return this._value;
    }

    private function onKeyUpHiddenInput(param1:KeyboardEvent) : void {
      if(AlertUtils.isCancelKey(param1.keyCode)) {
        this.close();
      } else {
        this.getItemByFirstChar(this.hiddenInput.text.substr(0,1));
        this.hiddenInput.text = "";
      }
    }

    public function getItemByFirstChar(param1:String) : Object {
      var local4:Object = null;
      var local2:uint = this.dp.length;
      var local3:int = 0;
      while(local3 < local2) {
        local4 = this.dp.getItemAt(local3);
        if(local4[this.viewName].substr(0,1).toLowerCase() == param1.toLowerCase()) {
          this._selectedItem = local4;
          this._value = this._selectedItem[this.viewName];
          this.button.label = this._value.toString();
          this.list.selectedIndex = local3;
          this.list.verticalScrollPosition = local3 * 20;
          dispatchEvent(new Event(Event.CHANGE));
          return local4;
        }
        local3++;
      }
      return null;
    }

    protected function get listBg() : DPLBackground {
      if(!this._listBg) {
        this._listBg = new DPLBackground(100,275);
      }
      return this._listBg;
    }

    public function get rowHeight() : Number {
      return this.list.rowHeight;
    }

    protected function getList() : List {
      return this.list;
    }
  }
}
