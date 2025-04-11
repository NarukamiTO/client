package alternativa.tanks.battle.objects.tank.tankskin.terminator {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.*;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class TerminatorTurretSkin extends TurretSkin {
    public function TerminatorTurretSkin(param1:Tanks3DSResource) {
      super(param1);
      setPosition(rootObject,Vector3.ZERO);
    }

    public function getBarrel3DByIndex(param1:int) : Object3D {
      return turretMeshes[param1 == 0 ? 4 : 3];
    }

    public function getLeftBox3D() : Object3D {
      return turretMeshes[1];
    }

    public function getRightBox3D() : Object3D {
      return turretMeshes[2];
    }
  }
}
