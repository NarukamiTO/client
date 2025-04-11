package alternativa.tanks.models.battle.battlefield.map {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.BSP;
  import alternativa.proplib.objects.PropMesh;
  import alternativa.utils.textureutils.TextureByteData;

  public class TexturedBSPsCollection implements TexturedPropsCollection {
    private var propMesh:PropMesh;
    private var textureName:String;
    private var bsps:Vector.<BSP> = new Vector.<BSP>();

    public function TexturedBSPsCollection(param1:PropMesh, param2:String) {
      super();
      this.propMesh = param1;
      this.textureName = param2;
    }

    public function addBsp(param1:BSP) : void {
      this.bsps.push(param1);
    }

    public function setMaterial(param1:TextureMaterial) : void {
      var local2:BSP = null;
      for each(local2 in this.bsps) {
        local2.setMaterialToAllFaces(param1);
      }
    }

    public function getTextureData() : TextureByteData {
      return this.propMesh.textures.getValue(this.textureName);
    }
  }
}
