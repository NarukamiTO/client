package alternativa.tanks.models.weapon.gauss {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkin;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class GaussTurretSkin extends TurretSkin {
    private const ANTENNA_MESH_INDEX:int = 1;

    public function GaussTurretSkin(param1:Tanks3DSResource) {
      super(param1);
      setPosition(rootObject,Vector3.ZERO);
    }

    public function getAntenna() : Object3D {
      return turretMeshes[this.ANTENNA_MESH_INDEX];
    }
  }
}
