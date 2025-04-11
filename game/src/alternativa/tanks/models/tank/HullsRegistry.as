package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.tankskin.TankHullSkinCacheItem;
  import flash.utils.Dictionary;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  internal class HullsRegistry {
    private var hulls:Dictionary = new Dictionary();

    public function HullsRegistry() {
      super();
    }

    public function getHull(param1:Tanks3DSResource) : TankHullSkinCacheItem {
      var local2:TankHullSkinCacheItem = this.hulls[param1.id];
      if(local2 == null) {
        local2 = new TankHullSkinCacheItem(param1);
        this.hulls[param1.id] = local2;
      }
      return local2;
    }
  }
}
