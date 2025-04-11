package alternativa.tanks.models.weapon.rocketlauncher.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.aim.AimSoundEffect;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.MobileSound3DEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.utils.objectpool.ObjectPool;

  public class RocketLauncherEffects implements AimSoundEffect {
    [Inject]
    public static var battleService:BattleService;

    private static const EXPLOSION_OFFSET_TO_CAMERA:Number = 110;
    private static const EXPLOSION_EFFECT_SIZE:int = 700;
    private static const DECAL_RADIUS:Number = 250;
    private static const projectionOrigin:Vector3 = new Vector3();

    private var sfxData:RocketLauncherSfxData;
    private var turret:Object3D;
    private var aimingEffect:MobileSound3DEffect;

    public function RocketLauncherEffects(param1:RocketLauncherSfxData, param2:Object3D) {
      super();
      this.sfxData = param1;
      this.turret = param2;
    }

    public function playShotEffect(param1:Vector3, param2:int) : void {
      var local3:Sound3D = Sound3D.create(this.sfxData.shotSounds[param2 % this.sfxData.shotSounds.length],0.8);
      battleService.addSound3DEffect(Sound3DEffect.create(param1,local3));
    }

    public function playExplosionEffect(param1:Vector3, param2:Vector3, param3:int) : void {
      var local4:ObjectPool = battleService.getObjectPool();
      var local5:StaticObject3DPositionProvider = StaticObject3DPositionProvider(local4.getObject(StaticObject3DPositionProvider));
      local5.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
      var local6:AnimatedSpriteEffect = AnimatedSpriteEffect(local4.getObject(AnimatedSpriteEffect));
      var local7:Number = -Math.PI / 4 + Math.random() * Math.PI / 2;
      local6.init(EXPLOSION_EFFECT_SIZE,EXPLOSION_EFFECT_SIZE,this.sfxData.explosion,local7,local5);
      battleService.addGraphicEffect(local6);
      this.createHitMark(param1,param2);
      this.createExplosionLightEffect(param1);
      var local8:Sound3D = Sound3D.create(this.sfxData.hitSounds[param3 % this.sfxData.hitSounds.length]);
      battleService.addSound3DEffect(Sound3DEffect.create(param1,local8));
    }

    private function createHitMark(param1:Vector3, param2:Vector3) : void {
      projectionOrigin.copy(param1).subtract(param2);
      battleService.getBattleScene3D().addDecal(param1,projectionOrigin,DECAL_RADIUS,this.sfxData.explosionMark);
    }

    private function createExplosionLightEffect(param1:Vector3) : void {
      var local2:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      local3.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
      local2.init(local3,this.sfxData.explosionLightingAnimation);
      battleService.addGraphicEffect(local2);
    }

    public function createRocketFlightSoundEffect(param1:Mesh, param2:Vector3) : RocketFlightEffect {
      var local3:RocketFlightEffect = RocketFlightEffect(battleService.getObjectPool().getObject(RocketFlightEffect));
      local3.init(param1,param2,this.sfxData.rocketFlightSound,this.sfxData);
      return local3;
    }

    public function playAimingSoundEffect() : void {
      this.killAimingSoundEffect();
      var local1:Sound3D = Sound3D.create(this.sfxData.aimingSound);
      this.aimingEffect = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
      this.aimingEffect.init(local1,this.turret,0,Sound3D.ETERNAL_LOOP);
      battleService.addSound3DEffect(this.aimingEffect);
    }

    public function playTargetLostSoundEffect() : void {
      this.killAimingSoundEffect();
      var local1:Sound3D = Sound3D.create(this.sfxData.targetLostSound);
      this.aimingEffect = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
      this.aimingEffect.init(local1,this.turret,0,Sound3D.ETERNAL_LOOP);
      battleService.addSound3DEffect(this.aimingEffect);
    }

    public function playAimingCompleteSoundEffect() : void {
      var local1:Sound3D = Sound3D.create(this.sfxData.aimingCompleteSound);
      var local2:MobileSound3DEffect = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
      local2.init(local1,this.turret);
      battleService.addSound3DEffect(local2);
    }

    public function killAimingSoundEffect() : void {
      if(this.aimingEffect != null) {
        this.aimingEffect.kill();
        this.aimingEffect = null;
      }
    }
  }
}
