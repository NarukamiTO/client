package alternativa.tanks.models.weapon.machinegun.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.sfx.LightAnimation;
  import alternativa.tanks.utils.GraphicsUtils;
  import flash.display.BitmapData;
  import flash.media.Sound;
  import platform.client.fp10.core.type.AutoClosable;
  import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.sfx.MachineGunSFXCC;

  public class MachineGunSFXData implements AutoClosable {
    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    private static const START_FIRE_LIGHT_ANIMATION_NAME:String = "startFire";
    private static const LOOP_FIRE_LIGHT_ANIMATION_NAME:String = "loopFire";

    private var _chainStartSound:Sound;
    private var _turbineStartSound:Sound;
    private var _shootEndSound:Sound;
    private var _shootSound:Sound;
    private var _longFailSound:Sound;
    private var _hitSound:Sound;
    private var _tankHitSound:Sound;
    private var _dustTexture:TextureAnimation;
    private var _fireAcrossTexture:TextureAnimation;
    private var _fireAlongTexture:TextureAnimation;
    private var _smokeTexture:TextureAnimation;
    private var _sparklesTexture:TextureAnimation;
    private var _tankSparklesTexture:TextureAnimation;
    private var _tracerTexture:TextureMaterial;
    private var _fireStartLightAnimation:LightAnimation;
    private var _fireLoopLightAnimation:LightAnimation;
    private var _crumbsTexture:TextureMaterial;

    public function MachineGunSFXData(param1:MachineGunSFXCC, param2:LightingSfx) {
      super();
      this._chainStartSound = param1.chainStartSound.sound;
      this._turbineStartSound = param1.turbineStartSound.sound;
      this._shootEndSound = param1.shootEndSound.sound;
      this._shootSound = param1.shootSound.sound;
      this._longFailSound = param1.longFailSound.sound;
      this._hitSound = param1.hitSound.sound;
      this._tankHitSound = param1.tankHitSound.sound;
      this._dustTexture = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1.dustTexture);
      this._fireAcrossTexture = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1.fireAcrossTexture);
      this._fireAlongTexture = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1.fireAlongTexture);
      this._smokeTexture = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1.smokeTexture);
      this._sparklesTexture = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1.sparklesTexture);
      this._tankSparklesTexture = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1.tankSparklesTexture);
      this._tracerTexture = getTracerMaterial(param1.tracerTexture.data);
      this._fireStartLightAnimation = param2.createAnimation(START_FIRE_LIGHT_ANIMATION_NAME);
      this._fireLoopLightAnimation = param2.createAnimation(LOOP_FIRE_LIGHT_ANIMATION_NAME);
      this._crumbsTexture = materialRegistry.getMaterial(param1.crumbsTexture.data);
    }

    private static function getTracerMaterial(param1:BitmapData) : TextureMaterial {
      var local2:TextureMaterial = materialRegistry.getMaterial(param1);
      local2.repeat = true;
      return local2;
    }

    public function get chainStartSound() : Sound {
      return this._chainStartSound;
    }

    public function get turbineStartSound() : Sound {
      return this._turbineStartSound;
    }

    public function get shootEndSound() : Sound {
      return this._shootEndSound;
    }

    public function get shootSound() : Sound {
      return this._shootSound;
    }

    public function get longFailSound() : Sound {
      return this._longFailSound;
    }

    public function get hitSound() : Sound {
      return this._hitSound;
    }

    public function get tankHitSound() : Sound {
      return this._tankHitSound;
    }

    public function get dustTexture() : TextureAnimation {
      return this._dustTexture;
    }

    public function get fireAcrossTexture() : TextureAnimation {
      return this._fireAcrossTexture;
    }

    public function get fireAlongTexture() : TextureAnimation {
      return this._fireAlongTexture;
    }

    public function get smokeTexture() : TextureAnimation {
      return this._smokeTexture;
    }

    public function get sparklesTexture() : TextureAnimation {
      return this._sparklesTexture;
    }

    public function get tankSparklesTexture() : TextureAnimation {
      return this._tankSparklesTexture;
    }

    public function get tracerTexture() : TextureMaterial {
      return this._tracerTexture;
    }

    public function get fireStartLightAnimation() : LightAnimation {
      return this._fireStartLightAnimation;
    }

    public function get fireLoopLightAnimation() : LightAnimation {
      return this._fireLoopLightAnimation;
    }

    public function get crumbsTexture() : TextureMaterial {
      return this._crumbsTexture;
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      materialRegistry.releaseMaterial(this.dustTexture.material);
      materialRegistry.releaseMaterial(this.fireAcrossTexture.material);
      materialRegistry.releaseMaterial(this.fireAlongTexture.material);
      materialRegistry.releaseMaterial(this.smokeTexture.material);
      materialRegistry.releaseMaterial(this.sparklesTexture.material);
      materialRegistry.releaseMaterial(this.tankSparklesTexture.material);
      materialRegistry.releaseMaterial(this.tracerTexture);
      materialRegistry.releaseMaterial(this.crumbsTexture);
      this._chainStartSound = null;
      this._turbineStartSound = null;
      this._shootEndSound = null;
      this._shootSound = null;
      this._longFailSound = null;
      this._hitSound = null;
      this._tankHitSound = null;
      this._fireStartLightAnimation = null;
      this._fireLoopLightAnimation = null;
    }
  }
}
