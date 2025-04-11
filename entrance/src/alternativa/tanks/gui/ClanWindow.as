package alternativa.tanks.gui {
  import alternativa.osgi.service.display.IDisplay;
  import base.DiscreteSprite;
  import flash.display.Stage;
  import flash.events.Event;
  import forms.TankWindowWithHeader;

  public class ClanWindow extends DiscreteSprite {
    [Inject]
    public static var display:IDisplay;

    protected var _window:TankWindowWithHeader;

    private var _width:Number;
    private var _height:Number;

    public function ClanWindow() {
      super();
      if(!display.systemLayer.contains(this)) {
        display.systemLayer.addChild(this);
      }
      this.setEventListeners();
    }

    public function onResize(param1:Event = null) : void {
      var local2:Stage = display.stage;
      var local3:int = int(Math.max(960,local2.stageWidth));
      this._window.x = Math.round(local3 / 3);
      this._window.y = 60;
      this._width = Math.round(local3 * 2 / 3);
      this._height = Math.max(display.stage.stageHeight - 60,530);
      this._window.width = this._width;
    }

    public function destroy() : void {
      this.removeEventListeners();
      if(this._window != null) {
        removeChild(this._window);
      }
      this._window = null;
      if(display.systemLayer.contains(this)) {
        display.systemLayer.removeChild(this);
      }
    }

    private function setEventListeners() : void {
      display.stage.addEventListener(Event.RESIZE,this.onResize);
    }

    private function removeEventListeners() : void {
      display.stage.removeEventListener(Event.RESIZE,this.onResize);
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
  }
}
