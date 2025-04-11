package com.hurlant.util {
  import flash.utils.ByteArray;

  public class ArrayUtil {
    public function ArrayUtil() {
      super();
    }

    public static function equals(param1:ByteArray, param2:ByteArray) : Boolean {
      if(param1.length != param2.length) {
        return false;
      }
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        if(param1[local4] != param2[local4]) {
          return false;
        }
        local4++;
      }
      return true;
    }
  }
}
