package controls {
  import fl.controls.List;
  import fl.data.DataProvider;
  import fl.events.ListEvent;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.AntiAliasType;
  import flash.text.GridFitType;
  import flash.text.TextFieldAutoSize;

  [Embed(source="/_assets/assets.swf", symbol="symbol1318")]
  public class TankCombo extends Sprite {
    public var button:ComboButton = new ComboButton();

    private var listBg:TankWindowInner = new TankWindowInner(100,150,100);
    private var list:List = new List();
    private var dp:DataProvider = new DataProvider();
    private var state:Boolean = true;

    public var _labelInfo:Label;

    private var _selectedItem:Object;
    private var _selectedIndex:int = 0;
    private var _width:int;
    private var _value:String;

    public function TankCombo() {
      super();
      this._labelInfo = new Label();
      this._labelInfo.x = -10;
      this._labelInfo.y = 7;
      this._labelInfo.antiAliasType = AntiAliasType.ADVANCED;
      this._labelInfo.gridFitType = GridFitType.SUBPIXEL;
      addChild(this.listBg);
      addChild(this.list);
      addChild(this.button);
      addChild(this._labelInfo);
      this.listBg.y = 3;
      this.list.y = 33;
      this.list.x = 3;
      this.list.setSize(144,115);
      this.list.rowHeight = 20;
      this.list.dataProvider = this.dp;
      this.list.setStyle("cellRenderer",ComboListRenderer);
      this.button.addEventListener(MouseEvent.CLICK,this.switchState);
      this.switchState();
      this.list.addEventListener(ListEvent.ITEM_CLICK,this.onItemClick);
      addEventListener(Event.ADDED_TO_STAGE,this.Conf);
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
        this.button.label = param1.gameName;
      }
      dispatchEvent(new Event(Event.CHANGE));
    }

    public function get selectedIndex() : int {
      return this._selectedIndex;
    }

    public function set label(param1:String) : void {
      this._labelInfo.text = param1;
      this._labelInfo.autoSize = TextFieldAutoSize.RIGHT;
    }

    private function Conf(param1:Event) : void {
    }

    private function onItemClick(param1:ListEvent) : void {
      var local2:Object = param1.item;
      this._selectedIndex = param1.index;
      if(local2.rang == 0) {
        this.button.label = local2.gameName;
        this._selectedItem = local2;
      }
      this.switchState();
      dispatchEvent(new Event(Event.CHANGE));
    }

    private function switchStateClose(param1:MouseEvent = null) : void {
      if(param1.currentTarget as DisplayObject != this.button) {
        this.state = false;
        this.listBg.visible = this.list.visible = this.state;
      }
    }

    private function switchState(param1:MouseEvent = null) : void {
      this.state = !this.state;
      this.listBg.visible = this.list.visible = this.state;
    }

    public function addItem(param1:Object) : void {
      var local2:Object = null;
      this.dp.addItem(param1);
      local2 = this.dp.getItemAt(0);
      this._selectedItem = local2;
      this.button.label = local2.gameName;
    }

    public function sortOn(param1:Object, param2:Object = null) : void {
      var local3:Object = null;
      this.dp.sortOn(param1,param2);
      local3 = this.dp.getItemAt(0);
      this._selectedItem = local3;
      this._value = this._selectedItem.gameName;
      this.button.label = local3.gameName;
    }

    public function clear() : void {
      this.dp = new DataProvider();
      this.list.dataProvider = this.dp;
      this.button.label = "";
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.listBg.width = this._width;
      this.button.width = this._width;
      this.list.width = this._width - 6;
      this.list.invalidate();
    }

    public function set value(param1:String) : void {
      var local2:Object = null;
      this._value = "";
      this.button.label = this._value;
      this._selectedItem = null;
      var local3:int = 0;
      while(local3 < this.dp.length) {
        local2 = this.dp.getItemAt(local3);
        if(local2.gameName == param1) {
          this._selectedItem = local2;
          this._value = this._selectedItem.gameName;
          this.button.label = this._value;
          this.list.selectedIndex = local3;
          this.list.scrollToSelected();
        }
        local3++;
      }
      dispatchEvent(new Event(Event.CHANGE));
    }

    public function selectItemByField(param1:String, param2:Object) : void {
      var local4:Object = null;
      var local3:int = 0;
      while(local3 < this.dp.length) {
        local4 = this.dp.getItemAt(local3);
        if(local4[param1] == param2) {
          this._selectedItem = local4;
          this._value = this._selectedItem.gameName;
          this.button.label = this._value;
          this.list.selectedIndex = local3;
          this.list.scrollToSelected();
          dispatchEvent(new Event(Event.CHANGE));
          return;
        }
        local3++;
      }
    }

    public function get value() : String {
      return this._value;
    }
  }
}
