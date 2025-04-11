package controls {
  public class Money {
    public function Money() {
      super();
    }

    public static function numToString(param1:Number, param2:Boolean = true) : String {
      var local3:Vector.<String> = new Vector.<String>();
      var local4:String = param2 ? String(int(param1)) : String(Math.round(param1));
      var local5:int = local4.length - int(local4.length / 3) * 3;
      if(local5 > 0) {
        local4 = (local5 == 1 ? "  " : " ") + local4;
      }
      var local6:int = 0;
      while(local6 < local4.length) {
        local3.push(local4.substr(local6,3));
        local6 += 3;
      }
      local4 = local3.join(" ");
      if(local5 > 0) {
        local4 = local4.substr(3 - local5);
      }
      return local4 + (param2 ? param1.toFixed(10).substr(-11,3) : "");
    }
  }
}
