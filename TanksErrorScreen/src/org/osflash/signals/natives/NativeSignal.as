package org.osflash.signals.natives {
  import flash.errors.IllegalOperationError;
  import flash.events.Event;
  import flash.events.IEventDispatcher;

  [DefaultProperty("eventClass")]
  public class NativeSignal implements INativeSignalOwner {
    protected var _target:IEventDispatcher;
    protected var _eventType:String;
    protected var _eventClass:Class;
    protected var listenerBoxes:Array;

    public function NativeSignal(target:IEventDispatcher = null, eventType:String = "", eventClass:Class = null) {
      super();
      this.listenerBoxes = [];
      this.target = target;
      this.eventType = eventType;
      this.eventClass = eventClass;
    }

    public function get eventType() : String {
      return this._eventType;
    }

    public function set eventType(value:String) : void {
      this._eventType = value;
    }

    public function get eventClass() : Class {
      return this._eventClass;
    }

    public function set eventClass(value:Class) : void {
      this._eventClass = value || Event;
    }

    public function get valueClasses() : Array {
      return [this._eventClass];
    }

    public function set valueClasses(value:Array) : void {
      this.eventClass = Boolean(value) ? value[0] : null;
    }

    public function get numListeners() : uint {
      return this.listenerBoxes.length;
    }

    public function get target() : IEventDispatcher {
      return this._target;
    }

    public function set target(value:IEventDispatcher) : void {
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
      var listenerIndex:int = this.indexOfListener(listener);
      if(listenerIndex == -1) {
        return listener;
      }
      var listenerBox:Object = this.listenerBoxes.splice(listenerIndex,1)[0];
      this._target.removeEventListener(this._eventType,listenerBox.execute);
      return listener;
    }

    public function removeAll() : void {
      for(var i:int = int(this.listenerBoxes.length); Boolean(i--); ) {
        this.remove(this.listenerBoxes[i].listener as Function);
      }
    }

    public function dispatch(event:Event) : Boolean {
      if(!(event is this._eventClass)) {
        throw new ArgumentError("Event object " + event + " is not an instance of " + this._eventClass + ".");
      }
      if(event.type != this._eventType) {
        throw new ArgumentError("Event object has incorrect type. Expected <" + this._eventType + "> but was <" + event.type + ">.");
      }
      return this._target.dispatchEvent(event);
    }

    protected function registerListener(listener:Function, once:Boolean = false, priority:int = 0) : void {
      var prevListenerIndex:int;
      var listenerBox:Object;
      var prevlistenerBox:Object = null;
      var signal:NativeSignal = null;
      if(listener.length != 1) {
        throw new ArgumentError("Listener for native event must declare exactly 1 argument.");
      }
      prevListenerIndex = this.indexOfListener(listener);
      if(prevListenerIndex >= 0) {
        prevlistenerBox = this.listenerBoxes[prevListenerIndex];
        if(Boolean(prevlistenerBox.once) && !once) {
          throw new IllegalOperationError("You cannot addOnce() then add() the same listener without removing the relationship first.");
        }
        if(!prevlistenerBox.once && once) {
          throw new IllegalOperationError("You cannot add() then addOnce() the same listener without removing the relationship first.");
        }
        return;
      }
      listenerBox = {
        "listener":listener,
        "once":once,
        "execute":listener
      };
      if(once) {
        signal = this;
        listenerBox.execute = function(event:Event):void {
          signal.remove(listener);
          listener(event);
        };
      }
      this.listenerBoxes[this.listenerBoxes.length] = listenerBox;
      this._target.addEventListener(this._eventType,listenerBox.execute,false,priority);
    }

    protected function indexOfListener(listener:Function) : int {
      for(var i:int = int(this.listenerBoxes.length); Boolean(i--); ) {
        if(this.listenerBoxes[i].listener == listener) {
          return i;
        }
      }
      return -1;
    }
  }
}
