package org1.osflash.signals {
  public interface ISignal {
    function getValueClasses() : Array;
    function setValueClasses(param1:Array) : void;
    function getNumListeners() : uint;
    function addOnce(param1:Function) : ISlot;
    function add(param1:Function) : ISlot;
    function dispatch(... rest) : void;
    function remove(param1:Function) : ISlot;
    function removeAll() : void;
  }
}
