package org.osflash.signals.natives {
  import flash.events.Event;
  import flash.events.IEventDispatcher;

  public class NativeMappedSignal extends NativeRelaySignal {
    protected var _eventClass:Class;

    private var _mappingFunction:Function = null;

    public function NativeMappedSignal(target:IEventDispatcher, eventType:String, eventClass:Class = null, ... mappedTypes) {
      this._eventClass = eventClass || Event;
      super(target,eventType);
      valueClasses = mappedTypes;
    }

    public function get eventClass() : Class {
      return this._eventClass;
    }

    protected function get mappingFunction() : Function {
      return this._mappingFunction;
    }

    public function mapTo(... objectListOrFunction) : NativeMappedSignal {
      if(this.isArgumentListAFunction(objectListOrFunction)) {
        this._mappingFunction = objectListOrFunction[0] as Function;
        if(this.hasFunctionMoreThanOneArgument(this._mappingFunction)) {
          throw new ArgumentError("Mapping function has " + this._mappingFunction.length + " arguments but it needs zero or one of type Event");
        }
      } else {
        this._mappingFunction = function():Object {
          return objectListOrFunction;
        };
      }
      return this;
    }

    private function isArgumentListAFunction(argList:Array) : Boolean {
      return argList.length == 1 && argList[0] is Function;
    }

    private function hasFunctionMoreThanOneArgument(f:Function) : Boolean {
      return f.length > 1;
    }

    override public function dispatch(... valueObjects) : void {
      var mappedData:Object = null;
      if(this.areValueObjectValidForMapping(valueObjects)) {
        mappedData = this.mapEvent(valueObjects[0] as Event);
        this.dispatchMappedData(mappedData);
      } else {
        super.dispatch.apply(null,valueObjects);
      }
    }

    private function areValueObjectValidForMapping(valueObjects:Array) : Boolean {
      return valueObjects.length == 1 && valueObjects[0] is this._eventClass;
    }

    private function dispatchMappedData(mappedData:Object) : void {
      if(mappedData is Array) {
        if(this.shouldArrayBePassedWithoutUnrolling) {
          super.dispatch.call(null,mappedData);
        } else {
          super.dispatch.apply(null,mappedData);
        }
      } else {
        super.dispatch.call(null,mappedData);
      }
    }

    private function get shouldArrayBePassedWithoutUnrolling() : Boolean {
      return _valueClasses.length == 1 && _valueClasses[0] == Array;
    }

    protected function get mappingFunctionWantsEvent() : Boolean {
      return this._mappingFunction.length == 1;
    }

    protected function get mappingFunctionExists() : Boolean {
      return this._mappingFunction != null;
    }

    protected function mapEvent(eventFromTarget:Event) : Object {
      if(this.mappingFunctionExists) {
        if(this.mappingFunctionWantsEvent) {
          return this._mappingFunction(eventFromTarget);
        }
        return this._mappingFunction();
      }
      if(valueClasses.length == 0) {
        return [];
      }
      throw new ArgumentError("There are valueClasses set to be dispatched <" + valueClasses + "> but mappingFunction is null.");
    }
  }
}
