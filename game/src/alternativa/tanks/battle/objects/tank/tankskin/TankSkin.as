package alternativa.tanks.battle.objects.tank.tankskin {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Shadow;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.tankskin.materialfactory.DefaultTankSkinMaterialsFactory;
  import alternativa.tanks.battle.objects.tank.tankskin.materialfactory.TankSkinMaterialsFactory;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.CustomTurretSkin;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretGeometryItem;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkin;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkinCacheItem;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.battle.scene3d.Object3DNames;
  import alternativa.tanks.models.tank.TankPartsRegistry;
  import alternativa.tanks.models.tank.hullcommon.HullCommon;
  import alternativa.tanks.services.colortransform.ColorTransformService;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.geom.ColorTransform;
  import flash.geom.Vector3D;
  import platform.client.fp10.core.resource.types.TextureResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.flash.commons.models.coloring.IColoring;
  import projects.tanks.clients.flash.resources.object3ds.IObject3DS;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class TankSkin {
    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var colorTransformService:ColorTransformService;

    [Inject]
    public static var battleService:BattleService;

    private static const BASE_COLOR_TRANSFORM:ColorTransform = new ColorTransform();
    private static const hullMatrix:Matrix4 = new Matrix4();
    private static const tankPartsRegistry:TankPartsRegistry = new TankPartsRegistry();

    public var targetColorTransformOffset:Number = 0;

    private var normalMaterials:SkinMaterials;
    private var deadMaterials:SkinMaterials;
    private var hullDescriptor:TankHullSkinCacheItem;
    private var hullMesh:Mesh;
    private var turretDescriptor:TurretSkinCacheItem;
    private var turretSkin:TurretSkin;
    private var colorTransform1:ColorTransform = new ColorTransform();
    private var targetColorTransform:ColorTransform = new ColorTransform();
    private var leftTrackSkin:TrackSkin;
    private var rightTrackSkin:TrackSkin;
    private var ambientShadow:Shadow;
    private var desiredColorTransform:ColorTransform = new ColorTransform();
    private var tankSkinMaterialFactory:TankSkinMaterialsFactory = new DefaultTankSkinMaterialsFactory();
    private var heatColorTransform:ColorTransform;
    private var frostColorTransform:ColorTransform;

    public function TankSkin(param1:IGameObject, param2:IGameObject, param3:IGameObject) {
      super();
      var local4:HullCommon = HullCommon(param1.adapt(HullCommon));
      var local5:TextureResource = local4.getDeadColoring();
      var local6:Tanks3DSResource = IObject3DS(param1.adapt(IObject3DS)).getResource3DS();
      this.hullDescriptor = tankPartsRegistry.getHullDescriptor(local6);
      var local7:Tanks3DSResource = IObject3DS(param2.adapt(IObject3DS)).getResource3DS();
      this.turretDescriptor = tankPartsRegistry.getTurretDescriptor(local7);
      this.hullMesh = this.cloneMesh(this.hullDescriptor.mesh);
      if(param2.hasModel(CustomTurretSkin)) {
        this.turretSkin = CustomTurretSkin(param2.adapt(CustomTurretSkin)).createSkin(local7);
      } else {
        this.turretSkin = new TurretSkin(local7);
      }
      this.turretSkin.setColorTransform(this.targetColorTransform);
      this.createTrackSkins(this.hullMesh);
      var local8:IColoring = IColoring(param3.adapt(IColoring));
      this.normalMaterials = this.tankSkinMaterialFactory.createSkinMaterials(this,local8);
      this.deadMaterials = this.tankSkinMaterialFactory.createDeadSkinMaterials(this,local5);
      this.heatColorTransform = colorTransformService.getHeatColorAdjust();
      this.frostColorTransform = colorTransformService.getFrostColorAdjust();
      this.createAmbientShadow();
    }

    private static function setIntermediateValue(param1:ColorTransform, param2:String, param3:ColorTransform, param4:ColorTransform, param5:Number) : void {
      var local6:Number = param4[param2] - param3[param2];
      param1[param2] = param3[param2] + Math.abs(param5) * local6;
    }

    private static function copyColorTransform(param1:ColorTransform, param2:ColorTransform) : void {
      param2.redMultiplier = param1.redMultiplier;
      param2.greenMultiplier = param1.greenMultiplier;
      param2.blueMultiplier = param1.blueMultiplier;
      param2.alphaMultiplier = param1.alphaMultiplier;
      param2.redOffset = param1.redOffset;
      param2.greenOffset = param1.greenOffset;
      param2.blueOffset = param1.blueOffset;
      param2.alphaOffset = param1.alphaOffset;
    }

    private function createAmbientShadow() : void {
      this.ambientShadow = new Shadow(128,8,100,1,1,1118498,0.6);
      this.ambientShadow.direction = new Vector3D(0,0,-1);
      this.ambientShadow.offset = 90;
      this.ambientShadow.backFadeRange = 90;
      this.ambientShadow.addCaster(this.hullMesh);
      this.turretSkin.initShadow(this.ambientShadow);
    }

    public function setAlpha(param1:Number) : void {
      this.hullMesh.alpha = param1;
      this.turretSkin.alpha = param1;
      this.ambientShadow.alpha = param1 * 0.6;
    }

    public function getHullAlpha() : Number {
      return this.hullMesh.alpha;
    }

    public function dispose() : void {
      this.hullMesh.setMaterialToAllFaces(null);
      this.turretSkin.destroy();
      this.setTracksMaterial(null,null);
      this.releaseMaterials(this.normalMaterials);
      this.releaseMaterials(this.deadMaterials);
      this.normalMaterials = null;
      this.deadMaterials = null;
      this.hullMesh = null;
      this.turretSkin = null;
      this.leftTrackSkin = null;
      this.rightTrackSkin = null;
    }

    private function releaseMaterials(param1:SkinMaterials) : void {
      textureMaterialRegistry.releaseMaterial(param1.hullMaterial);
      textureMaterialRegistry.releaseMaterial(param1.turretMaterial);
      textureMaterialRegistry.releaseMaterial(param1.leftTrackMaterial);
      textureMaterialRegistry.releaseMaterial(param1.rightTrackMaterial);
    }

    public function setNormalState() : void {
      this.hullMesh.setMaterialToAllFaces(this.normalMaterials.hullMaterial);
      this.turretSkin.setMaterials(this.normalMaterials.turretMaterial);
      this.setTracksMaterial(this.normalMaterials.leftTrackMaterial,this.normalMaterials.rightTrackMaterial);
    }

    public function setDeadState() : void {
      this.hullMesh.setMaterialToAllFaces(this.deadMaterials.hullMaterial);
      this.turretSkin.setMaterials(this.deadMaterials.turretMaterial);
      this.setTracksMaterial(this.deadMaterials.hullMaterial,this.deadMaterials.hullMaterial);
      this.resetColorTransform();
    }

    private function setTracksMaterial(param1:Material, param2:Material) : void {
      this.leftTrackSkin.setMaterial(param1);
      this.rightTrackSkin.setMaterial(param2);
    }

    public function resetColorTransform() : void {
      this.targetColorTransformOffset = 0;
      this.colorTransform1.redMultiplier = 1;
      this.colorTransform1.greenMultiplier = 1;
      this.colorTransform1.blueMultiplier = 1;
      this.colorTransform1.redOffset = 0;
      this.colorTransform1.greenOffset = 0;
      this.colorTransform1.blueOffset = 0;
      copyColorTransform(this.colorTransform1,this.targetColorTransform);
    }

    public function setColorTransformByTemperature(param1:Number) : void {
      var local2:ColorTransform = null;
      if(param1 == 0) {
        local2 = BASE_COLOR_TRANSFORM;
      } else if(param1 < 0) {
        local2 = this.frostColorTransform;
      } else {
        local2 = this.heatColorTransform;
      }
      setIntermediateValue(this.desiredColorTransform,"redMultiplier",BASE_COLOR_TRANSFORM,local2,param1);
      setIntermediateValue(this.desiredColorTransform,"blueMultiplier",BASE_COLOR_TRANSFORM,local2,param1);
      setIntermediateValue(this.desiredColorTransform,"greenMultiplier",BASE_COLOR_TRANSFORM,local2,param1);
      setIntermediateValue(this.desiredColorTransform,"redOffset",BASE_COLOR_TRANSFORM,local2,param1);
      setIntermediateValue(this.desiredColorTransform,"blueOffset",BASE_COLOR_TRANSFORM,local2,param1);
      setIntermediateValue(this.desiredColorTransform,"greenOffset",BASE_COLOR_TRANSFORM,local2,param1);
      setIntermediateValue(this.targetColorTransform,"redMultiplier",this.targetColorTransform,this.desiredColorTransform,0.03);
      setIntermediateValue(this.targetColorTransform,"blueMultiplier",this.targetColorTransform,this.desiredColorTransform,0.03);
      setIntermediateValue(this.targetColorTransform,"greenMultiplier",this.targetColorTransform,this.desiredColorTransform,0.03);
      setIntermediateValue(this.targetColorTransform,"redOffset",this.targetColorTransform,this.desiredColorTransform,0.03);
      setIntermediateValue(this.targetColorTransform,"blueOffset",this.targetColorTransform,this.desiredColorTransform,0.03);
      setIntermediateValue(this.targetColorTransform,"greenOffset",this.targetColorTransform,this.desiredColorTransform,0.03);
    }

    public function addToScene() : void {
      var local1:BattleScene3D = battleService.getBattleScene3D();
      local1.addObject(this.hullMesh);
      local1.addTurret(this.turretSkin);
      local1.addAmbientShadow(this.ambientShadow);
    }

    public function removeFromScene() : void {
      var local1:BattleScene3D = battleService.getBattleScene3D();
      local1.removeObject(this.hullMesh);
      local1.removeTurret(this.turretSkin);
      local1.removeAmbientShadow(this.ambientShadow);
    }

    public function getHullMesh() : Mesh {
      return this.hullMesh;
    }

    public function getTurret3D() : Object3D {
      return this.turretSkin.getTurret3D();
    }

    public function getBarrel3D() : Object3D {
      return this.turretSkin.getBarrel3D();
    }

    public function getTurretSkin() : TurretSkin {
      return this.turretSkin;
    }

    public function getHullDescriptor() : TankHullSkinCacheItem {
      return this.hullDescriptor;
    }

    public function getTurretDescriptor() : TurretSkinCacheItem {
      return this.turretDescriptor;
    }

    public function getTurretGeometry() : Vector.<TurretGeometryItem> {
      return this.turretDescriptor.getGeometry();
    }

    public function updateHullTransform(param1:Vector3, param2:Vector3) : void {
      if(this.hullDescriptor != null) {
        this.hullMesh.x = param1.x;
        this.hullMesh.y = param1.y;
        this.hullMesh.z = param1.z;
        this.hullMesh.rotationX = param2.x;
        this.hullMesh.rotationY = param2.y;
        this.hullMesh.rotationZ = param2.z;
      }
    }

    public function updateTurretTransform(param1:Number, param2:Number) : void {
      if(this.hullDescriptor != null && this.turretDescriptor != null) {
        hullMatrix.setMatrix(this.hullMesh.x,this.hullMesh.y,this.hullMesh.z,this.hullMesh.rotationX,this.hullMesh.rotationY,this.hullMesh.rotationZ);
        this.turretSkin.updateTurretTransform(hullMatrix,this.hullDescriptor,param1,param2);
      }
    }

    public function updateTracks(param1:Number, param2:Number) : void {
      this.leftTrackSkin.move(param1);
      this.rightTrackSkin.move(param2);
    }

    private function createTrackSkins(param1:Mesh) : void {
      var local2:Face = null;
      this.leftTrackSkin = new TrackSkin();
      this.rightTrackSkin = new TrackSkin();
      for each(local2 in param1.faces) {
        if(local2.material.name == "tracks") {
          this.addFaceToTrackSkin(local2);
        }
      }
      this.leftTrackSkin.init();
      this.rightTrackSkin.init();
    }

    private function addFaceToTrackSkin(param1:Face) : void {
      var local2:Vertex = param1.vertices[0];
      if(local2.x < 0) {
        this.leftTrackSkin.addFace(param1);
      } else {
        this.rightTrackSkin.addFace(param1);
      }
    }

    private function cloneMesh(param1:Mesh) : Mesh {
      var local2:Mesh = Mesh(param1.clone());
      local2.name = Object3DNames.TANK_PART;
      local2.colorTransform = this.targetColorTransform;
      local2.shadowMapAlphaThreshold = 0.1;
      local2.calculateVerticesNormalsBySmoothingGroups(0.01);
      return local2;
    }

    public function readGlobalFlagMountPoint(param1:Vector3, param2:Vector3) : void {
      var local4:Object3D = null;
      var local3:Matrix4 = TurretSkin.turretMatrix;
      local4 = this.turretSkin.getTurret3D();
      local3.setMatrix(local4.x,local4.y,local4.z,local4.rotationX,local4.rotationY,local4.rotationZ);
      local3.transformVector(this.turretDescriptor.flagMountPoint,param1);
      param2.x = local4.rotationX;
      param2.y = local4.rotationY;
      param2.z = local4.rotationZ;
    }
  }
}
