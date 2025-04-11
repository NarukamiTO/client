package platform.client.fp10.core.resource.types {
  import flash.display.BitmapData;

  public class StubBitmapData extends BitmapData {
    public function StubBitmapData(param1:uint, param2:uint = 20, param3:uint = 20) {
      var local5:int = 0;
      super(param2,param3,false,0);
      var local4:int = 0;
      while(local4 < param2) {
        local5 = 0;
        while(local5 < param3) {
          setPixel(Boolean(local4 % 2) ? local5 : local5 + 1,local4,param1);
          local5 += 2;
        }
        local4++;
      }
    }
  }
}
