package alternativa.tanks.models.weapon {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;

  public class WeaponUtils {
    private static const turretMatrix:Matrix4 = new Matrix4();
    private static const localBarrelOrigin:Vector3 = new Vector3();

    public function WeaponUtils() {
      super();
    }

    public static function calculateMainGunParams(param1:Object3D, param2:Vector3, param3:AllGlobalGunParams) : void {
      turretMatrix.setFromMatrix3D(param1.concatenatedMatrix);
      turretMatrix.transformVector(param2,param3.muzzlePosition);
      localBarrelOrigin.x = param2.x;
      localBarrelOrigin.z = param2.z;
      turretMatrix.transformVector(localBarrelOrigin,param3.barrelOrigin);
      param3.elevationAxis.x = turretMatrix.m00;
      param3.elevationAxis.y = turretMatrix.m10;
      param3.elevationAxis.z = turretMatrix.m20;
      param3.direction.x = turretMatrix.m01;
      param3.direction.y = turretMatrix.m11;
      param3.direction.z = turretMatrix.m21;
    }

    public static function calculateBasicGunParams(param1:Object3D, param2:Vector3, param3:BasicGlobalGunParams) : void {
      turretMatrix.setMatrix(param1.x,param1.y,param1.z,param1.rotationX,param1.rotationY,param1.rotationZ);
      turretMatrix.transformVector(param2,param3.muzzlePosition);
      param3.direction.x = turretMatrix.m01;
      param3.direction.y = turretMatrix.m11;
      param3.direction.z = turretMatrix.m21;
    }
  }
}
