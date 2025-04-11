package alternativa.tanks.battle.objects.tank.tankskin.turret {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.tankskin.TankHullSkinCacheItem;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class ArtilleryTurretSkin extends TurretSkin {
    [Inject]
    public static var battleService:BattleService;

    public function ArtilleryTurretSkin(param1:Tanks3DSResource) {
      super(param1);
      setPosition(rootObject,Vector3.ZERO);
    }

    override public function updateTurretTransform(param1:Matrix4, param2:TankHullSkinCacheItem, param3:Number, param4:Number) : void {
      super.updateTurretTransform(param1,param2,param3,param4);
      this.getBarrel3D().rotationX = param4;
    }

    override public function getBarrel3D() : Object3D {
      return turretMeshes[1].parent;
    }

    public function getCannon3D() : Object3D {
      return turretMeshes[2];
    }
  }
}
