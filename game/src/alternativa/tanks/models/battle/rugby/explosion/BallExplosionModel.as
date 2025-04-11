package alternativa.tanks.models.battle.rugby.explosion {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.battle.facilities.FacilityDispellEffect;
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.LightAnimation;
  import alternativa.tanks.sfx.MovingObject3DPositionProvider;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.utils.GraphicsUtils;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import flash.media.Sound;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import projects.tanks.client.battlefield.models.battle.pointbased.rugby.explosion.BallExplosionModelBase;
  import projects.tanks.client.battlefield.models.battle.pointbased.rugby.explosion.IBallExplosionModelBase;

  [ModelInfo]
  public class BallExplosionModel extends BallExplosionModelBase implements IBallExplosionModelBase, ObjectLoadListener, ObjectUnloadListener, BallExplosion, FacilityDispellEffect {
    [Inject]
    public static var materialRegistry:EffectsMaterialRegistry;

    [Inject]
    public static var battleService:BattleService;

    private static const EXPLOSION_SIZE:Number = 800;
    private static const SMOKE_SIZE:Number = 400;
    private static const MIN_SMOKE_SPEED:Number = 800;
    private static const SMOKE_SPEED_DELTA:Number = 200;
    private static const SMOKE_ACCELERATION:Number = -2000;
    private static const EXPLOSION_FIRE_OFFSET_TO_CAMERA:int = 200;
    private static const EXPLOSION_SOUND_VOLUME:Number = 0.4;
    private static const SCALE:Number = 1;

    private const velocity:Vector3 = new Vector3();

    private var flameAnimation:TextureAnimation;
    private var smokeAnimation:TextureAnimation;
    private var lightAnimation:LightAnimation;
    private var explosionSound:Sound;

    public function BallExplosionModel() {
      super();
    }

    public function objectLoaded() : void {
      this.flameAnimation = this.getTextureAnimation(getInitParam().explosionTexture,EXPLOSION_SIZE);
      this.smokeAnimation = this.getTextureAnimation(getInitParam().smokeTextureId,SMOKE_SIZE);
      var local1:LightingSfx = new LightingSfx(getInitParam().lightingSFXEntity);
      this.lightAnimation = local1.createAnimation("ball_explosion");
      this.explosionSound = getInitParam().explosionSound.sound;
    }

    private function getTextureAnimation(param1:MultiframeTextureResource, param2:Number) : TextureAnimation {
      var local3:TextureAnimation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param1);
      local3.material.resolution = param2 / param1.frameWidth;
      return local3;
    }

    public function objectUnloaded() : void {
      this.releaseMaterials();
    }

    public function createDispellEffects(param1:Vector3) : void {
      this.createExplosionEffects(param1);
    }

    public function createExplosionEffects(param1:Vector3) : void {
      var local2:ObjectPool = battleService.getObjectPool();
      this.createExplosionFire(param1,local2);
      this.createExplosionSmoke(param1,local2);
      this.createExplosionLighting(param1,local2);
      this.createExplosionSound(param1);
    }

    private function createExplosionSound(param1:Vector3) : void {
      var local2:Sound3D = Sound3D.create(this.explosionSound,EXPLOSION_SOUND_VOLUME);
      battleService.addSound3DEffect(Sound3DEffect.create(param1,local2,0,0));
    }

    private function createExplosionLighting(param1:Vector3, param2:ObjectPool) : void {
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(param2.getObject(StaticObject3DPositionProvider));
      var local4:AnimatedLightEffect = AnimatedLightEffect(param2.getObject(AnimatedLightEffect));
      local3.init(param1,0);
      local4.init(local3,this.lightAnimation);
      battleService.addGraphicEffect(local4);
    }

    private function releaseMaterials() : void {
      materialRegistry.releaseMaterial(this.flameAnimation.material);
      materialRegistry.releaseMaterial(this.smokeAnimation.material);
    }

    private function createExplosionFire(param1:Vector3, param2:ObjectPool) : void {
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(param2.getObject(StaticObject3DPositionProvider));
      local3.init(param1,EXPLOSION_FIRE_OFFSET_TO_CAMERA);
      var local4:AnimatedSpriteEffect = AnimatedSpriteEffect(param2.getObject(AnimatedSpriteEffect));
      var local5:Number = EXPLOSION_SIZE * SCALE;
      local4.init(local5,local5,this.flameAnimation,Math.random() * 2 * Math.PI,local3);
      battleService.getBattleScene3D().addGraphicEffect(local4);
    }

    private function createExplosionSmoke(param1:Vector3, param2:ObjectPool) : void {
      var local4:Number = NaN;
      var local5:MovingObject3DPositionProvider = null;
      var local6:AnimatedSpriteEffect = null;
      var local7:Number = NaN;
      var local3:int = 0;
      while(local3 < 3) {
        local4 = MIN_SMOKE_SPEED + Math.random() * SMOKE_SPEED_DELTA;
        this.velocity.x = local4 * (1 - 2 * Math.random());
        this.velocity.y = local4 * (1 - 2 * Math.random());
        this.velocity.z = local4 * 0.5 * (1 + Math.random());
        local5 = MovingObject3DPositionProvider(param2.getObject(MovingObject3DPositionProvider));
        local5.init(param1,this.velocity,SMOKE_ACCELERATION);
        local6 = AnimatedSpriteEffect(param2.getObject(AnimatedSpriteEffect));
        local7 = SMOKE_SIZE * SCALE;
        local6.init(local7,local7,this.smokeAnimation,Math.random() * 2 * Math.PI,local5);
        battleService.getBattleScene3D().addGraphicEffect(local6);
        local3++;
      }
    }
  }
}
