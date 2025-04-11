package alternativa.tanks.model.item.container.gui.opening {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.PixelSnapping;
  import flash.geom.ColorTransform;
  import projects.tanks.client.garage.models.item.container.ContainerItemCategory;

  public class Present {
    public var bitmap:Bitmap = new Bitmap();
    public var color:ColorTransform = new ColorTransform();
    public var delay:Number;
    public var name:String;

    public function Present(param1:BitmapData, param2:String, param3:ContainerItemCategory) {
      super();
      this.bitmap.bitmapData = param1;
      this.bitmap.pixelSnapping = PixelSnapping.NEVER;
      this.bitmap.smoothing = true;
      this.name = param2;
      var local4:Array = paramsByCategory(param3);
      this.color.redMultiplier = local4[0];
      this.color.greenMultiplier = local4[1];
      this.color.blueMultiplier = local4[2];
      this.delay = local4[3];
    }

    private static function paramsByCategory(param1:ContainerItemCategory) : Array {
      if(param1 == ContainerItemCategory.COMMON) {
        return [0.5,0.5,0.5,0];
      }
      if(param1 == ContainerItemCategory.UNCOMMON) {
        return [0.3,1,0.3,0];
      }
      if(param1 == ContainerItemCategory.RARE) {
        return [0,0.8,2,0.5];
      }
      if(param1 == ContainerItemCategory.EPIC) {
        return [1,0.3,1.5,2];
      }
      if(param1 == ContainerItemCategory.LEGENDARY) {
        return [2,0.7,0.5,3];
      }
      if(param1 == ContainerItemCategory.EXOTIC) {
        return [2,0.1,0,4];
      }
      return [0,0,0,0.1];
    }
  }
}
