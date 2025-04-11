package alternativa.tanks.gui {
  import base.DiscreteSprite;
  import controls.base.TankDefaultButton;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.utils.Dictionary;

  public class TabPanel extends DiscreteSprite {
    private static const BUTTON_WIDTH:int = 100;
    private static const BUTTON_HEIGHT:int = 30;
    private static const MARGIN:int = 11;

    public static const LEFT:String = "LEFT";
    public static const RIGHT:String = "RIGHT";

    private var contents:Dictionary = new Dictionary();
    private var selected:TankDefaultButton;
    private var buttonPanel:DiscreteSprite = new DiscreteSprite();
    private var contentPanel:DiscreteSprite = new DiscreteSprite();
    private var countButtonLine:int;
    private var _width:int;
    private var _height:int;
    private var _buttonAlign:String;

    public function TabPanel(param1:String = "LEFT") {
      super();
      this._buttonAlign = param1;
      addChild(this.buttonPanel);
      addChild(this.contentPanel);
      addEventListener(Event.ADDED_TO_STAGE,this.addResizeListener);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
    }

    private function addResizeListener(param1:Event) : void {
      stage.addEventListener(Event.RESIZE,this.onResize);
      this.onResize();
    }

    private function onRemoveFromStage(param1:Event) : void {
      stage.removeEventListener(Event.RESIZE,this.onResize);
    }

    public function onResize(param1:Event = null) : void {
      var local3:TankDefaultButton = null;
      var local4:int = 0;
      var local5:* = undefined;
      this.countButtonLine = this.width / (MARGIN + BUTTON_WIDTH);
      var local2:int = 0;
      while(local2 < this.buttonPanel.numChildren) {
        local3 = TankDefaultButton(this.buttonPanel.getChildAt(local2));
        local3.width = BUTTON_WIDTH;
        local4 = MARGIN;
        if(local2 + 1 > this.countButtonLine) {
          local4 = 2 * MARGIN + local3.height;
        }
        if(this._buttonAlign == LEFT) {
          local3.x = MARGIN + local2 % this.countButtonLine * (local3.width + MARGIN);
        } else {
          local3.x = this.width - local3.width - MARGIN - local2 % this.countButtonLine * (local3.width + MARGIN);
        }
        local3.y = local4;
        local2++;
      }
      this.contentPanel.y = BUTTON_HEIGHT + 2 * MARGIN;
      if(this.selected != null) {
        local5 = this.contents[this.selected];
        local5.width = this.width;
        local5.height = this.height - (BUTTON_HEIGHT + 2 * MARGIN);
      }
    }

    public function addTab(param1:String, param2:DiscreteSprite, param3:Class) : Object {
      var local4:TankDefaultButton = new param3();
      local4.label = param1;
      local4.width = BUTTON_WIDTH;
      local4.addEventListener(MouseEvent.CLICK,this.onClickTab);
      this.buttonPanel.addChild(local4);
      this.contents[local4] = param2;
      this.onResize();
      return local4;
    }

    public function select(param1:int) : void {
      this.selectTab(TankDefaultButton(this.buttonPanel.getChildAt(param1)));
    }

    private function selectTab(param1:TankDefaultButton) : void {
      if(this.selected != null) {
        this.selected.enable = true;
        this.contentPanel.removeChild(this.contents[this.selected]);
      }
      param1.enable = false;
      var local2:DiscreteSprite = this.contents[param1];
      this.contentPanel.addChild(local2);
      this.selected = param1;
      this.onResize();
    }

    private function onClickTab(param1:MouseEvent) : void {
      var local2:TankDefaultButton = TankDefaultButton(param1.currentTarget);
      this.selectTab(local2);
    }

    override public function get width() : Number {
      return this._width;
    }

    override public function set width(param1:Number) : void {
      this._width = param1;
      this.onResize();
    }

    override public function get height() : Number {
      return this._height;
    }

    override public function set height(param1:Number) : void {
      this._height = param1;
      this.onResize();
    }

    public function destroy() : void {
      var local1:DiscreteSprite = this.contents[this.selected];
      if(this.contentPanel.contains(local1)) {
        this.contentPanel.removeChild(local1);
      }
      if(this.contentPanel != null && contains(this.contentPanel)) {
        removeChild(this.contentPanel);
      }
      if(this.buttonPanel != null && contains(this.buttonPanel)) {
        removeChild(this.buttonPanel);
      }
      local1 = null;
    }
  }
}
