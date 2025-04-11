package org.osflash.signals {
  import flash.errors.IllegalOperationError;
  import org.osflash.signals.events.IBubbleEventHandler;
  import org.osflash.signals.events.IEvent;

  [DefaultProperty("valueClasses")]
  public class DeluxeSignal implements ISignalOwner, IPrioritySignal {
    protected var _target:Object;
    protected var _valueClasses:Array;
    protected var listenerBoxes:Array;
    protected var listenersNeedCloning:Boolean = false;

    public function DeluxeSignal(target:Object = null, ... valueClasses) {
      super();
      this._target = target;
      this.listenerBoxes = [];
      if(valueClasses.length == 1 && valueClasses[0] is Array) {
        valueClasses = valueClasses[0];
      }
      this.valueClasses = valueClasses;
    }

    public function get valueClasses() : Array {
      return this._valueClasses;
    }

    public function set valueClasses(value:Array) : void {
      this._valueClasses = Boolean(value) ? value.slice() : [];
      for(var i:int = int(this._valueClasses.length); Boolean(i--); ) {
        if(!(this._valueClasses[i] is Class)) {
          throw new ArgumentError("Invalid valueClasses argument: item at index " + i + " should be a Class but was:<" + this._valueClasses[i] + ">.");
        }
      }
    }

    public function get numListeners() : uint {
      return this.listenerBoxes.length;
    }

    public function get target() : Object {
      return this._target;
    }

    public function set target(value:Object) : void {
      if(value == this._target) {
        return;
      }
      this.removeAll();
      this._target = value;
    }

    public function add(listener:Function) : Function {
      return this.addWithPriority(listener);
    }

    public function addWithPriority(listener:Function, priority:int = 0) : Function {
      this.registerListener(listener,false,priority);
      return listener;
    }

    public function addOnce(listener:Function) : Function {
      return this.addOnceWithPriority(listener);
    }

    public function addOnceWithPriority(listener:Function, priority:int = 0) : Function {
      this.registerListener(listener,true,priority);
      return listener;
    }

    public function remove(listener:Function) : Function {
      if(this.indexOfListener(listener) == -1) {
        return listener;
      }
      if(this.listenersNeedCloning) {
        this.listenerBoxes = this.listenerBoxes.slice();
        this.listenersNeedCloning = false;
      }
      this.listenerBoxes.splice(this.indexOfListener(listener),1);
      return listener;
    }

    public function removeAll() : void {
      for(var i:uint = this.listenerBoxes.length; Boolean(i--); ) {
        this.remove(this.listenerBoxes[i].listener as Function);
      }
    }

    public function dispatch(... valueObjects) : void {
      var valueObject:Object = null;
      var valueClass:Class = null;
      var listener:Function = null;
      var listenerBox:Object = null;
      var len:int = int(this._valueClasses.length);
      for(var i:int = 0; i < len; i++) {
        valueObject = valueObjects[i];
        if(!(valueObject === null || valueObject is (valueClass = this._valueClasses[i]))) {
          throw new ArgumentError("Value object <" + valueObject + "> is not an instance of <" + valueClass + ">.");
        }
      }
      var event:IEvent = valueObjects[0] as IEvent;
      if(Boolean(event)) {
        if(Boolean(event.target)) {
          valueObjects[0] = event = event.clone();
        }
        event.target = this.target;
        event.currentTarget = this.target;
        event.signal = this;
      }
      this.listenersNeedCloning = true;
      if(Boolean(this.listenerBoxes.length)) {
        for each(listenerBox in this.listenerBoxes) {
          listener = listenerBox.listener;
          if(Boolean(listenerBox.once)) {
            this.remove(listener);
          }
          listener.apply(null,valueObjects);
        }
      }
      this.listenersNeedCloning = false;
      if(!event || !event.bubbles) {
        return;
      }
      var currentTarget:Object = this.target;
      while(true) {
        currentTarget = currentTarget.parent;
        if(!(currentTarget && currentTarget.hasOwnProperty("parent") && (Boolean(currentTarget)))) {
          break;
        }
        if(currentTarget is IBubbleEventHandler) {
          if(!IBubbleEventHandler(event.currentTarget = currentTarget).onEventBubbled(event)) {
            break;
          }
        }
      }
    }

    protected function indexOfListener(listener:Function) : int {
      for(var i:int = int(this.listenerBoxes.length); Boolean(i--); ) {
        if(this.listenerBoxes[i].listener == listener) {
          return i;
        }
      }
      return -1;
    }

    protected function registerListener(listener:Function, once:Boolean = false, priority:int = 0) : void {
      var argumentString:String = null;
      var prevListenerBox:Object = null;
      if(listener.length < this._valueClasses.length) {
        argumentString = listener.length == 1 ? "argument" : "arguments";
        throw new ArgumentError("Listener has " + listener.length + " " + argumentString + " but it needs at least " + this._valueClasses.length + " to match the given value classes.");
      }
      var listenerBox:Object = {
        "listener":listener,
        "once":once,
        "priority":priority
      };
      if(!this.listenerBoxes.length) {
        this.listenerBoxes[0] = listenerBox;
        return;
      }
      var prevListenerIndex:int = this.indexOfListener(listener);
      if(prevListenerIndex >= 0) {
        prevListenerBox = this.listenerBoxes[prevListenerIndex];
        if(Boolean(prevListenerBox.once) && !once) {
          throw new IllegalOperationError("You cannot addOnce() then add() the same listener without removing the relationship first.");
        }
        if(!prevListenerBox.once && once) {
          throw new IllegalOperationError("You cannot add() then addOnce() the same listener without removing the relationship first.");
        }
        return;
      }
      if(this.listenersNeedCloning) {
        this.listenerBoxes = this.listenerBoxes.slice();
        this.listenersNeedCloning = false;
      }
      var len:int = int(this.listenerBoxes.length);
      for(var i:int = 0; i < len; i++) {
        if(priority > this.listenerBoxes[i].priority) {
          this.listenerBoxes.splice(i,0,listenerBox);
          return;
        }
      }
      this.listenerBoxes[this.listenerBoxes.length] = listenerBox;
    }
  }
}
