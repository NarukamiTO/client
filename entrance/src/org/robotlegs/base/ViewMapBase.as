package org.robotlegs.base {
  import flash.display.DisplayObjectContainer;
  import flash.events.Event;
  import org.robotlegs.core.IInjector;

  public class ViewMapBase {
    protected var _enabled:Boolean = true;
    protected var _contextView:DisplayObjectContainer;
    protected var injector:IInjector;
    protected var useCapture:Boolean;
    protected var viewListenerCount:uint;

    public function ViewMapBase(contextView:DisplayObjectContainer, injector:IInjector) {
      super();
      this.injector = injector;
      this.useCapture = true;
      this.contextView = contextView;
    }

    public function get contextView() : DisplayObjectContainer {
      return this._contextView;
    }

    public function set contextView(value:DisplayObjectContainer) : void {
      if(value != this._contextView) {
        this.removeListeners();
        this._contextView = value;
        if(this.viewListenerCount > 0) {
          this.addListeners();
        }
      }
    }

    public function get enabled() : Boolean {
      return this._enabled;
    }

    public function set enabled(value:Boolean) : void {
      if(value != this._enabled) {
        this.removeListeners();
        this._enabled = value;
        if(this.viewListenerCount > 0) {
          this.addListeners();
        }
      }
    }

    protected function addListeners() : void {
    }

    protected function removeListeners() : void {
    }

    protected function onViewAdded(e:Event) : void {
    }
  }
}
