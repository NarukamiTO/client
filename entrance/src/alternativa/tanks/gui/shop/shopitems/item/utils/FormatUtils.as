package alternativa.tanks.gui.shop.shopitems.item.utils {
  public class FormatUtils {
    public function FormatUtils() {
      super();
    }

    public static function valueToString(param1:Number, param2:int, param3:Boolean) : String {
      if(param3) {
        param1 = Math.ceil(param1);
      }
      var local4:String = param1.toFixed(param2);
      var local5:String = "";
      if(param2 > 0) {
        local5 = local4.substr(local4.length - param2 - 1);
        if(local5 == ".00") {
          local5 = "";
        }
        local4 = local4.substr(0,local4.length - param2 - 1);
      }
      while(local4.length > 3) {
        local5 = " " + local4.substr(local4.length - 3,3) + local5;
        local4 = local4.substr(0,local4.length - 3);
      }
      return local4 + local5;
    }
  }
}
