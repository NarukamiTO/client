package org.osflash.signals {
  public interface ISignal {
    function get valueClasses() : Array;
    function set valueClasses(value:Array) : void;
    function get numListeners() : uint;
    function add(listener:Function) : Function;
    function addOnce(listener:Function) : Function;
    function remove(listener:Function) : Function;
  }
}
