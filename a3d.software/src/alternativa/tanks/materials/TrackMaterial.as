package alternativa.tanks.materials {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.materials.UVMatrixProvider;
  import flash.display.BitmapData;

  public class TrackMaterial extends TextureMaterial {
    public var uvMatrixProvider:UVMatrixProvider = new UVMatrixProvider();

    public function TrackMaterial(param1:BitmapData) {
      super(param1,true);
    }

    public function update() : void {
    }
  }
}
