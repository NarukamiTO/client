package org1.osflash.signals {
  import flash.errors.IllegalOperationError;
  import flash.utils.getQualifiedClassName;

  public class Signal implements ISignal {
    private var _valueClasses:Array;
    private var slots:SlotList = SlotList.NIL;

    public function Signal(... rest) {
      super();
      this.setValueClasses(rest.length == 1 && rest[0] is Array ? rest[0] : rest);
    }

    public function getValueClasses() : Array {
      return this._valueClasses;
    }

    public function setValueClasses(param1:Array) : void {
      this._valueClasses = Boolean(param1) ? param1.slice() : [];
      var local2:int = int(this._valueClasses.length);
      while(Boolean(local2--)) {
        if(!(this._valueClasses[local2] is Class)) {
          throw new ArgumentError("Invalid valueClasses argument: " + "item at index " + local2 + " should be a Class but was:<" + this._valueClasses[local2] + ">." + getQualifiedClassName(this._valueClasses[local2]));
        }
      }
    }

    public function getNumListeners() : uint {
      return this.slots.getLength();
    }

    public function addOnce(param1:Function) : ISlot {
      return this.registerListener(param1,true);
    }

    public function add(param1:Function) : ISlot {
      return this.registerListener(param1);
    }

    public function remove(param1:Function) : ISlot {
      var local2:ISlot = this.slots.find(param1);
      if(!local2) {
        return null;
      }
      this.slots = this.slots.filterNot(param1);
      return local2;
    }

    public function removeAll() : void {
      this.slots = SlotList.NIL;
    }

    public function dispatch(... rest) : void {
      var local2:int = int(this._valueClasses.length);
      var local3:int = int(rest.length);
      if(local3 < local2) {
        throw new ArgumentError("Incorrect number of arguments. " + "Expected at least " + local2 + " but received " + local3 + ".");
      }
      var local4:int = 0;
      while(local4 < local2) {
        if(!(rest[local4] is this._valueClasses[local4] || rest[local4] === null)) {
          throw new ArgumentError("Value object <" + rest[local4] + "> is not an instance of <" + this._valueClasses[local4] + ">.");
        }
        local4++;
      }
      var local5:SlotList = this.slots;
      if(local5.nonEmpty) {
        while(local5.nonEmpty) {
          local5.head.execute(rest);
          local5 = local5.tail;
        }
      }
    }

    public function registerListener(param1:Function, param2:Boolean = false) : ISlot {
      var local3:ISlot = null;
      if(this.registrationPossible(param1,param2)) {
        local3 = new Slot(param1,this,param2);
        this.slots = this.slots.prepend(local3);
        return local3;
      }
      return this.slots.find(param1);
    }

    public function registrationPossible(param1:Function, param2:Boolean) : Boolean {
      if(!this.slots.nonEmpty) {
        return true;
      }
      var local3:ISlot = this.slots.find(param1);
      if(!local3) {
        return true;
      }
      if(local3.getOnce() != param2) {
        throw new IllegalOperationError("You cannot addOnce() then add() the same listener without removing the relationship first.");
      }
      return false;
    }
  }
}
