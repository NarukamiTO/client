package org.osflash.signals.events {
  import org.osflash.signals.IPrioritySignal;

  public interface IEvent {
    function get target() : Object;
    function set target(value:Object) : void;
    function get currentTarget() : Object;
    function set currentTarget(value:Object) : void;
    function get signal() : IPrioritySignal;
    function set signal(value:IPrioritySignal) : void;
    function get bubbles() : Boolean;
    function set bubbles(value:Boolean) : void;
    function clone() : IEvent;
  }
}
