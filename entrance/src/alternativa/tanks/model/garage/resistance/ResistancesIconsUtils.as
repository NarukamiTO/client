package alternativa.tanks.model.garage.resistance {
  import flash.display.Bitmap;
  import flash.display.DisplayObjectContainer;
  import projects.tanks.client.commons.types.ItemGarageProperty;

  public class ResistancesIconsUtils {
    public function ResistancesIconsUtils() {
      super();
    }

    public static function addResistanceIcons(param1:Bitmap, param2:Vector.<ItemGarageProperty>) : void {
      var local6:ItemGarageProperty = null;
      var local7:Bitmap = null;
      var local3:DisplayObjectContainer = param1.parent;
      var local4:uint = param2.length;
      var local5:int = 0;
      while(local5 < local4) {
        local6 = param2[local5];
        local7 = new Bitmap(ResistancesIcons.getBitmapData(local6));
        local7.x = (param1.width - local7.width + 1 >> 1) + param1.x;
        local7.y = (param1.height - local7.height - 7 >> 1) + param1.y;
        local3.addChild(local7);
        local5++;
      }
    }

    public static function getResistanceBigIcon(param1:ItemGarageProperty) : Bitmap {
      return new Bitmap(ResistancesIcons.getBigBitmapData(param1));
    }
  }
}
