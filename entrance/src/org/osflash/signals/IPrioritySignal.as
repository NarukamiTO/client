package org.osflash.signals {
  public interface IPrioritySignal extends ISignal {
    function addWithPriority(listener:Function, priority:int = 0) : Function;
    function addOnceWithPriority(listener:Function, priority:int = 0) : Function;
  }
}
