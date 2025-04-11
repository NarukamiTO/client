package alternativa.tanks.models.weapon.gauss.sfx {
  import alternativa.engine3d.objects.Mesh;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.utils.GraphicsUtils;
  import flash.media.Sound;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battlefield.models.tankparts.weapon.gauss.sfx.GaussSFXCC;
  import projects.tanks.client.battlefield.models.tankparts.weapon.gauss.sfx.GaussSFXModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.gauss.sfx.IGaussSFXModelBase;

  [ModelInfo]
  public class GaussSFXModel extends GaussSFXModelBase implements IGaussSFXModelBase, ObjectLoadPostListener, ObjectUnloadListener, IGaussSFXModel {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    public function GaussSFXModel() {
      super();
    }

    private static function releaseMaterials(param1:GaussSFXData) : void {
      materialRegistry.releaseMaterial(param1.electroTextureMaterial);
      materialRegistry.releaseMaterial(param1.explosionElectroTextureAnimation.material);
      materialRegistry.releaseMaterial(param1.explosionTextureAnimation.material);
      materialRegistry.releaseMaterial(param1.fireTextureMaterial);
      materialRegistry.releaseMaterial(param1.flameTextureMaterial);
      materialRegistry.releaseMaterial(param1.lightningTextureMaterial);
      materialRegistry.releaseMaterial(param1.tracerTextureMaterial);
      materialRegistry.releaseMaterial(param1.trailTextureMaterial);
      materialRegistry.releaseMaterial(param1.smokeTextureMaterial);
      materialRegistry.releaseMaterial(param1.primaryHitMarkerMaterial);
    }

    public function objectLoadedPost() : void {
      var local1:GaussSFXCC = getInitParam();
      var local2:GaussSFXData = new GaussSFXData();
      local2.electroTextureMaterial = materialRegistry.getMaterial(local1.electroTexture.data);
      local2.explosionElectroTextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,local1.explosionElectroTexture);
      local2.explosionTextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,local1.explosionTexture);
      local2.fireTextureMaterial = materialRegistry.getMaterial(local1.fireTexture.data);
      local2.flameTextureMaterial = materialRegistry.getMaterial(local1.flameTexture.data);
      local2.lightningTextureMaterial = materialRegistry.getMaterial(local1.lightningTexture.data);
      local2.lightningTextureMaterial.repeat = true;
      local2.tracerTextureMaterial = materialRegistry.getMaterial(local1.tracerTexture.data);
      local2.trailTextureMaterial = materialRegistry.getMaterial(local1.trailTexture.data);
      local2.smokeTextureMaterial = materialRegistry.getMaterial(local1.smokeTexture.data);
      local2.primaryHitMarkerMaterial = materialRegistry.getMaterial(local1.hitMarkerTexture.data);
      local2.shellMesh = this.createShell(local1);
      var local3:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
      local2.primaryShotLightAnimation = local3.createAnimation("shot");
      local2.primaryExplosionLightAnimation = local3.createAnimation("hit");
      local2.primaryShellLightAnimation = local3.createAnimation("shell");
      local2.secondaryShotLightAnimation = local3.createAnimation("powershot");
      local2.secondaryExplosionLightAnimation = local3.createAnimation("powerhit");
      local2.secondaryLightningLightAnimation = local3.createAnimation("lightning");
      local2.primaryHitSound = local1.primaryHitSound.sound;
      local2.primaryShotSound = local1.primaryShotSound.sound;
      local2.secondaryHitSound = local1.secondaryHitSound.sound;
      local2.secondaryShotSound = local1.secondaryShotSound.sound;
      local2.antennaUpSound = local1.antennaUpSound.sound;
      local2.antennaDownSound = local1.antennaDownSound.sound;
      local2.startAimingSound = local1.startAimingSound.sound;
      local2.targetLockSound = local1.targetLockSound.sound;
      local2.targetLostSound = local1.targetLostSound.sound;
      local2.shellFlightSound = local1.primaryShellFlightSound.sound;
      local2.powerShotFarSounds = Vector.<Sound>([local1.powerShotFarSound1.sound,local1.powerShotFarSound2.sound,local1.powerShotFarSound3.sound]);
      putData(GaussSFXData,local2);
    }

    public function objectUnloaded() : void {
      releaseMaterials(this.getSFXData());
    }

    private function createShell(param1:GaussSFXCC) : Mesh {
      var local2:Mesh = Mesh(param1.shell.objects[0].clone());
      local2.setMaterialToAllFaces(materialRegistry.getMaterial(param1.shellTexture.data));
      return local2;
    }

    public function getSFXData() : GaussSFXData {
      return GaussSFXData(getData(GaussSFXData));
    }
  }
}
