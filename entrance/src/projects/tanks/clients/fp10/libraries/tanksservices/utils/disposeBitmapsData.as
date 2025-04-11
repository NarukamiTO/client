package projects.tanks.clients.fp10.libraries.tanksservices.utils {
  import flash.display.BitmapData;

  public function disposeBitmapsData(param1:Array) : void {
    var local2:BitmapData = null;
    var local3:int = 0;
    var local4:int = 0;
    if(param1 != null) {
      local3 = int(param1.length);
      local4 = 0;
      while(local4 < local3) {
        local2 = param1[local4];
        local2.dispose();
        local4++;
      }
      param1 = null;
    }
  }
}
