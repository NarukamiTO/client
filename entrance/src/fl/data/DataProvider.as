package fl.data {
  import fl.events.DataChangeEvent;
  import fl.events.DataChangeType;
  import flash.events.EventDispatcher;

  [Event(name="dataChange",type="fl.events.DataChangeEvent")]
  [Event(name="preDataChange",type="fl.events.DataChangeEvent")]
  public class DataProvider extends EventDispatcher {
    protected var data:Array;

    public function DataProvider(param1:Object = null) {
      super();
      if(param1 == null) {
        data = [];
      } else {
        data = getDataFromObject(param1);
      }
    }

    public function invalidateItemAt(param1:int) : void {
      checkIndex(param1,data.length - 1);
      dispatchChangeEvent(DataChangeType.INVALIDATE,[data[param1]],param1,param1);
    }

    protected function dispatchPreChangeEvent(param1:String, param2:Array, param3:int, param4:int) : void {
      dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,param1,param2,param3,param4));
    }

    public function getItemIndex(param1:Object) : int {
      return data.indexOf(param1);
    }

    public function removeItemAt(param1:uint) : Object {
      checkIndex(param1,data.length - 1);
      dispatchPreChangeEvent(DataChangeType.REMOVE,data.slice(param1,param1 + 1),param1,param1);
      var local2:Array = data.splice(param1,1);
      dispatchChangeEvent(DataChangeType.REMOVE,local2,param1,param1);
      return local2[0];
    }

    protected function getDataFromObject(param1:Object) : Array {
      var local2:Array = null;
      var local3:Array = null;
      var local4:uint = 0;
      var local5:Object = null;
      var local6:XML = null;
      var local7:XMLList = null;
      var local8:XML = null;
      var local9:XMLList = null;
      var local10:XML = null;
      var local11:XMLList = null;
      var local12:XML = null;
      if(param1 is Array) {
        local3 = param1 as Array;
        if(local3.length > 0) {
          if(local3[0] is String || local3[0] is Number) {
            local2 = [];
            local4 = 0;
            while(local4 < local3.length) {
              local5 = {
                "label":String(local3[local4]),
                "data":local3[local4]
              };
              local2.push(local5);
              local4++;
            }
            return local2;
          }
        }
        return param1.concat();
      }
      if(param1 is DataProvider) {
        return param1.toArray();
      }
      if(param1 is XML) {
        local6 = param1 as XML;
        local2 = [];
        local7 = local6.*;
        for each(local8 in local7) {
          param1 = {};
          local9 = local8.attributes();
          for each(local10 in local9) {
            param1[local10.localName()] = local10.toString();
          }
          local11 = local8.*;
          for each(local12 in local11) {
            if(Boolean(local12.hasSimpleContent())) {
              param1[local12.localName()] = local12.toString();
            }
          }
          local2.push(param1);
        }
        return local2;
      }
      throw new TypeError("Error: Type Coercion failed: cannot convert " + param1 + " to Array or DataProvider.");
    }

    public function addItem(param1:Object) : void {
      dispatchPreChangeEvent(DataChangeType.ADD,[param1],data.length - 1,data.length - 1);
      data.push(param1);
      dispatchChangeEvent(DataChangeType.ADD,[param1],data.length - 1,data.length - 1);
    }

    public function concat(param1:Object) : void {
      addItems(param1);
    }

    public function getItemAt(param1:uint) : Object {
      checkIndex(param1,data.length - 1);
      return data[param1];
    }

    public function sortOn(param1:Object, param2:Object = null) : * {
      dispatchPreChangeEvent(DataChangeType.SORT,data.concat(),0,data.length - 1);
      var local3:Array = data.sortOn(param1,param2);
      dispatchChangeEvent(DataChangeType.SORT,data.concat(),0,data.length - 1);
      return local3;
    }

    public function toArray() : Array {
      return data.concat();
    }

    public function addItems(param1:Object) : void {
      addItemsAt(param1,data.length);
    }

    public function clone() : DataProvider {
      return new DataProvider(data);
    }

    public function sort(... rest) : * {
      dispatchPreChangeEvent(DataChangeType.SORT,data.concat(),0,data.length - 1);
      var local2:Array = data.sort.apply(data,rest);
      dispatchChangeEvent(DataChangeType.SORT,data.concat(),0,data.length - 1);
      return local2;
    }

    public function get length() : uint {
      return data.length;
    }

    public function addItemAt(param1:Object, param2:uint) : void {
      checkIndex(param2,data.length);
      dispatchPreChangeEvent(DataChangeType.ADD,[param1],param2,param2);
      data.splice(param2,0,param1);
      dispatchChangeEvent(DataChangeType.ADD,[param1],param2,param2);
    }

    override public function toString() : String {
      return "DataProvider [" + data.join(" , ") + "]";
    }

    public function invalidateItem(param1:Object) : void {
      var local2:uint = uint(getItemIndex(param1));
      if(local2 == -1) {
        return;
      }
      invalidateItemAt(local2);
    }

    protected function dispatchChangeEvent(param1:String, param2:Array, param3:int, param4:int) : void {
      dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,param1,param2,param3,param4));
    }

    protected function checkIndex(param1:int, param2:int) : void {
      if(param1 > param2 || param1 < 0) {
        throw new RangeError("DataProvider index (" + param1 + ") is not in acceptable range (0 - " + param2 + ")");
      }
    }

    public function addItemsAt(param1:Object, param2:uint) : void {
      checkIndex(param2,data.length);
      var local3:Array = getDataFromObject(param1);
      dispatchPreChangeEvent(DataChangeType.ADD,local3,param2,param2 + local3.length - 1);
      data.splice.apply(data,[param2,0].concat(local3));
      dispatchChangeEvent(DataChangeType.ADD,local3,param2,param2 + local3.length - 1);
    }

    public function replaceItem(param1:Object, param2:Object) : Object {
      var local3:int = getItemIndex(param2);
      if(local3 != -1) {
        return replaceItemAt(param1,local3);
      }
      return null;
    }

    public function removeItem(param1:Object) : Object {
      var local2:int = getItemIndex(param1);
      if(local2 != -1) {
        return removeItemAt(local2);
      }
      return null;
    }

    public function merge(param1:Object) : void {
      var local6:Object = null;
      var local2:Array = getDataFromObject(param1);
      var local3:uint = local2.length;
      var local4:uint = data.length;
      dispatchPreChangeEvent(DataChangeType.ADD,data.slice(local4,data.length),local4,this.data.length - 1);
      var local5:uint = 0;
      while(local5 < local3) {
        local6 = local2[local5];
        if(getItemIndex(local6) == -1) {
          data.push(local6);
        }
        local5++;
      }
      if(data.length > local4) {
        dispatchChangeEvent(DataChangeType.ADD,data.slice(local4,data.length),local4,this.data.length - 1);
      } else {
        dispatchChangeEvent(DataChangeType.ADD,[],-1,-1);
      }
    }

    public function replaceItemAt(param1:Object, param2:uint) : Object {
      checkIndex(param2,data.length - 1);
      var local3:Array = [data[param2]];
      dispatchPreChangeEvent(DataChangeType.REPLACE,local3,param2,param2);
      data[param2] = param1;
      dispatchChangeEvent(DataChangeType.REPLACE,local3,param2,param2);
      return local3[0];
    }

    public function invalidate() : void {
      dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.INVALIDATE_ALL,data.concat(),0,data.length));
    }

    public function removeAll() : void {
      var local1:Array = data.concat();
      dispatchPreChangeEvent(DataChangeType.REMOVE_ALL,local1,0,local1.length);
      data = [];
      dispatchChangeEvent(DataChangeType.REMOVE_ALL,local1,0,local1.length);
    }
  }
}
