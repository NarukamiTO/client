package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.tankskin.TankHullSkinCacheItem;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkinCacheItem;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class TankPartsRegistry {
    private var hullsRegistry:HullsRegistry = new HullsRegistry();
    private var turretsRegistry:TurretsRegistry = new TurretsRegistry();

    public function TankPartsRegistry() {
      super();
    }

    public function getHullDescriptor(param1:Tanks3DSResource) : TankHullSkinCacheItem {
      return this.hullsRegistry.getHull(param1);
    }

    public function getTurretDescriptor(param1:Tanks3DSResource) : TurretSkinCacheItem {
      return this.turretsRegistry.getTurret(param1);
    }
  }
}
