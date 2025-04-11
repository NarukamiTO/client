package alternativa.tanks.models.weapon.railgun {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.RayIntersectionData;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.DistanceScaledAnimatedPlaneEffect;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.GraphicsEffectDestructionListener;
  import alternativa.tanks.sfx.ISound3DEffect;
  import alternativa.tanks.sfx.ISoundEffectDestructionListener;
  import alternativa.tanks.sfx.MuzzlePositionProvider;
  import alternativa.tanks.sfx.NormalObject3DPositionProvider;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.sfx.TubeLightEffect;
  import flash.geom.Vector3D;

  public class RailgunEffects implements IRailgunEffects, GraphicsEffectDestructionListener, ISoundEffectDestructionListener {
    public static const CHARGE_EFFECT_SIZE:int = 300;
    public static const RINGS_SIZE:Number = 300;
    public static const SPHERE_SIZE:Number = 200;
    public static const POW_WIDTH:Number = 30;

    private static const DECAL_RADIUS:Number = 50;
    private static const TRAIL_WIDTH:Number = 25;
    private static const TRAIL_BEGIN_SCALE:Number = 0.5;
    private static const TRAIL_END_SCALE:Number = 1.5;
    private static const TRAIL_MOVE_DISTANCE:Number = 20;
    private static const TRAIL_LIFE_TIME:int = 500;
    private static const SMOKE_WIDTH:Number = 80;
    private static const SMOKE_BEGIN_SCALE:Number = 0.5;
    private static const SMOKE_END_SCALE:Number = 2;
    private static const SMOKE_MOVE_DISTANCE:Number = 100;
    private static const SMOKE_LIFE_TIME:int = 2200;
    private static const SOUND_VOLUME:Number = 1;
    private static const _rayOrigin:Vector3D = new Vector3D();
    private static const _rayDirection:Vector3D = new Vector3D();
    private static const _effectPosition:Vector3 = new Vector3();
    private static const _effectNormal:Vector3 = new Vector3();
    private static const _effectDirection:Vector3 = new Vector3();
    private static const _rotation:Vector3 = new Vector3();
    private static const v:Vector3 = new Vector3();

    private var sfxData:RailgunSFXData;
    private var battleService:BattleService;
    private var chargeEffect:ChargeEffect;
    private var chargeLightEffect:AnimatedLightEffect;
    private var soundEffect:Sound3DEffect;

    public function RailgunEffects(param1:RailgunSFXData, param2:BattleService) {
      super();
      this.sfxData = param1;
      this.battleService = param2;
    }

    private static function projectHitPoint(param1:Vector3, param2:Vector3, param3:Vector3, param4:Vector3) : void {
      param4.copy(param1).subtract(param2);
      var local5:Number = param4.dot(param3);
      param4.copy(param2).addScaled(local5,param3);
    }

    private static function getRaycastData(param1:Vector3D, param2:Vector3D, param3:TankSkin) : RayIntersectionData {
      var local4:RayIntersectionData = raycast(param3.getHullMesh(),param1,param2);
      var local5:RayIntersectionData = raycast(param3.getTurret3D(),param1,param2);
      if(local4 == null) {
        return local5;
      }
      if(local5 == null) {
        return local4;
      }
      if(local5.time < local4.time) {
        return local5;
      }
      return local4;
    }

    private static function raycast(param1:Object3D, param2:Vector3D, param3:Vector3D) : RayIntersectionData {
      var local4:Vector3D = param1.globalToLocal(param2);
      var local5:Vector3D = param3.clone();
      local5.x += param1.x;
      local5.y += param1.y;
      local5.z += param1.z;
      var local6:Vector3D = param1.globalToLocal(local5);
      return param1.intersectRay(local4,local6);
    }

    private static function getRotation(param1:Vector3) : Vector3 {
      _rotation.x = Math.atan2(param1.z,Math.sqrt(param1.x * param1.x + param1.y * param1.y)) - Math.PI / 2;
      _rotation.y = 0;
      _rotation.z = -Math.atan2(param1.x,param1.y);
      return _rotation;
    }

    public function createChargeEffect(param1:Vector3, param2:Object3D, param3:int) : void {
      if(this.chargeEffect != null) {
        this.chargeEffect.kill();
      }
      this.chargeEffect = ChargeEffect(this.battleService.getObjectPool().getObject(ChargeEffect));
      this.chargeEffect.init(CHARGE_EFFECT_SIZE,CHARGE_EFFECT_SIZE,this.sfxData.chargingAnimation,param1,param2,0,this.getChargingEffectFPS(param3),this);
      this.battleService.addGraphicEffect(this.chargeEffect);
      this.createChargeLightEffect(param1,param2,param3);
    }

    public function createChargeLightEffect(param1:Vector3, param2:Object3D, param3:int) : void {
      if(this.chargeLightEffect != null) {
        this.chargeLightEffect.kill();
      }
      this.chargeLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local4:MuzzlePositionProvider = MuzzlePositionProvider(this.battleService.getObjectPool().getObject(MuzzlePositionProvider));
      local4.init(param2,param1);
      this.chargeLightEffect.initFromTime(local4,param3,this.sfxData.chargeLightAnimation);
      this.battleService.addGraphicEffect(this.chargeLightEffect);
    }

    private function getChargingEffectFPS(param1:int) : Number {
      return 1000 * this.sfxData.chargingAnimation.frames.length / param1;
    }

    public function createSoundEffect(param1:Vector3, param2:int) : void {
      var local3:Sound3D = Sound3D.create(this.sfxData.sound,SOUND_VOLUME);
      this.soundEffect = Sound3DEffect.create(param1,local3,0,param2,this);
      this.battleService.addSound3DEffect(this.soundEffect);
    }

    public function createShotTrail(param1:Vector3, param2:Vector3, param3:Vector3) : void {
      var local4:ShotTrailEffect = null;
      var local5:ShotSmokeEffect = null;
      if(param2 == null) {
        param2 = RailgunUtils.getDistantPoint(param1,param3);
      }
      v.diff(param2,param1);
      if(v.dot(param3) > 0) {
        local4 = ShotTrailEffect(this.battleService.getObjectPool().getObject(ShotTrailEffect));
        local4.init(param1,param2,this.sfxData.trailMaterial,TRAIL_WIDTH,TRAIL_BEGIN_SCALE,TRAIL_END_SCALE,TRAIL_MOVE_DISTANCE,TRAIL_LIFE_TIME);
        this.battleService.addGraphicEffect(local4);
        local5 = ShotSmokeEffect(this.battleService.getObjectPool().getObject(ShotSmokeEffect));
        local5.init(param1,param2,this.sfxData.smokeMaterial,SMOKE_WIDTH,SMOKE_BEGIN_SCALE,SMOKE_END_SCALE,SMOKE_MOVE_DISTANCE,SMOKE_LIFE_TIME);
        this.battleService.addGraphicEffect(local5);
      }
      this.createShotLightEffect(param1);
      this.createRailLightEffect(param1,param2);
    }

    private function createRailLightEffect(param1:Vector3, param2:Vector3) : void {
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      var local4:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      local3.init(param1,0);
      local4.init(param2,0);
      var local5:TubeLightEffect = TubeLightEffect(this.battleService.getObjectPool().getObject(TubeLightEffect));
      local5.init(local3,local4,this.sfxData.railLightAnimation);
      this.battleService.addGraphicEffect(local5);
    }

    public function createShotLightEffect(param1:Vector3) : void {
      var local2:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      local3.init(param1,0);
      local2.init(local3,this.sfxData.shotLightAnimation);
      this.battleService.addGraphicEffect(local2);
    }

    public function createStaticHitMark(param1:Vector3, param2:Vector3) : void {
      if(param2 != null) {
        this.battleService.getBattleScene3D().addDecal(param2,param1,DECAL_RADIUS,this.sfxData.hitMarkMaterial);
      }
    }

    public function stopEffects() : void {
      if(this.chargeEffect != null) {
        this.chargeEffect.kill();
        this.chargeEffect = null;
      }
      if(this.chargeLightEffect != null) {
        this.chargeLightEffect.kill();
        this.chargeLightEffect = null;
      }
      if(this.soundEffect != null) {
        this.soundEffect.kill();
        this.soundEffect = null;
      }
    }

    public function onGraphicsEffectDestroyed(param1:GraphicEffect) : void {
      if(this.chargeEffect == param1) {
        this.chargeEffect = null;
      }
    }

    public function onSoundEffectDestroyed(param1:ISound3DEffect) : void {
      if(this.soundEffect == param1) {
        this.soundEffect = null;
      }
    }

    public function createTargetHitEffects(param1:Vector3, param2:Vector3, param3:Vector.<Vector3>, param4:Vector.<Body>) : void {
      var local6:Body = null;
      var local7:Tank = null;
      var local8:RayIntersectionData = null;
      var local9:Object3D = null;
      var local10:Vector3D = null;
      _rayOrigin.x = param1.x;
      _rayOrigin.y = param1.y;
      _rayOrigin.z = param1.z;
      _rayDirection.x = param2.x - param1.x;
      _rayDirection.y = param2.y - param1.y;
      _rayDirection.z = param2.z - param1.z;
      _effectDirection.copy(param2).subtract(param1).normalize();
      var local5:int = 0;
      while(local5 < param4.length) {
        local6 = param4[local5];
        if(local6 != null && local6.tank != null) {
          local7 = local6.tank;
          local8 = getRaycastData(_rayOrigin,_rayDirection,local7.getSkin());
          if(local8 == null) {
            projectHitPoint(param3[local5],param1,_effectDirection,_effectPosition);
            _effectNormal.copy(_effectDirection);
          } else {
            local9 = local8.object;
            _effectPosition.copyFromVector3D(local9.localToGlobal(local8.point));
            local10 = local9.localToGlobal(local8.face.normal);
            _effectNormal.x = local10.x - local9.x;
            _effectNormal.y = local10.y - local9.y;
            _effectNormal.z = local10.z - local9.z;
          }
          this.createHitEffect(_effectPosition,_effectNormal,_effectDirection);
          this.createHitLightEffect(_effectPosition,_effectNormal);
        }
        local5++;
      }
    }

    private function createHitLightEffect(param1:Vector3, param2:Vector3) : void {
      var local3:AnimatedLightEffect = AnimatedLightEffect(this.battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local4:NormalObject3DPositionProvider = NormalObject3DPositionProvider(this.battleService.getObjectPool().getObject(NormalObject3DPositionProvider));
      local4.init(param1,param2,50);
      local3.init(local4,this.sfxData.hitLightAnimation);
      this.battleService.addGraphicEffect(local3);
    }

    private function createHitEffect(param1:Vector3, param2:Vector3, param3:Vector3) : void {
      var local4:DistanceScaledAnimatedPlaneEffect = DistanceScaledAnimatedPlaneEffect(this.battleService.getObjectPool().getObject(DistanceScaledAnimatedPlaneEffect));
      local4.init(RINGS_SIZE,param1,getRotation(param2),this.sfxData.ringsAnimation,1);
      this.battleService.getBattleScene3D().addGraphicEffect(local4);
      var local5:AnimatedSpriteEffect = AnimatedSpriteEffect(this.battleService.getObjectPool().getObject(AnimatedSpriteEffect));
      var local6:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      local6.init(param1,30);
      local5.init(SPHERE_SIZE,SPHERE_SIZE,this.sfxData.ringsAnimation,0,local6,0.5,0.5,null,0);
      this.battleService.getBattleScene3D().addGraphicEffect(local5);
      var local7:RailgunPowEffect = RailgunPowEffect(this.battleService.getObjectPool().getObject(RailgunPowEffect));
      local7.init(param1,param3,this.sfxData.powAnimation);
      this.battleService.getBattleScene3D().addGraphicEffect(local7);
    }

    public function createStaticHitEffect(param1:Vector3, param2:Vector3, param3:Vector3) : void {
      _effectDirection.copy(param2).subtract(param1).normalize();
      this.createHitEffect(param2,param3,_effectDirection);
      this.createHitLightEffect(param2,param3);
    }
  }
}
