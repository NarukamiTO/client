package alternativa.utils.filters {
  import flash.filters.ColorMatrixFilter;
  import flash.utils.Dictionary;

  public class BCSHFilter {
    private static const DELTA:Number = 0.01;

    private static var filters:Dictionary = new Dictionary();

    public function BCSHFilter() {
      super();
    }

    public static function createFilter(param1:Number, param2:Number, param3:Number, param4:Number) : ColorMatrixFilter {
      var local5:Object = null;
      var local6:AdjustColor = null;
      var local7:ColorMatrixFilter = null;
      var local8:Object = null;
      for(local5 in filters) {
        if(areEqual(param1,local5.b) && areEqual(param2,local5.c) && areEqual(param3,local5.s) && areEqual(param4,local5.h)) {
          return filters[local5];
        }
      }
      local6 = new AdjustColor();
      local6.brightness = param1;
      local6.contrast = param2;
      local6.saturation = param3;
      local6.hue = param4;
      local7 = new ColorMatrixFilter();
      local7.matrix = local6.CalculateFinalFlatArray();
      local8 = {
        "b":param1,
        "c":param2,
        "s":param3,
        "h":param4
      };
      filters[local8] = local7;
      return local7;
    }

    private static function areEqual(param1:Number, param2:Number) : Boolean {
      return Math.abs(param1 - param2) < DELTA;
    }
  }
}
