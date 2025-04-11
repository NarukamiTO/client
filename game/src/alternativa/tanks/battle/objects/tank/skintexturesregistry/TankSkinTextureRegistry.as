package alternativa.tanks.battle.objects.tank.skintexturesregistry {
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkinPartCacheItem;
  import flash.display.BitmapData;

  public interface TankSkinTextureRegistry {
    function getTexture(param1:TankSkinPartCacheItem, param2:BitmapData) : BitmapData;
    function releaseTexture(param1:TankSkinPartCacheItem, param2:BitmapData) : void;
    function clear() : void;
  }
}
