package alternativa.tanks.models.weapon.gauss.sfx {
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.scene3d.RotationState;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.gauss.GaussWeaponCallback;
  import alternativa.tanks.models.weapon.splash.Splash;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.models.weapons.shell.InelasticShell;
  import alternativa.tanks.models.weapons.shell.states.DummyShellStates;
  import alternativa.tanks.models.weapons.shell.states.ShellStates;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.ExternalObject3DPositionProvider;
  import alternativa.tanks.sfx.MobileSound3DEffect;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.utils.MathUtils;
  import alternativa.tanks.utils.objectpool.Pool;
  import projects.tanks.client.battlefield.models.tankparts.weapon.gauss.GaussCC;

  public class GaussShell extends InelasticShell {
    private static var shellMesh:Mesh;

    private static const SHELL_SCALE:Number = 0.25;
    private static const TRAIL_SIZE:Number = 50;
    private static const TRAIL_FULL_SIZE:Number = 4800;
    private static const EXPLOSION_OFFSET_TO_CAMERA:Number = 110;
    private static const EXPLOSION_SPRITE_SIZE:Number = 500;
    private static const HIT_MARK_RADIUS:Number = 250;

    private var weakening:DistanceWeakening;
    private var sfxData:GaussSFXData;
    private var callback:GaussWeaponCallback;
    private var gaussData:GaussCC;
    private var impactForce:Number;
    private var lightEffect:AnimatedLightEffect;
    private var lightEffectPositionProvider:ExternalObject3DPositionProvider;
    private var splash:Splash;
    private var view:Mesh;
    private var trailStart:Vector3 = new Vector3();
    private var trailEnd:Vector3 = new Vector3();
    private var gunParams:AllGlobalGunParams;
    private var trail:GaussTrail = new GaussTrail();
    private var shellSound:MobileSound3DEffect;

    public function GaussShell(param1:Pool) {
      super(param1);
    }

    override protected function createShellStates() : ShellStates {
      return DummyShellStates.INSTANCE;
    }

    public function init(param1:Number, param2:GaussCC, param3:GaussSFXData, param4:DistanceWeakening, param5:GaussWeaponCallback, param6:Splash) : void {
      this.impactForce = param1;
      this.gaussData = param2;
      this.weakening = param4;
      this.sfxData = param3;
      this.callback = param5;
      this.splash = param6;
      if(shellMesh == null) {
        shellMesh = Mesh(param3.shellMesh);
        shellMesh.scaleX = SHELL_SCALE;
        shellMesh.scaleY = SHELL_SCALE;
        shellMesh.scaleZ = SHELL_SCALE;
        if(shellMesh.sorting != Sorting.DYNAMIC_BSP) {
          shellMesh.sorting = Sorting.DYNAMIC_BSP;
          shellMesh.calculateFacesNormals(true);
          shellMesh.optimizeForDynamicBSP();
        }
      }
      this.view = Mesh(shellMesh.clone());
      this.lightEffect = AnimatedLightEffect(this.getObject(AnimatedLightEffect));
      this.lightEffectPositionProvider = ExternalObject3DPositionProvider(this.getObject(ExternalObject3DPositionProvider));
      this.lightEffect.init(this.lightEffectPositionProvider,param3.primaryShellLightAnimation,AnimatedLightEffect.DEFAULT_MAX_DISTANCE,true);
      this.trail.size = TRAIL_SIZE;
      this.trail.useLight = false;
      this.trail.useShadowMap = false;
      this.trail.alpha = 0.5;
      this.trail.material = param3.tracerTextureMaterial;
    }

    override public function addToGame(param1:AllGlobalGunParams, param2:Vector3, param3:Body, param4:Boolean, param5:int) : void {
      super.addToGame(param1,param2,param3,param4,param5);
      this.gunParams = param1;
      battleService.getBattleScene3D().addObject(this.view);
      battleService.getBattleScene3D().addObject(this.trail);
      battleService.addGraphicEffect(this.lightEffect);
      var local6:Matrix3 = BattleUtils.tmpMatrix3;
      local6.setDirectionVector(param2);
      this.setShellRotation(local6);
      this.playFlightSound();
    }

    private function setShellRotation(param1:Matrix3) : void {
      var local2:Vector3 = BattleUtils.tmpVector;
      param1.getEulerAngles(local2);
      this.view.rotationX = local2.x;
      this.view.rotationY = local2.y;
      this.view.rotationZ = local2.z;
    }

    override protected function getSpeed() : Number {
      return this.gaussData.primaryShellSpeed;
    }

    override protected function getMaxDistance() : Number {
      return this.gaussData.shotRange;
    }

    override protected function processHitImpl(param1:Body, param2:Vector3, param3:Vector3, param4:Number, param5:int) : void {
      var local8:Tank = null;
      super.processHitImpl(param1,param2,param3,param4,param5);
      var local6:Number = this.weakening.getImpactCoeff(param4);
      this.createExplosionEffect(param2);
      this.createExplosionLightEffect(param2);
      this.shellSound.kill();
      this.playHitSound();
      var local7:Boolean = Boolean(this.splash.applySplashForce(param2,local6,param1));
      if(BattleUtils.isTankBody(param1)) {
        local8 = param1.tank;
        local8.applyWeaponHit(param2,param3,this.impactForce * local6);
        if(Boolean(this.callback)) {
          this.callback.doPrimaryHitTarget(getShotId(),local8.user,param1.state.position,param2);
        }
      } else {
        if(Boolean(this.callback) && local7) {
          this.callback.doPrimaryHitStatic(getShotId(),param2);
        }
        this.createHitMark(param2);
      }
      this.destroy();
    }

    override public function render(param1:int, param2:int) : void {
      BattleUtils.setObjectPosition3d(this.view,interpolatedPosition.toVector3d());
      this.lightEffectPositionProvider.setPosition(interpolatedPosition);
      var local3:Number = interpolatedPosition.distanceTo(this.gunParams.muzzlePosition);
      var local4:Number = Math.min(local3,TRAIL_FULL_SIZE);
      this.trail.scaleY = local4 / TRAIL_SIZE;
      this.trailEnd.copy(interpolatedPosition);
      this.trailStart.copy(this.trailEnd);
      this.trailStart.addScaled(-local4,flightDirection);
      SFXUtils.alignObjectPlaneToView(this.trail,this.trailStart,flightDirection,battleService.getBattleScene3D().getCamera().position);
    }

    override protected function destroy() : void {
      super.destroy();
      battleService.getBattleScene3D().removeObject(this.view);
      battleService.getBattleScene3D().removeObject(this.trail);
      this.gaussData = null;
      this.callback = null;
      shooterBody = null;
      this.weakening = null;
      this.sfxData = null;
      this.lightEffect.kill();
      this.lightEffect = null;
      this.lightEffectPositionProvider = null;
    }

    override protected function getRadius() : Number {
      return this.gaussData.primaryShellRadius;
    }

    private function createExplosionEffect(param1:Vector3) : void {
      var local2:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.getObject(StaticObject3DPositionProvider));
      local2.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
      var local3:AnimatedSpriteEffect = AnimatedSpriteEffect(this.getObject(AnimatedSpriteEffect));
      var local4:Number = MathUtils.PI2 * Math.random();
      local3.init(EXPLOSION_SPRITE_SIZE,EXPLOSION_SPRITE_SIZE,this.sfxData.explosionTextureAnimation,local4,local2,0.5,0.5);
      battleService.addGraphicEffect(local3);
    }

    private function getObject(param1:Class) : Object {
      return battleService.getObjectPool().getObject(param1);
    }

    private function createExplosionLightEffect(param1:Vector3) : void {
      var local2:AnimatedLightEffect = AnimatedLightEffect(this.getObject(AnimatedLightEffect));
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(this.getObject(StaticObject3DPositionProvider));
      local3.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
      local2.init(local3,this.sfxData.primaryExplosionLightAnimation);
      battleService.addGraphicEffect(local2);
    }

    private function playFlightSound() : void {
      this.shellSound = MobileSound3DEffect(this.getObject(MobileSound3DEffect));
      this.shellSound.init(Sound3D.create(this.sfxData.shellFlightSound),this.view);
      battleService.addSound3DEffect(this.shellSound);
    }

    private function playHitSound() : void {
      var local1:MobileSound3DEffect = MobileSound3DEffect(this.getObject(MobileSound3DEffect));
      local1.init(Sound3D.create(this.sfxData.primaryHitSound),this.view);
      battleService.addSound3DEffect(local1);
    }

    private function createHitMark(param1:Vector3) : void {
      battleService.getBattleScene3D().addDecal(param1,this.gunParams.barrelOrigin,HIT_MARK_RADIUS,this.sfxData.primaryHitMarkerMaterial,RotationState.USE_RANDOM_ROTATION);
    }
  }
}
