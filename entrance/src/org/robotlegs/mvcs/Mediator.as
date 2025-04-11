package org.robotlegs.mvcs {
  import flash.display.DisplayObjectContainer;
  import flash.events.Event;
  import flash.events.IEventDispatcher;
  import org.robotlegs.base.EventMap;
  import org.robotlegs.base.MediatorBase;
  import org.robotlegs.core.IEventMap;
  import org.robotlegs.core.IMediatorMap;

  public class Mediator extends MediatorBase {
    [Inject]
    public var contextView:DisplayObjectContainer;

    [Inject]
    public var mediatorMap:IMediatorMap;

    protected var _eventDispatcher:IEventDispatcher;
    protected var _eventMap:IEventMap;

    public function Mediator() {
      super();
    }

    override public function preRemove() : void {
      if(Boolean(this._eventMap)) {
        this._eventMap.unmapListeners();
      }
      super.preRemove();
    }

    public function get eventDispatcher() : IEventDispatcher {
      return this._eventDispatcher;
    }

    [Inject]
    public function set eventDispatcher(value:IEventDispatcher) : void {
      this._eventDispatcher = value;
    }

    protected function get eventMap() : IEventMap {
      return this._eventMap || (this._eventMap = new EventMap(this.eventDispatcher));
    }

    protected function dispatch(event:Event) : Boolean {
      if(this.eventDispatcher.hasEventListener(event.type)) {
        return this.eventDispatcher.dispatchEvent(event);
      }
      return false;
    }

    protected function addViewListener(type:String, listener:Function, eventClass:Class = null, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true) : void {
      this.eventMap.mapListener(IEventDispatcher(viewComponent),type,listener,eventClass,useCapture,priority,useWeakReference);
    }

    protected function removeViewListener(type:String, listener:Function, eventClass:Class = null, useCapture:Boolean = false) : void {
      this.eventMap.unmapListener(IEventDispatcher(viewComponent),type,listener,eventClass,useCapture);
    }

    protected function addContextListener(type:String, listener:Function, eventClass:Class = null, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true) : void {
      this.eventMap.mapListener(this.eventDispatcher,type,listener,eventClass,useCapture,priority,useWeakReference);
    }

    protected function removeContextListener(type:String, listener:Function, eventClass:Class = null, useCapture:Boolean = false) : void {
      this.eventMap.unmapListener(this.eventDispatcher,type,listener,eventClass,useCapture);
    }
  }
}
