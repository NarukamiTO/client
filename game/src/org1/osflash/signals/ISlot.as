package org1.osflash.signals {
  public interface ISlot {
    function getListener() : Function;
    function setListener(param1:Function) : void;
    function getParams() : Array;
    function setParams(param1:Array) : void;
    function getOnce() : Boolean;
    function getPriority() : int;
    function getEnabled() : Boolean;
    function setEnabled(param1:Boolean) : void;
    function execute0() : void;
    function execute1(param1:Object) : void;
    function execute(param1:Array) : void;
    function remove() : void;
  }
}
