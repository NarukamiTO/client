package org.osflash.signals.natives {
  import flash.events.Event;
  import flash.events.IEventDispatcher;
  import org.osflash.signals.DeluxeSignal;

  public class NativeRelaySignal extends DeluxeSignal {
    protected var _eventType:String;

    public function NativeRelaySignal(target:IEventDispatcher, eventType:String, eventClass:Class = null) {
      super(target,eventClass || Event);
      this._eventType = eventType;
    }

    override public function addWithPriority(listener:Function, priority:int = 0) : Function {
      var prevListenerCount:uint = listenerBoxes.length;
      super.addWithPriority(listener);
      if(prevListenerCount == 0 && listenerBoxes.length == 1) {
        IEventDispatcher(_target).addEventListener(this._eventType,dispatch,false,priority);
      }
      return listener;
    }

    override public function addOnceWithPriority(listener:Function, priority:int = 0) : Function {
      var prevListenerCount:uint = listenerBoxes.length;
      super.addOnceWithPriority(listener);
      if(prevListenerCount == 0 && listenerBoxes.length == 1) {
        IEventDispatcher(_target).addEventListener(this._eventType,dispatch,false,priority);
      }
      return listener;
    }

    override public function remove(listener:Function) : Function {
      var prevListenerCount:uint = listenerBoxes.length;
      super.remove(listener);
      if(prevListenerCount == 1 && listenerBoxes.length == 0) {
        IEventDispatcher(_target).removeEventListener(this._eventType,dispatch);
      }
      return listener;
    }
  }
}
