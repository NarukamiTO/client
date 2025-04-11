package org.robotlegs.base {
  import flash.events.Event;
  import flash.events.IEventDispatcher;
  import flash.utils.Dictionary;
  import flash.utils.describeType;
  import org.robotlegs.core.ICommandMap;
  import org.robotlegs.core.IInjector;
  import org.robotlegs.core.IReflector;

  public class CommandMap implements ICommandMap {
    protected var eventDispatcher:IEventDispatcher;
    protected var injector:IInjector;
    protected var reflector:IReflector;
    protected var eventTypeMap:Dictionary;
    protected var verifiedCommandClasses:Dictionary;
    protected var detainedCommands:Dictionary;

    public function CommandMap(eventDispatcher:IEventDispatcher, injector:IInjector, reflector:IReflector) {
      super();
      this.eventDispatcher = eventDispatcher;
      this.injector = injector;
      this.reflector = reflector;
      this.eventTypeMap = new Dictionary(false);
      this.verifiedCommandClasses = new Dictionary(false);
      this.detainedCommands = new Dictionary(false);
    }

    public function mapEvent(eventType:String, commandClass:Class, eventClass:Class = null, oneshot:Boolean = false) : void {
      var eventClassMap:Dictionary;
      var callbacksByCommandClass:Dictionary;
      var callback:Function;
      this.verifyCommandClass(commandClass);
      eventClass ||= Event;
      eventClassMap = this.eventTypeMap[eventType] = this.eventTypeMap[eventType] || new Dictionary(false);
      callbacksByCommandClass = eventClassMap[eventClass] = eventClassMap[eventClass] || new Dictionary(false);
      if(callbacksByCommandClass[commandClass] != null) {
        throw new ContextError(ContextError.E_COMMANDMAP_OVR + " - eventType (" + eventType + ") and Command (" + commandClass + ")");
      }
      callback = function(event:Event):void {
        routeEventToCommand(event,commandClass,oneshot,eventClass);
      };
      this.eventDispatcher.addEventListener(eventType,callback,false,0,true);
      callbacksByCommandClass[commandClass] = callback;
    }

    public function unmapEvent(eventType:String, commandClass:Class, eventClass:Class = null) : void {
      var eventClassMap:Dictionary = this.eventTypeMap[eventType];
      if(eventClassMap == null) {
        return;
      }
      var callbacksByCommandClass:Dictionary = eventClassMap[eventClass || Event];
      if(callbacksByCommandClass == null) {
        return;
      }
      var callback:Function = callbacksByCommandClass[commandClass];
      if(callback == null) {
        return;
      }
      this.eventDispatcher.removeEventListener(eventType,callback,false);
      delete callbacksByCommandClass[commandClass];
    }

    public function unmapEvents() : void {
      var eventType:String = null;
      var eventClassMap:Dictionary = null;
      var callbacksByCommandClass:Dictionary = null;
      var callback:Function = null;
      for(eventType in this.eventTypeMap) {
        eventClassMap = this.eventTypeMap[eventType];
        for each(callbacksByCommandClass in eventClassMap) {
          for each(callback in callbacksByCommandClass) {
            this.eventDispatcher.removeEventListener(eventType,callback,false);
          }
        }
      }
      this.eventTypeMap = new Dictionary(false);
    }

    public function hasEventCommand(eventType:String, commandClass:Class, eventClass:Class = null) : Boolean {
      var eventClassMap:Dictionary = this.eventTypeMap[eventType];
      if(eventClassMap == null) {
        return false;
      }
      var callbacksByCommandClass:Dictionary = eventClassMap[eventClass || Event];
      if(callbacksByCommandClass == null) {
        return false;
      }
      return callbacksByCommandClass[commandClass] != null;
    }

    public function execute(commandClass:Class, payload:Object = null, payloadClass:Class = null, named:String = "") : void {
      this.verifyCommandClass(commandClass);
      if(payload != null || payloadClass != null) {
        payloadClass ||= this.reflector.getClass(payload);
        if(payload is Event && payloadClass != Event) {
          this.injector.mapValue(Event,payload);
        }
        this.injector.mapValue(payloadClass,payload,named);
      }
      var command:Object = this.injector.instantiate(commandClass);
      if(payload !== null || payloadClass != null) {
        if(payload is Event && payloadClass != Event) {
          this.injector.unmap(Event);
        }
        this.injector.unmap(payloadClass,named);
      }
      command.execute();
    }

    public function detain(command:Object) : void {
      this.detainedCommands[command] = true;
    }

    public function release(command:Object) : void {
      if(Boolean(this.detainedCommands[command])) {
        delete this.detainedCommands[command];
      }
    }

    protected function verifyCommandClass(commandClass:Class) : void {
      if(!this.verifiedCommandClasses[commandClass]) {
        this.verifiedCommandClasses[commandClass] = describeType(commandClass).factory.method.(@name == "execute").length();
        if(!this.verifiedCommandClasses[commandClass]) {
          throw new ContextError(ContextError.E_COMMANDMAP_NOIMPL + " - " + commandClass);
        }
      }
    }

    protected function routeEventToCommand(event:Event, commandClass:Class, oneshot:Boolean, originalEventClass:Class) : Boolean {
      if(!(event is originalEventClass)) {
        return false;
      }
      this.execute(commandClass,event);
      if(oneshot) {
        this.unmapEvent(event.type,commandClass,originalEventClass);
      }
      return true;
    }
  }
}
