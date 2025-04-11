package org1.osflash.signals {
  public final class SlotList {
    public static const NIL:SlotList = new SlotList(null,null);

    public var head:ISlot;
    public var tail:SlotList;
    public var nonEmpty:Boolean = false;

    public function SlotList(param1:ISlot, param2:SlotList = null) {
      super();
      if(!param1 && !param2) {
        if(Boolean(NIL)) {
          throw new ArgumentError("Parameters head and tail are null. Use the NIL element instead.");
        }
        this.nonEmpty = false;
      } else {
        if(!param1) {
          throw new ArgumentError("Parameter head cannot be null.");
        }
        this.head = param1;
        this.tail = param2 || NIL;
        this.nonEmpty = true;
      }
    }

    public function getLength() : uint {
      if(!this.nonEmpty) {
        return 0;
      }
      if(this.tail == NIL) {
        return 1;
      }
      var local1:uint = 0;
      var local2:SlotList = this;
      while(local2.nonEmpty) {
        local1++;
        local2 = local2.tail;
      }
      return local1;
    }

    public function prepend(param1:ISlot) : SlotList {
      return new SlotList(param1,this);
    }

    public function append(param1:ISlot) : SlotList {
      if(!param1) {
        return this;
      }
      if(!this.nonEmpty) {
        return new SlotList(param1);
      }
      if(this.tail == NIL) {
        return new SlotList(param1).prepend(this.head);
      }
      var local2:SlotList = new SlotList(this.head);
      var local3:SlotList = local2;
      var local4:SlotList = this.tail;
      while(local4.nonEmpty) {
        local3 = local3.tail = new SlotList(local4.head);
        local4 = local4.tail;
      }
      local3.tail = new SlotList(param1);
      return local2;
    }

    public function filterNot(param1:Function) : SlotList {
      if(!this.nonEmpty || param1 == null) {
        return this;
      }
      if(param1 == this.head.getListener()) {
        return this.tail;
      }
      var local2:SlotList = new SlotList(this.head);
      var local3:SlotList = local2;
      var local4:SlotList = this.tail;
      while(local4.nonEmpty) {
        if(local4.head.getListener() == param1) {
          local3.tail = local4.tail;
          return local2;
        }
        local3 = local3.tail = new SlotList(local4.head);
        local4 = local4.tail;
      }
      return this;
    }

    public function contains(param1:Function) : Boolean {
      if(!this.nonEmpty) {
        return false;
      }
      var local2:SlotList = this;
      while(local2.nonEmpty) {
        if(local2.head.getListener() == param1) {
          return true;
        }
        local2 = local2.tail;
      }
      return false;
    }

    public function find(param1:Function) : ISlot {
      if(!this.nonEmpty) {
        return null;
      }
      var local2:SlotList = this;
      while(local2.nonEmpty) {
        if(local2.head.getListener() == param1) {
          return local2.head;
        }
        local2 = local2.tail;
      }
      return null;
    }

    public function toString() : String {
      var local1:String = "";
      var local2:SlotList = this;
      while(local2.nonEmpty) {
        local1 += local2.head + " -> ";
        local2 = local2.tail;
      }
      local1 += "NIL";
      return "[List " + local1 + "]";
    }
  }
}
