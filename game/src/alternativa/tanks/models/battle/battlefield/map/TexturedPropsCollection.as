package alternativa.tanks.models.battle.battlefield.map {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.utils.textureutils.TextureByteData;

  public interface TexturedPropsCollection {
    function getTextureData() : TextureByteData;
    function setMaterial(param1:TextureMaterial) : void;
  }
}
