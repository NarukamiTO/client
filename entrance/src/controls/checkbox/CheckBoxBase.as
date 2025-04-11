package controls.checkbox {
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.MouseEvent;

  public class CheckBoxBase extends Sprite {
    private static const defaultCheckedClass:Class = CheckBoxBase_defaultCheckedClass;
    private static const defaultCheckedBitmapData:BitmapData = Bitmap(new defaultCheckedClass()).bitmapData;
    private static const checkboxUpClass:Class = CheckBoxBase_checkboxUpClass;
    private static const checkboxUpBitmapData:BitmapData = Bitmap(new checkboxUpClass()).bitmapData;
    private static const checkboxDownClass:Class = CheckBoxBase_checkboxDownClass;
    private static const checkboxDownBitmapData:BitmapData = Bitmap(new checkboxDownClass()).bitmapData;
    private static const checkboxOverClass:Class = CheckBoxBase_checkboxOverClass;
    private static const checkboxOverBitmapData:BitmapData = Bitmap(new checkboxOverClass()).bitmapData;

    private var checkedIcon:Bitmap;
    private var checkboxUpIcon:Bitmap;
    private var checkboxDownIcon:Bitmap;
    private var checkboxOverIcon:Bitmap;
    private var boxIcons:Array;
    private var _checked:Boolean;
    private var mouseWasDown:Boolean;
    private var _enabled:Boolean;

    protected var labelInfo:LabelBase;

    public function CheckBoxBase(param1:BitmapData = null) {
      super();
      this.checkboxUpIcon = new Bitmap(checkboxUpBitmapData);
      addChild(this.checkboxUpIcon);
      this.checkboxDownIcon = new Bitmap(checkboxDownBitmapData);
      addChild(this.checkboxDownIcon);
      this.checkboxOverIcon = new Bitmap(checkboxOverBitmapData);
      addChild(this.checkboxOverIcon);
      this.checkedIcon = new Bitmap(param1 != null ? param1 : defaultCheckedBitmapData);
      addChild(this.checkedIcon);
      this.checkedIcon.visible = false;
      this.boxIcons = [this.checkboxUpIcon,this.checkboxDownIcon,this.checkboxOverIcon];
      tabEnabled = false;
      this.showBoxIcon(this.checkboxUpIcon);
      this.enabled = true;
      this.labelInfo = new LabelBase();
      this.labelInfo.x = 29;
      this.labelInfo.y = 7;
      addChild(this.labelInfo);
    }

    private function showBoxIcon(param1:Bitmap) : void {
      var local2:Bitmap = null;
      for each(local2 in this.boxIcons) {
        local2.visible = false;
      }
      param1.visible = true;
    }

    public function get checked() : Boolean {
      return this._checked;
    }

    public function setCheckedWithoutEvent(param1:Boolean) : void {
      if(this._checked != param1) {
        this._checked = param1;
        this.checkedIcon.visible = this._checked;
      }
    }

    public function set checked(param1:Boolean) : void {
      if(this._checked != param1) {
        this.changeState();
      }
    }

    public function set enabled(param1:Boolean) : void {
      if(this._enabled != param1) {
        this._enabled = param1;
        if(this._enabled) {
          buttonMode = true;
          mouseEnabled = true;
          this.addListeners();
        } else {
          buttonMode = false;
          mouseEnabled = false;
          this.removeListeners();
        }
      }
    }

    public function set label(param1:String) : void {
      this.labelInfo.text = param1;
    }

    public function verticalLabelCorrectionBy(param1:int) : void {
      this.labelInfo.y += param1;
    }

    private function addListeners() : void {
      addEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
      addEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
    }

    private function removeListeners() : void {
      removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
      removeEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
    }

    private function onMouseEvent(param1:MouseEvent) : void {
      this.checkedIcon.y = 0;
      switch(param1.type) {
        case MouseEvent.MOUSE_OVER:
          this.showBoxIcon(this.checkboxOverIcon);
          break;
        case MouseEvent.MOUSE_OUT:
          this.mouseWasDown = false;
          this.showBoxIcon(this.checkboxUpIcon);
          break;
        case MouseEvent.MOUSE_DOWN:
          if(this._checked) {
            this.checkedIcon.y = 2;
          }
          this.mouseWasDown = true;
          this.showBoxIcon(this.checkboxDownIcon);
          break;
        case MouseEvent.MOUSE_UP:
          this.showBoxIcon(this.checkboxOverIcon);
          if(this.mouseWasDown) {
            this.mouseWasDown = false;
            this.changeState();
          }
      }
    }

    private function changeState() : void {
      this._checked = !this._checked;
      this.checkedIcon.visible = this._checked;
      dispatchEvent(new CheckBoxEvent(CheckBoxEvent.STATE_CHANGED));
    }
  }
}
