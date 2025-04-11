package alternativa.tanks.battle.objects.tank.tankskin.turret {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.core.Shadow;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.tankskin.TankHullSkinCacheItem;
  import alternativa.tanks.battle.scene3d.Object3DNames;
  import flash.geom.ColorTransform;
  import flash.utils.Dictionary;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;
  import projects.tanks.clients.flash.resources.tanks.Tank3D;

  public class TurretSkin {
    [Inject]
    public static var battleService:BattleService;

    public static const turretMatrix:Matrix4 = new Matrix4();

    protected var turretMeshes:Vector.<Mesh>;
    protected var rootObject:Object3D;

    public function TurretSkin(param1:Tanks3DSResource) {
      var local2:Object3D = null;
      var local3:Dictionary = null;
      var local4:int = 0;
      var local5:Mesh = null;
      var local6:Mesh = null;
      var local7:Object3DContainer = null;
      var local8:Object3D = null;
      var local9:Object3DContainer = null;
      this.turretMeshes = new Vector.<Mesh>();
      super();
      for each(local2 in param1.objects) {
        if(local2 is Mesh && !Tank3D.EXCLUDED.test(local2.name)) {
          this.turretMeshes.push(local2);
        }
      }
      local3 = new Dictionary();
      local4 = this.turretMeshes.length - 1;
      while(local4 >= 0) {
        local5 = this.turretMeshes[local4];
        local6 = Tank3D.cloneMesh(local5);
        local6.mouseEnabled = false;
        local7 = local3[local5];
        if(local7 != null) {
          copyPosition(local7,local6);
          local7.addChild(local6);
          setPosition(local6,Vector3.ZERO);
        }
        local8 = param1.parents[param1.objects.indexOf(local5)];
        if(local8 != null) {
          if(local8 in local3) {
            local9 = local3[local8];
          } else {
            local9 = new Object3DContainer();
            local3[local8] = local9;
          }
          local9.addChild(local3[local5] != null ? local3[local5] : local6);
          local9.mouseEnabled = false;
        }
        this.turretMeshes[this.turretMeshes.indexOf(local5)] = local6;
        local4--;
      }
      this.rootObject = this.turretMeshes[0].parent != null ? this.turretMeshes[0].parent : this.turretMeshes[0];
      this.rootObject.name = Object3DNames.TANK_PART;
      this.rootObject.mouseEnabled = true;
    }

    protected static function copyPosition(param1:Object3D, param2:Object3D) : void {
      param1.x = param2.x;
      param1.y = param2.y;
      param1.z = param2.z;
    }

    protected static function setPosition(param1:Object3D, param2:Vector3) : void {
      param1.x = param2.x;
      param1.y = param2.y;
      param1.z = param2.z;
    }

    public function initShadow(param1:Shadow) : void {
      var local2:Mesh = null;
      for each(local2 in this.turretMeshes) {
        param1.addCaster(local2);
      }
    }

    public function set alpha(param1:Number) : void {
      var local2:Mesh = null;
      for each(local2 in this.turretMeshes) {
        local2.alpha = param1;
      }
    }

    public function destroy() : void {
      var local1:Mesh = null;
      for each(local1 in this.turretMeshes) {
        local1.setMaterialToAllFaces(null);
      }
      this.turretMeshes = null;
    }

    public function setMaterials(param1:TextureMaterial) : void {
      var local2:Mesh = null;
      for each(local2 in this.turretMeshes) {
        local2.setMaterialToAllFaces(param1);
      }
    }

    public function addToScene() : void {
      battleService.getBattleScene3D().addObject(this.rootObject);
    }

    public function removeFromScene() : void {
      battleService.getBattleScene3D().removeObject(this.rootObject);
    }

    public function updateTurretTransform(param1:Matrix4, param2:TankHullSkinCacheItem, param3:Number, param4:Number) : void {
      turretMatrix.setMatrix(param2.getTurretMountPointX(),param2.getTurretMountPointY(),param2.getTurretMountPointZ() + 1,0,0,param3);
      turretMatrix.append(param1);
      this.rootObject.x = turretMatrix.m03;
      this.rootObject.y = turretMatrix.m13;
      this.rootObject.z = turretMatrix.m23;
      var local5:Vector3 = BattleUtils.tmpVector;
      turretMatrix.getEulerAngles(local5);
      this.rootObject.rotationX = local5.x;
      this.rootObject.rotationY = local5.y;
      this.rootObject.rotationZ = local5.z;
    }

    public function getTurret3D() : Object3D {
      return this.rootObject;
    }

    public function getBarrel3D() : Object3D {
      return this.rootObject;
    }

    public function getMeshes() : Vector.<Mesh> {
      return this.turretMeshes;
    }

    public function setColorTransform(param1:ColorTransform) : void {
      var local2:Mesh = null;
      for each(local2 in this.getMeshes()) {
        local2.colorTransform = param1;
      }
    }
  }
}
