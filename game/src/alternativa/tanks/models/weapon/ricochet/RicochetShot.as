package alternativa.tanks.models.weapon.ricochet {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.engine3d.AnimatedSprite3D;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.shared.MarginalCollider;
  import alternativa.tanks.models.weapon.splash.Splash;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.models.weapons.shell.Shell;
  import alternativa.tanks.models.weapons.shell.states.DummyShellStates;
  import alternativa.tanks.models.weapons.shell.states.ShellStates;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.ExternalObject3DPositionProvider;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import alternativa.tanks.utils.objectpool.Pool;
  import flash.media.Sound;
  import projects.tanks.client.battlefield.models.tankparts.weapon.ricochet.RicochetCC;

  public class RicochetShot extends Shell {
    public static const SPRITE_SIZE:Number = 300;
    public static const EXPLOSION_SPRITE_SIZE:Number = 266;
    public static const TRAIL_WIDTH:Number = 100;

    private static const BUMP_FLASH_SPRITE_SIZE:Number = 80;
    private static const TRAIL_LENGTH:Number = 300;
    private static const NUM_RADIAL_RAYS:int = 6;
    private static const staticHitNormal:Vector3 = new Vector3();
    private static const barrelDirection:Vector3 = new Vector3();
    private static const staticHitPoint:Vector3 = new Vector3();

    private var sfxData:RicochetSFXData;
    private var callback:RicochetWeaponCallback;
    private var impactPoints:Vector.<Vector3>;
    private var ricochetInitParams:RicochetCC;
    private var sprite:AnimatedSprite3D;
    private var weakening:DistanceWeakening;
    private var ricochetCount:int;
    private var tailTrail:TailTrail;
    private var impactForce:Number;
    private var lightingEffect:AnimatedLightEffect;
    private var lightEffectPositionProvider:ExternalObject3DPositionProvider;
    private var splash:Splash;

    public function RicochetShot(param1:Pool) {
      super(param1);
      this.sprite = new AnimatedSprite3D(SPRITE_SIZE,SPRITE_SIZE);
      this.sprite.looped = true;
      this.tailTrail = new TailTrail(TRAIL_WIDTH,TRAIL_LENGTH);
      this.impactPoints = new Vector.<Vector3>();
    }

    override protected function createShellStates() : ShellStates {
      return DummyShellStates.INSTANCE;
    }

    public function init(param1:Number, param2:RicochetCC, param3:RicochetSFXData, param4:DistanceWeakening, param5:RicochetWeaponCallback, param6:Splash) : void {
      this.impactForce = param1;
      this.ricochetInitParams = param2;
      this.sfxData = param3;
      this.weakening = param4;
      this.callback = param5;
      this.splash = param6;
      this.sprite.rotation = 2 * Math.PI * Math.random();
      this.sprite.setAnimationData(param3.shotAnimation);
      this.sprite.setFrameIndex(this.sprite.getNumFrames() * Math.random());
      this.tailTrail.setMaterialToAllFaces(param3.tailTrailMaterial);
      this.ricochetCount = 0;
      this.impactPoints.length = 0;
      this.lightingEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
      this.lightEffectPositionProvider = ExternalObject3DPositionProvider(battleService.getObjectPool().getObject(ExternalObject3DPositionProvider));
      this.lightingEffect.init(this.lightEffectPositionProvider,param3.shellLightAnimation,AnimatedLightEffect.DEFAULT_MAX_DISTANCE,true);
    }

    override public function addToGame(param1:AllGlobalGunParams, param2:Vector3, param3:Body, param4:Boolean, param5:int) : void {
      super.addToGame(param1,param2,param3,param4,param5);
      var local6:BattleScene3D = battleService.getBattleScene3D();
      local6.addObject(this.sprite);
      local6.addObject(this.tailTrail);
      local6.addObjectToExclusion(this.tailTrail);
      local6.addGraphicEffect(this.lightingEffect);
    }

    override protected function update(param1:Number) : void {
      var local4:Body = null;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:int = 0;
      var local8:Vector3 = null;
      var local9:Boolean = false;
      var local10:Number = NaN;
      if(totalDistance >= this.ricochetInitParams.shotDistance) {
        this.destroy();
        return;
      }
      var local2:CollisionDetector = battleService.getBattleRunner().getCollisionDetector();
      var local3:Number = this.ricochetInitParams.shellSpeed * param1;
      prevPosition.copy(currPosition);
      while(local3 > 0) {
        local5 = -1;
        local6 = local3;
        if(local2.raycast(currPosition,flightDirection,CollisionGroup.WEAPON,local3,this,_rayHit)) {
          local4 = _rayHit.shape.body;
          local5 = _rayHit.t;
          if(BattleUtils.isTankBody(local4)) {
            this.impactPoints.push(_rayHit.position.clone().add(_rayHit.normal));
            this.handleTargetHit(local4,_rayHit.position,flightDirection,totalDistance + local5,this.impactPoints);
            return;
          }
          local6 = local5;
          staticHitPoint.copy(_rayHit.position);
          staticHitNormal.copy(_rayHit.normal);
        }
        local7 = 0;
        while(local7 < NUM_RADIAL_RAYS) {
          local8 = radialPoints[local7];
          if(local2.raycast(local8,flightDirection,CollisionGroup.WEAPON,local6,this,_rayHit)) {
            local4 = _rayHit.shape.body;
            _hitPoint.copy(currPosition).addScaled(_rayHit.t,flightDirection);
            local9 = BattleUtils.isTankBody(local4) && !this.thickRaycast(currPosition,_hitPoint);
            if(local9) {
              this.impactPoints.push(_hitPoint.clone());
              this.handleTargetHit(local4,_hitPoint,flightDirection,totalDistance + _rayHit.t,this.impactPoints);
              return;
            }
          }
          local8.addScaled(local6,flightDirection);
          local7++;
        }
        if(local5 > -1) {
          totalDistance += local5;
          local3 -= local5;
          if(this.ricochetCount >= this.ricochetInitParams.maxRicochetCount) {
            local10 = this.weakening.getImpactCoeff(totalDistance);
            this.impactPoints.push(staticHitPoint.clone());
            this.handleStaticHit(staticHitNormal,local10,local4);
            return;
          }
          ++this.ricochetCount;
          currPosition.addScaled(local5,flightDirection);
          this.reflectTrajectory(staticHitNormal);
          this.createBumpEffects(currPosition);
          this.impactPoints.push(currPosition.clone());
        } else {
          totalDistance += local3;
          currPosition.addScaled(local3,flightDirection);
          local3 = 0;
        }
      }
    }

    private function handleStaticHit(param1:Vector3, param2:Number = 1, param3:Body = null) : void {
      var local4:Vector3 = this.impactPoints[this.impactPoints.length - 1];
      local4.addScaled(0.1,param1);
      var local5:Boolean = Boolean(this.splash.applySplashForce(local4,param2,param3));
      this.createExplosionEffect(local4);
      if(Boolean(this.callback) && local5) {
        this.callback.onStaticHit(getShotId(),this.impactPoints);
      }
      this.destroy();
    }

    private function thickRaycast(param1:Vector3, param2:Vector3) : Boolean {
      return MarginalCollider.segmentWithStaticIntersection(param1,param2);
    }

    private function reflectTrajectory(param1:Vector3) : void {
      currPosition.addScaled(0.1,param1);
      flightDirection.addScaled(-2 * flightDirection.dot(param1),param1);
      initRadialPoints(currPosition,flightDirection);
    }

    override public function render(param1:int, param2:int) : void {
      this.sprite.x = interpolatedPosition.x;
      this.sprite.y = interpolatedPosition.y;
      this.sprite.z = interpolatedPosition.z;
      this.sprite.update(param2 / 1000);
      var local3:Number = this.weakening.getImpactCoeff(totalDistance);
      var local4:Number = SPRITE_SIZE * local3;
      this.sprite.width = local4;
      this.sprite.height = local4;
      this.sprite.rotation -= 0.003 * param2;
      var local5:Vector3 = battleService.getBattleScene3D().getCamera().position;
      SFXUtils.alignObjectPlaneToView(this.tailTrail,interpolatedPosition,flightDirection,local5);
      var local6:Number = currPosition.x - local5.x;
      var local7:Number = currPosition.y - local5.y;
      var local8:Number = currPosition.z - local5.z;
      var local9:Number = local6 * local6 + local7 * local7 + local8 * local8;
      if(local9 > 0.00001) {
        local9 = 1 / Math.sqrt(local9);
        local6 *= local9;
        local7 *= local9;
        local8 *= local9;
      }
      var local10:Number = local6 * flightDirection.x + local7 * flightDirection.y + local8 * flightDirection.z;
      if(local10 < 0) {
        local10 = -local10;
      }
      if(local10 > 0.5) {
        this.tailTrail.alpha = 2 * (1 - local10) * local3;
      } else {
        this.tailTrail.alpha = local3;
      }
      this.lightEffectPositionProvider.setPosition(interpolatedPosition);
    }

    override protected function destroy() : void {
      var local1:BattleScene3D = null;
      super.destroy();
      local1 = battleService.getBattleScene3D();
      local1.removeObject(this.sprite);
      this.sprite.material = null;
      local1.removeObject(this.tailTrail);
      this.tailTrail.setMaterialToAllFaces(null);
      local1.removeObjectFromExclusion(this.tailTrail);
      shooterBody = null;
      this.ricochetInitParams = null;
      this.sfxData = null;
      this.weakening = null;
      this.callback = null;
      this.lightingEffect.kill();
      this.lightingEffect = null;
      this.lightEffectPositionProvider = null;
    }

    override public function considerBody(param1:Body) : Boolean {
      return super.considerBody(param1) || this.ricochetCount > 0;
    }

    private function createExplosionEffect(param1:Vector3) : void {
      var local2:ObjectPool = battleService.getObjectPool();
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(local2.getObject(StaticObject3DPositionProvider));
      var local4:int = 50;
      local3.init(param1,local4);
      var local5:AnimatedSpriteEffect = AnimatedSpriteEffect(local2.getObject(AnimatedSpriteEffect));
      var local6:Number = Math.random() * Math.PI * 2;
      var local7:int = 0;
      local5.init(EXPLOSION_SPRITE_SIZE,EXPLOSION_SPRITE_SIZE,this.sfxData.explosionAnimation,local6,local3,0.5,0.5,null,local7);
      battleService.addGraphicEffect(local5);
      this.addSoundEffect(this.sfxData.explosionSound,param1);
      this.createExplosionLightEffect(param1);
    }

    private function createExplosionLightEffect(param1:Vector3) : void {
      var local2:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      local3.init(param1,50);
      local2.init(local3,this.sfxData.hitLightAnimation);
      battleService.addGraphicEffect(local2);
    }

    private function createRicochetLightEffect(param1:Vector3) : void {
      var local2:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      local3.init(param1,50);
      local2.init(local3,this.sfxData.ricochetLightAnimation);
      battleService.addGraphicEffect(local2);
    }

    private function addSoundEffect(param1:Sound, param2:Vector3) : void {
      var local3:Number = NaN;
      var local4:Sound3D = null;
      var local5:Sound3DEffect = null;
      if(param1 != null) {
        local3 = 0.8;
        local4 = Sound3D.create(param1,local3);
        local5 = Sound3DEffect.create(param2,local4);
        battleService.addSound3DEffect(local5);
      }
    }

    private function handleTargetHit(param1:Body, param2:Vector3, param3:Vector3, param4:Number, param5:Vector.<Vector3>) : void {
      this.createExplosionEffect(param2);
      var local6:Number = this.weakening.getImpactCoeff(param4);
      var local7:Tank = param1.tank;
      local7.applyWeaponHit(param2,param3,local6 * this.impactForce);
      this.splash.applySplashForce(param2,local6,param1);
      this.onTargetHit(param1,param5);
      this.destroy();
    }

    private function onTargetHit(param1:Body, param2:Vector.<Vector3>) : void {
      if(Boolean(this.callback)) {
        this.callback.onTargetHit(getShotId(),param1,param2);
      }
    }

    private function createBumpEffects(param1:Vector3) : void {
      var local2:ObjectPool = battleService.getObjectPool();
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(local2.getObject(StaticObject3DPositionProvider));
      var local4:int = 50;
      local3.init(param1,local4);
      var local5:AnimatedSpriteEffect = AnimatedSpriteEffect(local2.getObject(AnimatedSpriteEffect));
      local5.init(BUMP_FLASH_SPRITE_SIZE,BUMP_FLASH_SPRITE_SIZE,this.sfxData.ricochetFlashAnimation,Math.random() * Math.PI * 2,local3,0.5,0.5);
      battleService.addGraphicEffect(local5);
      this.addSoundEffect(this.sfxData.ricochetSound,param1);
      this.createRicochetLightEffect(param1);
    }

    override protected function checkIfBarrelIntersectsWithObstacle() : Boolean {
      var local1:CollisionDetector = battleService.getBattleRunner().getCollisionDetector();
      barrelDirection.diff(currPosition,barrelOrigin);
      var local2:Number = barrelDirection.length();
      barrelDirection.normalize();
      return this.doRaycastTests(barrelDirection,local2,local1);
    }

    private function doRaycastTests(param1:Vector3, param2:Number, param3:CollisionDetector) : Boolean {
      if(param3.raycast(barrelOrigin,param1,CollisionGroup.WEAPON,param2,this,_rayHit)) {
        this.impactPoints.push(_rayHit.position.clone());
        if(BattleUtils.isTankBody(_rayHit.shape.body)) {
          this.handleTargetHit(_rayHit.shape.body,_rayHit.position,param1,0,this.impactPoints);
          return true;
        }
        if(this.ricochetCount >= this.ricochetInitParams.maxRicochetCount) {
          this.handleStaticHit(_rayHit.normal);
          return true;
        }
        ++this.ricochetCount;
        currPosition.copy(_rayHit.position);
        this.reflectTrajectory(_rayHit.normal);
        this.createBumpEffects(_rayHit.position);
        return false;
      }
      return this.checkIfRadialPointsIntersectWithTarget(param1,param2,param3);
    }

    private function checkIfRadialPointsIntersectWithTarget(param1:Vector3, param2:Number, param3:CollisionDetector) : Boolean {
      var local5:Vector3 = null;
      var local6:Body = null;
      initRadialPoints(barrelOrigin,param1);
      var local4:int = 0;
      while(local4 < NUM_RADIAL_RAYS) {
        local5 = radialPoints[local4];
        if(param3.raycast(local5,flightDirection,CollisionGroup.WEAPON,param2,this,_rayHit)) {
          local6 = _rayHit.shape.body;
          if(BattleUtils.isTankBody(local6)) {
            _hitPoint.copy(barrelOrigin).addScaled(_rayHit.t,param1);
            this.impactPoints.push(_hitPoint.clone());
            this.handleTargetHit(local6,_hitPoint,param1,0,this.impactPoints);
            return true;
          }
        }
        local4++;
      }
      return false;
    }

    override protected function getRadius() : Number {
      return this.ricochetInitParams.shellRadius;
    }

    override protected function getNumRadialRays() : int {
      return NUM_RADIAL_RAYS;
    }
  }
}
