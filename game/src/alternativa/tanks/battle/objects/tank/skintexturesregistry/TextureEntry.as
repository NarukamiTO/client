package alternativa.tanks.battle.objects.tank.skintexturesregistry {
  import flash.display.BitmapData;

  internal class TextureEntry {
    public var referenceCount:int;
    public var texture:BitmapData;

    public function TextureEntry(param1:BitmapData) {
      super();
      this.texture = param1;
    }
  }
}
