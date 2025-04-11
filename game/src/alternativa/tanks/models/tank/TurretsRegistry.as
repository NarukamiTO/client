package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkinCacheItem;
  import flash.utils.Dictionary;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  internal class TurretsRegistry {
    private var turrets:Dictionary = new Dictionary();

    public function TurretsRegistry() {
      super();
    }

    public function getTurret(param1:Tanks3DSResource) : TurretSkinCacheItem {
      var local2:TurretSkinCacheItem = this.turrets[param1.id];
      if(local2 == null) {
        local2 = new TurretSkinCacheItem(param1);
        this.turrets[param1.id] = local2;
      }
      return local2;
    }
  }
}
