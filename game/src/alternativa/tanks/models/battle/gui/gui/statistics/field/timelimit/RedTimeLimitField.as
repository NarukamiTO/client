package alternativa.tanks.models.battle.gui.gui.statistics.field.timelimit {
  import alternativa.tanks.models.battle.gui.gui.statistics.field.wink.WinkManager;
  import flash.display.DisplayObject;
  import flash.filters.BitmapFilter;
  import flash.filters.BitmapFilterQuality;
  import flash.filters.DropShadowFilter;
  import flash.geom.ColorTransform;

  public class RedTimeLimitField extends TimeLimitField {
    public function RedTimeLimitField(param1:int, param2:DisplayObject, param3:WinkManager, param4:Boolean) {
      super(param1,param2,param3,param4);
      label.color = 16742220;
      param2.transform.colorTransform = new ColorTransform(0,0,0,1,255,119,76);
      filters = [this.getBitmapFilter()];
    }

    private function getBitmapFilter() : BitmapFilter {
      var local1:Number = 0;
      var local2:Number = 45;
      var local3:Number = 1;
      var local4:Number = 1;
      var local5:Number = 1;
      var local6:Number = 1;
      var local7:Number = 0.65;
      var local8:Boolean = false;
      var local9:Boolean = false;
      var local10:Number = BitmapFilterQuality.HIGH;
      return new DropShadowFilter(local6,local2,local1,local3,local4,local5,local7,local10,local8,local9);
    }
  }
}
