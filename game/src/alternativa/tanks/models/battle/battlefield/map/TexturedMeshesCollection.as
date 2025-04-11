package alternativa.tanks.models.battle.battlefield.map {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.proplib.objects.PropMesh;
  import alternativa.utils.textureutils.TextureByteData;

  public class TexturedMeshesCollection implements TexturedPropsCollection {
    private var meshes:Vector.<Mesh> = new Vector.<Mesh>();
    private var propMesh:PropMesh;
    private var textureName:String;
    private var excludedMaterialName:String;

    public function TexturedMeshesCollection(param1:PropMesh, param2:String) {
      super();
      this.propMesh = param1;
      this.textureName = param2;
    }

    public function add(param1:Mesh, param2:String = null) : void {
      this.excludedMaterialName = param2;
      this.meshes.push(param1);
    }

    public function getTextureData() : TextureByteData {
      return this.propMesh.textures.getValue(this.textureName);
    }

    public function setMaterial(param1:TextureMaterial) : void {
      var local2:Mesh = null;
      var local3:Face = null;
      for each(local2 in this.meshes) {
        for each(local3 in local2.faces) {
          if(Boolean(this.excludedMaterialName) && local3.material.name != this.excludedMaterialName) {
            local3.material = param1;
          }
        }
        local2.removeVertex(local2.addVertex(0,0,0));
      }
    }
  }
}
