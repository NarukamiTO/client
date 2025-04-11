package alternativa.tanks.view.forms.freeuids {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.base.LabelBase;
  import controls.dropdownlist.DPLBackground;
  import flash.display.Sprite;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.ui.Keyboard;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class FreeUidsForm extends Sprite {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var localeService:ILocaleService;

    public static const DEFAULT_WIDTH:int = 200;
    public static const BGD_HEIGHT:int = 137;
    public static const LABEL_POS_X:int = 6;
    public static const LABEL_POS_Y:int = 3;
    public static const ITEM_POS_Y:int = 36;

    private var _background:DPLBackground;
    private var _label:LabelBase;
    private var _items:Array;
    private var _selectedItemIndex:int = -1;
    private var _width:int = 200;

    public function FreeUidsForm() {
      super();
      this.init();
    }

    private function init() : void {
      this.visible = false;
      this._items = [];
      this._background = new DPLBackground(this._width,BGD_HEIGHT);
      addChild(this._background);
      this._label = new LabelBase();
      this._label.width = this._width;
      this._label.text = localeService.getText(TanksLocale.TEXT_FREE_UIDS_FORM_HEADER);
      this._label.x = LABEL_POS_X;
      this._label.y = LABEL_POS_Y;
      addChild(this._label);
    }

    public function create(param1:Vector.<String>) : void {
      var local4:FreeUidsFormRender = null;
      this.destroy();
      var local2:int = int(param1.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = new FreeUidsFormRender(this._width,local3,param1[local3]);
        if(local3 == 0) {
          local4.y = ITEM_POS_Y;
        } else {
          local4.y = this._items[local3 - 1].y + this._items[local3 - 1].height;
        }
        local4.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverItem);
        local4.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutItem);
        local4.addEventListener(MouseEvent.CLICK,this.onClickItem);
        addChild(local4);
        this._items.push(local4);
        local3++;
      }
      this.selectedItemIndex = 0;
      this.show();
    }

    private function onRollOverItem(param1:MouseEvent) : void {
      this.selectedItemIndex = FreeUidsFormRender(param1.currentTarget).index;
    }

    private function onRollOutItem(param1:MouseEvent) : void {
      this.resetCurrentSelectedItem();
    }

    private function onClickItem(param1:MouseEvent) : void {
      var local2:FreeUidsFormEvent = new FreeUidsFormEvent(FreeUidsFormEvent.CLICK_ITEM);
      local2.uid = FreeUidsFormRender(param1.currentTarget).uid;
      dispatchEvent(local2);
    }

    public function destroy() : void {
      var local3:FreeUidsFormRender = null;
      this.hide();
      var local1:int = int(this._items.length);
      var local2:int = 0;
      while(local2 < local1) {
        local3 = this._items[local2];
        local3.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverItem);
        local3.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutItem);
        local3.removeEventListener(MouseEvent.CLICK,this.onClickItem);
        removeChild(local3);
        local2++;
      }
      this._selectedItemIndex = -1;
      this._items = [];
    }

    public function show() : void {
      this.visible = true;
      display.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
    }

    private function onKeyDown(param1:KeyboardEvent) : void {
      var local2:FreeUidsFormEvent = null;
      if(param1.keyCode == Keyboard.TAB || param1.keyCode == Keyboard.ESCAPE) {
        dispatchEvent(new FreeUidsFormEvent(FreeUidsFormEvent.FOCUS_OUT));
      }
      if(param1.keyCode == Keyboard.DOWN) {
        this.setSelectedNextItem();
      }
      if(param1.keyCode == Keyboard.UP) {
        this.setSelectedPreviousItem();
      }
      if(param1.keyCode == Keyboard.ENTER && this.hasSelectedItem()) {
        local2 = new FreeUidsFormEvent(FreeUidsFormEvent.CLICK_ITEM);
        local2.uid = this._items[this._selectedItemIndex].uid;
        dispatchEvent(local2);
      }
    }

    private function setSelectedNextItem() : void {
      if(this.hasSelectedItem()) {
        ++this.selectedItemIndex;
      } else {
        this.selectedItemIndex = 0;
      }
    }

    private function setSelectedPreviousItem() : void {
      if(this.hasSelectedItem()) {
        --this.selectedItemIndex;
      } else {
        this.selectedItemIndex = this.getLastItemIndex();
      }
    }

    public function hide() : void {
      this.visible = false;
      display.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
    }

    public function get selectedItemIndex() : int {
      return this._selectedItemIndex;
    }

    public function set selectedItemIndex(param1:int) : void {
      if(this._items.length == 0 || this._selectedItemIndex == param1) {
        return;
      }
      this.resetCurrentSelectedItem();
      if(param1 > this.getLastItemIndex()) {
        this._selectedItemIndex = 0;
      } else {
        this._selectedItemIndex = param1;
      }
      if(this._selectedItemIndex < 0) {
        this._selectedItemIndex = this.getLastItemIndex();
      }
      this._items[this._selectedItemIndex].setSelected(true);
    }

    private function resetCurrentSelectedItem() : void {
      if(this.hasSelectedItem()) {
        this._items[this._selectedItemIndex].setSelected(false);
        this._selectedItemIndex = -1;
      }
    }

    private function hasSelectedItem() : Boolean {
      return this._selectedItemIndex != -1;
    }

    private function getLastItemIndex() : int {
      return this._items.length - 1;
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this._background.width = this._width;
      this._label.width = this._width;
    }
  }
}
