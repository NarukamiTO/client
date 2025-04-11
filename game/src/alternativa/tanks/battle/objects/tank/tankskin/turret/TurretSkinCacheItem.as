package alternativa.tanks.battle.objects.tank.tankskin.turret {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.tankskin.*;
  import alternativa.tanks.utils.DataUnitValidator;
  import alternativa.tanks.utils.DataValidatorType;
  import alternativa.tanks.utils.Vector3Validator;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
  import projects.tanks.clients.flash.resources.tanks.Tank3D;

  public class TurretSkinCacheItem extends TankSkinPartCacheItem implements DataUnitValidator {
    private static const BOX_REGEXP:RegExp = /box.*/i;
    private static const PARENT_RELATIVE:RegExp = /(launcher_.?|barrel_.?)/i;

    public var flagMountPoint:Vector3;
    public var muzzles:Vector.<Vector3>;
    public var laserPoint:Vector3;

    private var muzzleValidators:Vector.<Vector3Validator>;
    private var collisionGeometry:Vector.<TurretGeometryItem>;

    public var meshes:Vector.<Mesh> = new Vector.<Mesh>();

    public function TurretSkinCacheItem(param1:Tanks3DSResource) {
      super(param1);
      this.initMeshes(param1);
      this.flagMountPoint = parseFlagMountPoint(param1);
      this.muzzles = this.parseMuzzles(param1);
      this.laserPoint = this.parseLaserPoint(param1);
      this.collisionGeometry = this.parseGeometry(param1);
      this.createMuzzleValidators();
    }

    private static function parseFlagMountPoint(param1:Tanks3DSResource) : Vector3 {
      var local3:Object3D = null;
      var local2:Vector.<Object3D> = param1.getObjectsByName(/fmnt.*/i);
      if(local2 != null) {
        local3 = local2[0];
        return new Vector3(local3.x,local3.y,local3.z);
      }
      throw new Error();
    }

    private function initMeshes(param1:Tanks3DSResource) : void {
      var local2:Object3D = null;
      for each(local2 in param1.objects) {
        if(local2 is Mesh && !Tank3D.EXCLUDED.test(local2.name)) {
          this.meshes.push(initMesh(Mesh(local2)));
        }
      }
    }

    private function parseGeometry(param1:Tanks3DSResource) : Vector.<TurretGeometryItem> {
      var local4:Object3D = null;
      var local5:Mesh = null;
      var local2:Vector.<Object3D> = param1.getObjectsByName(BOX_REGEXP);
      var local3:Vector.<TurretGeometryItem> = new Vector.<TurretGeometryItem>();
      if(local2 != null && local2.length != 0) {
        for each(local4 in local2) {
          local3.push(new TurretGeometryItem(local4));
        }
      } else {
        for each(local5 in this.meshes) {
          local3.push(new TurretGeometryItem(local5));
        }
      }
      return local3;
    }

    private function parseMuzzles(param1:Tanks3DSResource) : Vector.<Vector3> {
      var object:Object3D = null;
      var muzzle:Vector3 = null;
      var parent:Object3D = null;
      var resource:Tanks3DSResource = param1;
      var muzzles:Vector.<Vector3> = new Vector.<Vector3>();
      var objects:Vector.<Object3D> = resource.getObjectsByName(/muzzle.*/);
      if(objects != null) {
        objects.sort(function(param1:Object3D, param2:Object3D):Number {
          if(param1.name <= param2.name) {
            return -1;
          }
          return 1;
        });
        for each(object in objects) {
          muzzle = new Vector3(object.x,object.y,object.z);
          parent = resource.parents[resource.objects.indexOf(object)];
          if(parent != null && Boolean(parent.name.match(PARENT_RELATIVE))) {
            muzzle.x += parent.x;
            muzzle.y += parent.y;
            muzzle.z += parent.z;
          }
          muzzles.push(muzzle);
        }
        return muzzles;
      }
      throw new Error();
    }

    private function parseLaserPoint(param1:Tanks3DSResource) : Vector3 {
      var local3:Object3D = null;
      var local2:Vector.<Object3D> = param1.getObjectsByName(/laser/i);
      if(local2 != null) {
        local3 = local2[0];
        return new Vector3(local3.x,local3.y,local3.z);
      }
      return this.muzzles[0];
    }

    private function createMuzzleValidators() : void {
      this.muzzleValidators = new Vector.<Vector3Validator>(this.muzzles.length);
      var local1:int = 0;
      while(local1 < this.muzzles.length) {
        this.muzzleValidators[local1] = new Vector3Validator(this.muzzles[local1]);
        local1++;
      }
    }

    public function hasIncorrectData() : Boolean {
      var local1:Vector3Validator = null;
      for each(local1 in this.muzzleValidators) {
        if(!local1.isValid()) {
          return true;
        }
      }
      return false;
    }

    public function getType() : int {
      return DataValidatorType.MEMHACK_MUZZLE_POSITION;
    }

    public function getGeometry() : Vector.<TurretGeometryItem> {
      return this.collisionGeometry;
    }
  }
}
