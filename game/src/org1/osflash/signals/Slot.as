package org1.osflash.signals {
  public class Slot implements ISlot {
    public var _signal:ISignal;
    public var _enabled:Boolean = true;
    public var _listener:Function;
    public var _once:Boolean = false;
    public var _priority:int = 0;
    public var _params:Array;

    public function Slot(param1:Function, param2:ISignal, param3:Boolean = false, param4:int = 0) {
      super();
      this._listener = param1;
      this._once = param3;
      this._signal = param2;
      this._priority = param4;
      this.verifyListener(param1);
    }

    public function execute0() : void {
      if(!this._enabled) {
        return;
      }
      if(this._once) {
        this.remove();
      }
      if(Boolean(this._params) && Boolean(this._params.length)) {
        this._listener.apply(null,this._params);
        return;
      }
      this._listener();
    }

    public function execute1(param1:Object) : void {
      if(!this._enabled) {
        return;
      }
      if(this._once) {
        this.remove();
      }
      if(Boolean(this._params) && Boolean(this._params.length)) {
        this._listener.apply(null,[param1].concat(this._params));
        return;
      }
      this._listener(param1);
    }

    public function execute(param1:Array) : void {
      if(!this._enabled) {
        return;
      }
      if(this._once) {
        this.remove();
      }
      if(Boolean(this._params) && Boolean(this._params.length)) {
        param1 = param1.concat(this._params);
      }
      var local2:int = int(param1.length);
      if(local2 == 0) {
        this._listener();
      } else if(local2 == 1) {
        this._listener(param1[0]);
      } else if(local2 == 2) {
        this._listener(param1[0],param1[1]);
      } else if(local2 == 3) {
        this._listener(param1[0],param1[1],param1[2]);
      } else {
        this._listener.apply(null,param1);
      }
    }

    public function getListener() : Function {
      return this._listener;
    }

    public function setListener(param1:Function) : void {
      if(null == param1) {
        throw new ArgumentError("Given listener is null.\nDid you want to set enabled to false instead?");
      }
      this.verifyListener(param1);
      this._listener = param1;
    }

    public function getOnce() : Boolean {
      return this._once;
    }

    public function getPriority() : int {
      return this._priority;
    }

    public function toString() : String {
      return "[Slot listener: " + this._listener + ", once: " + this._once + ", priority: " + this._priority + ", enabled: " + this._enabled + "]";
    }

    public function getEnabled() : Boolean {
      return this._enabled;
    }

    public function setEnabled(param1:Boolean) : void {
      this._enabled = param1;
    }

    public function getParams() : Array {
      return this._params;
    }

    public function setParams(param1:Array) : void {
      this._params = param1;
    }

    public function remove() : void {
      this._signal.remove(this._listener);
    }

    public function verifyListener(param1:Function) : void {
      if(null == param1) {
        throw new ArgumentError("Given listener is null.");
      }
      if(null == this._signal) {
        throw new Error("Internal signal reference has not been set yet.");
      }
    }
  }
}
