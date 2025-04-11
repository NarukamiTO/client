package alternativa.tanks.engine3d {
  import alternativa.engine3d.materials.TextureMaterial;
  import flash.display.BitmapData;

  public class MaterialEntry {
    public var keyData:Object;
    public var texture:BitmapData;
    public var material:TextureMaterial;
    public var referenceCount:int;

    public function MaterialEntry(param1:Object, param2:TextureMaterial) {
      super();
      this.keyData = param1;
      this.texture = param1 as BitmapData;
      this.material = param2;
    }
  }
}
