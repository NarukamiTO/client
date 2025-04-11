package alternativa.proplib.objects {
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.utils.textureutils.TextureByteData;

  public class PropSprite extends PropObject {
    public var textureData:TextureByteData;
    public var scale:Number;

    public function PropSprite(textureData:TextureByteData, originX:Number = 0.5, originY:Number = 0.5, scale:Number = 1) {
      super(PropObjectType.SPRITE);
      this.textureData = textureData;
      this.scale = scale;
      var sprite:Sprite3D = new Sprite3D(1,1);
      sprite.originX = originX;
      sprite.originY = originY;
      object = sprite;
    }

    override public function traceProp() : void {
      super.traceProp();
      trace("\ttextureData",this.textureData.diffuseData.bytesAvailable,this.textureData.opacityData);
    }
  }
}
