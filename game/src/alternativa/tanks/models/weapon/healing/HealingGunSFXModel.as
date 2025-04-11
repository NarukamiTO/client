package alternativa.tanks.models.weapon.healing {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.engine3d.UVFrame;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.utils.GraphicsUtils;
  import flash.display.BitmapData;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.client.battlefield.models.tankparts.sfx.isis.IIsisSFXModelBase;
  import projects.tanks.client.battlefield.models.tankparts.sfx.isis.IsisSFXCC;
  import projects.tanks.client.battlefield.models.tankparts.sfx.isis.IsisSFXModelBase;

  [ModelInfo]
  public class HealingGunSFXModel extends IsisSFXModelBase implements IIsisSFXModelBase, ObjectLoadPostListener, ObjectUnloadListener, IHealingGunSFXModel {
    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    [Inject]
    public static var battleService:BattleService;

    public function HealingGunSFXModel() {
      super();
    }

    private static function createMaterial(param1:BitmapData) : TextureMaterial {
      var local2:TextureMaterial = materialRegistry.getMaterial(param1);
      local2.repeat = true;
      return local2;
    }

    private static function flipUVFrames(param1:Vector.<UVFrame>) : Vector.<UVFrame> {
      var local2:Vector.<UVFrame> = new Vector.<UVFrame>();
      var local3:int = param1.length - 1;
      while(local3 >= 0) {
        local2.push(param1[local3]);
        local3--;
      }
      return local2;
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      var local1:IsisSFXCC = getInitParam();
      var local2:HealingGunSFXData = new HealingGunSFXData();
      var local3:MultiframeTextureResource = local1.healingBall;
      var local4:TextureMaterial = createMaterial(local1.healingBall.data);
      var local5:TextureMaterial = createMaterial(local1.healingBall.data);
      var local6:TextureMaterial = createMaterial(local1.healingRay.data);
      var local7:TextureMaterial = createMaterial(local1.damagingBall.data);
      var local8:TextureMaterial = createMaterial(local1.damagingRay.data);
      var local9:Vector.<UVFrame> = GraphicsUtils.getUVFramesFromTexture(local4.texture,local3.frameWidth,local3.frameHeight,local3.numFrames);
      var local10:Vector.<UVFrame> = flipUVFrames(local9);
      local2.idleMuzzle = new TextureAnimation(local4,local9,local3.fps);
      local2.idleSound = local1.idleSound.sound;
      local2.healMuzzle = new TextureAnimation(local5,local9,local3.fps);
      local2.healTarget = new TextureAnimation(local5,local10,local3.fps);
      local2.healShaft = local6;
      local2.healSound = local1.healingSound.sound;
      local2.damageMuzzle = new TextureAnimation(local7,local10,local3.fps);
      local2.damageTarget = new TextureAnimation(local7,local9,local3.fps);
      local2.damageShaft = local8;
      local2.damageSound = local1.damagingSound.sound;
      var local11:LightingSfx = new LightingSfx(local1.lightingSFXEntity);
      local2.startLightAnimation = local11.createAnimation("start");
      local2.loopLightAnimation = local11.createAnimation("loop");
      local2.friendStartLightAnimation = local11.createAnimation("friendStart");
      local2.friendLoopLightAnimation = local11.createAnimation("friendLoop");
      local2.enemyStartLightAnimation = local11.createAnimation("enemyStart");
      local2.enemyLoopLightAnimation = local11.createAnimation("enemyLoop");
      local2.friendBeamAnimation = local11.createAnimation("friendBeam");
      local2.enemyBeamAnimation = local11.createAnimation("enemyBeam");
      putData(HealingGunSFXData,local2);
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      var local4:TextureMaterial = null;
      var local1:HealingGunSFXData = HealingGunSFXData(getData(HealingGunSFXData));
      var local2:Array = local1.getMaterialsToRelease();
      var local3:int = 0;
      while(local3 < local2.length) {
        local4 = local2[local3];
        materialRegistry.releaseMaterial(local4);
        local3++;
      }
    }

    public function getHealingGunEffects() : HealingGunEffects {
      return new HealingGunEffectsImpl(battleService,HealingGunSFXData(getData(HealingGunSFXData)));
    }
  }
}
