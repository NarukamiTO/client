package alternativa.tanks.battle.objects.tank.skintexturesregistry {
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkinPartCacheItem;
  import flash.display.BitmapData;
  import flash.utils.Dictionary;

  public class DefaultTankSkinTextureRegistry implements TankSkinTextureRegistry {
    private var textures:Dictionary = new Dictionary();

    public function DefaultTankSkinTextureRegistry() {
      super();
    }

    public function clear() : void {
      var local2:Dictionary = null;
      var local3:TextureEntry = null;
      var local1:int = 0;
      for each(local2 in this.textures) {
        for each(local3 in local2) {
          local3.texture.dispose();
          local1++;
        }
      }
      this.textures = new Dictionary();
    }

    public function getTexture(param1:TankSkinPartCacheItem, param2:BitmapData) : BitmapData {
      var local3:Dictionary = this.getPartTextures(param1);
      var local4:TextureEntry = this.getTextureEntry(param1,param2,local3);
      ++local4.referenceCount;
      return local4.texture;
    }

    private function getPartTextures(param1:TankSkinPartCacheItem) : Dictionary {
      var local2:Dictionary = this.textures[param1.partId];
      if(local2 == null) {
        local2 = new Dictionary();
        this.textures[param1.partId] = local2;
      }
      return local2;
    }

    private function getTextureEntry(param1:TankSkinPartCacheItem, param2:BitmapData, param3:Dictionary) : TextureEntry {
      var local4:TextureEntry = param3[param2];
      if(local4 == null) {
        local4 = new TextureEntry(param1.createTexture(param2));
        param3[param2] = local4;
      }
      return local4;
    }

    public function releaseTexture(param1:TankSkinPartCacheItem, param2:BitmapData) : void {
      var local3:Dictionary = this.textures[param1.partId];
      if(local3 == null) {
        return;
      }
      var local4:TextureEntry = local3[param2];
      if(local4 == null) {
        return;
      }
      --local4.referenceCount;
      if(local4.referenceCount == 0) {
        local4.texture.dispose();
        delete local3[param2];
      }
    }
  }
}
