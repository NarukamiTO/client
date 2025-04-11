package org.robotlegs.core {
  public interface ICommandMap {
    function detain(command:Object) : void;
    function release(command:Object) : void;
    function execute(commandClass:Class, payload:Object = null, payloadClass:Class = null, named:String = "") : void;
    function mapEvent(eventType:String, commandClass:Class, eventClass:Class = null, oneshot:Boolean = false) : void;
    function unmapEvent(eventType:String, commandClass:Class, eventClass:Class = null) : void;
    function unmapEvents() : void;
    function hasEventCommand(eventType:String, commandClass:Class, eventClass:Class = null) : Boolean;
  }
}
