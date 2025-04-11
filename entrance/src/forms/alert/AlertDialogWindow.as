package forms.alert {
  import base.DiscreteSprite;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import forms.TankWindowWithHeader;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class AlertDialogWindow extends DialogWindow {
    protected static const GAP_11:int = 11;
    protected static const GAP_5:int = 5;
    protected static const BUTTON_PLACE_DEFAULT_HEIGHT:int = 30;

    private var _header:String;
    private var _window:TankWindowWithHeader;
    private var _inner:TankWindowInner;

    protected var _cancelButton:DefaultButtonBase;
    protected var _contentPlace:Sprite;
    protected var _buttonPlace:Sprite;
    protected var _contentPlaceWidth:int;
    protected var _contentPlaceHeight:int;
    protected var _buttonPlaceHeight:int;

    private var _cancelButtonText:String;

    public function AlertDialogWindow(param1:String, param2:String) {
      super();
      this._header = param1;
      this._cancelButtonText = param2;
      this.init();
    }

    protected function init() : void {
      this._window = new TankWindowWithHeader(this._header);
      addChild(this._window);
      this._inner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      addChild(this._inner);
      this._contentPlace = new DiscreteSprite();
      addChild(this._contentPlace);
      this._buttonPlace = new DiscreteSprite();
      addChild(this._buttonPlace);
      this._cancelButton = new DefaultButtonBase();
      this._cancelButton.label = this._cancelButtonText;
      this._cancelButton.addEventListener(MouseEvent.CLICK,this.onCancel);
      this._buttonPlace.addChild(this._cancelButton);
      this.setButtonPlaceHeight(BUTTON_PLACE_DEFAULT_HEIGHT);
    }

    public function enqueueDialog() : void {
      dialogService.enqueueDialog(this);
    }

    protected function setContentPlaceSize(param1:int, param2:int) : void {
      this._contentPlaceWidth = param1;
      this._contentPlaceHeight = param2;
      this.resize();
    }

    protected function setButtonPlaceHeight(param1:int) : void {
      this._buttonPlaceHeight = param1;
      this.resize();
    }

    private function resize() : void {
      this._window.width = this._contentPlaceWidth + 2 * GAP_11;
      this._window.height = GAP_11 + this._contentPlaceHeight + GAP_5 + this._buttonPlaceHeight + GAP_11;
      this._inner.width = this._contentPlaceWidth;
      this._inner.height = this._contentPlaceHeight;
      this._inner.x = GAP_11;
      this._inner.y = GAP_11;
      this._contentPlace.x = GAP_11;
      this._contentPlace.y = GAP_11;
      this._contentPlace.graphics.clear();
      this._contentPlace.graphics.beginFill(0,0);
      this._contentPlace.graphics.drawRect(0,0,this._contentPlaceWidth,this._contentPlaceHeight);
      this._contentPlace.graphics.endFill();
      this._buttonPlace.x = GAP_11;
      this._buttonPlace.y = GAP_11 + this._contentPlaceHeight + GAP_5;
      this._buttonPlace.graphics.clear();
      this._buttonPlace.graphics.beginFill(0,0);
      this._buttonPlace.graphics.drawRect(0,0,this._contentPlaceWidth,this._buttonPlaceHeight);
      this._buttonPlace.graphics.endFill();
      this.alignCancelButton();
    }

    protected function alignCancelButton() : void {
      this._cancelButton.x = this._contentPlaceWidth - this._cancelButton.width;
    }

    protected function onCancel(param1:Event = null) : void {
      this.destroy();
    }

    protected function destroy() : void {
      this._cancelButton.removeEventListener(MouseEvent.CLICK,this.onCancel);
      dialogService.removeDialog(this);
    }

    override protected function cancelKeyPressed() : void {
      this.onCancel();
    }
  }
}
