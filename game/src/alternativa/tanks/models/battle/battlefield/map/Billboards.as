package alternativa.tanks.models.battle.battlefield.map {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BitmapData;

  public class Billboards {
    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    private static const BILLBOARD_MATERIAL_NAME:String = "display";

    private var billboards:Vector.<Mesh> = new Vector.<Mesh>();
    private var faces:Vector.<Face> = new Vector.<Face>();
    private var material:TextureMaterial;
    private var billboardImage:BitmapData;

    public function Billboards() {
      super();
    }

    public function add(param1:Mesh) : void {
      var local2:Face = null;
      this.billboards.push(param1);
      for each(local2 in param1.faces) {
        if(local2.material.name == BILLBOARD_MATERIAL_NAME) {
          this.faces.push(local2);
          if(this.material == null) {
            this.material = TextureMaterial(local2.material);
            this.updateMaterial();
          }
        }
      }
    }

    public function setImage(param1:BitmapData) : void {
      this.billboardImage = param1;
      this.updateMaterial();
    }

    private function updateMaterial() : void {
      if(this.material != null && this.billboardImage != null) {
        this.material.texture = this.billboardImage;
        this.setMaterialResolution();
      }
    }

    private function setMaterialResolution() : void {
      if(this.billboards.length > 0) {
        this.material.resolution = 1;
      }
    }
  }
}
