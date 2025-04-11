package alternativa.tanks.models.battle.battlefield.map {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.proplib.objects.PropSprite;
  import alternativa.utils.textureutils.TextureByteData;
  import flash.display.BitmapData;

  public class TexturedSpritesCollection implements TexturedPropsCollection {
    private var propSprite:PropSprite;
    private var sprites:Vector.<Sprite3D> = new Vector.<Sprite3D>();

    public function TexturedSpritesCollection(param1:PropSprite, param2:String) {
      super();
      this.propSprite = param1;
    }

    public function addSprite3D(param1:Sprite3D) : void {
      this.sprites.push(param1);
    }

    public function setMaterial(param1:TextureMaterial) : void {
      var local3:Sprite3D = null;
      var local4:Number = NaN;
      var local2:BitmapData = param1.texture;
      for each(local3 in this.sprites) {
        local3.material = param1;
        local4 = Number(local3.width);
        local3.width = local4 * local2.width;
        local3.height = local4 * local2.height;
      }
    }

    public function getTextureData() : TextureByteData {
      return this.propSprite.textureData;
    }
  }
}
