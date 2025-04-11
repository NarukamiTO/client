package org.robotlegs.base {
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.IEventDispatcher;
  import org.robotlegs.core.IContext;

  public class ContextBase implements IContext, IEventDispatcher {
    protected var _eventDispatcher:IEventDispatcher;

    public function ContextBase() {
      super();
      this._eventDispatcher = new EventDispatcher(this);
    }

    public function get eventDispatcher() : IEventDispatcher {
      return this._eventDispatcher;
    }

    public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void {
      this.eventDispatcher.addEventListener(type,listener,useCapture,priority);
    }

    public function dispatchEvent(event:Event) : Boolean {
      if(this.eventDispatcher.hasEventListener(event.type)) {
        return this.eventDispatcher.dispatchEvent(event);
      }
      return false;
    }

    public function hasEventListener(type:String) : Boolean {
      return this.eventDispatcher.hasEventListener(type);
    }

    public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void {
      this.eventDispatcher.removeEventListener(type,listener,useCapture);
    }

    public function willTrigger(type:String) : Boolean {
      return this.eventDispatcher.willTrigger(type);
    }
  }
}
