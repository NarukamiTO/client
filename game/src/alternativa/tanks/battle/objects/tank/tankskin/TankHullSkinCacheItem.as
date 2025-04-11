package alternativa.tanks.battle.objects.tank.tankskin {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.*;
  import alternativa.tanks.utils.DataUnitValidator;
  import alternativa.tanks.utils.DataValidatorType;
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class TankHullSkinCacheItem extends TankSkinPartCacheItem implements DataUnitValidator {
    public var turretMountPoint:Vector3;

    private var encTurretMountPointX:EncryptedNumber;
    private var encTurretMountPointY:EncryptedNumber;
    private var encTurretMountPointZ:EncryptedNumber;

    public var mesh:Mesh;

    public function TankHullSkinCacheItem(param1:Tanks3DSResource) {
      super(param1);
      var local2:Vector.<Object3D> = param1.getObjectsByName(/mount/i);
      if(local2 == null) {
        throw new TurretMountPointNotFoundError();
      }
      var local3:Object3D = local2[0];
      this.turretMountPoint = new Vector3(local3.x,local3.y,local3.z);
      this.encTurretMountPointX = new EncryptedNumberImpl(local3.x);
      this.encTurretMountPointY = new EncryptedNumberImpl(local3.y);
      this.encTurretMountPointZ = new EncryptedNumberImpl(local3.z);
      this.mesh = initMesh(this.getMesh(param1));
    }

    public function hasIncorrectData() : Boolean {
      return this.turretMountPoint.x != this.encTurretMountPointX.getNumber() || this.turretMountPoint.y != this.encTurretMountPointY.getNumber() || this.turretMountPoint.z != this.encTurretMountPointZ.getNumber();
    }

    public function getType() : int {
      return DataValidatorType.MEMHACK_TURRET_MOUNT_POINT;
    }

    private function getMesh(param1:Tanks3DSResource) : Mesh {
      var local2:Vector.<Object3D> = param1.getObjectsByName(/hull/i);
      if(local2 == null) {
        throw new HullNotFoundError();
      }
      return Mesh(local2[0]);
    }

    public function getTurretMountPointX() : Number {
      return this.encTurretMountPointX.getNumber();
    }

    public function getTurretMountPointY() : Number {
      return this.encTurretMountPointY.getNumber();
    }

    public function getTurretMountPointZ() : Number {
      return this.encTurretMountPointZ.getNumber();
    }
  }
}
