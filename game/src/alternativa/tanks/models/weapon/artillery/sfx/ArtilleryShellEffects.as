package alternativa.tanks.models.weapon.artillery.sfx {
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Vector3;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.tank.LocalTankInfoService;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.artillery.ArtilleryShell;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.AnimatedSpriteEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import alternativa.tanks.sfx.StaticObject3DPositionProvider;
  import alternativa.tanks.utils.objectpool.ObjectPool;

  public class ArtilleryShellEffects {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var localTankService:LocalTankInfoService;

    private static const EXPLOSION_OFFSET_TO_CAMERA:Number = 110;
    private static const DECAL_RADIUS:Number = 550;

    public static const DISTANCE_FOR_TRAIL_SOUND:Number = 3000;

    protected static const _rayHit:RayHit = new RayHit();

    private const projectionOrigin:Vector3 = new Vector3();
    private const explosionDirection:Vector3 = new Vector3();
    private const explosionPosition:Vector3 = new Vector3();
    private const rayCastDirection:Vector3 = new Vector3();

    private var velocity:Vector3 = new Vector3();
    private var position:Vector3 = new Vector3();
    private var direction:Vector3 = new Vector3();
    private var prevPosition:Vector3 = new Vector3();
    private var prevDirection:Vector3 = new Vector3();
    private var sfxData:ArtillerySfxData;
    private var gravity:Number;
    private var trailEffect:ArtilleryTrailEffect;
    private var checkCollisions:Boolean = true;

    public function ArtilleryShellEffects(param1:Mesh, param2:ArtillerySfxData, param3:Vector3, param4:AllGlobalGunParams, param5:Vector3, param6:Number) {
      super();
      this.sfxData = param2;
      this.gravity = param6;
      this.velocity.copy(param3);
      this.position.copy(param4.muzzlePosition);
      this.direction.copy(param5);
      this.prevPosition.copy(param4.muzzlePosition);
      this.prevDirection.copy(param5);
      this.trailEffect = this.createTrailEffect(param1);
      this.checkDistance();
    }

    private function checkDistance() : void {
      var local1:int = 0;
      while(local1 < 24) {
        this.checkCollisions = this.updateShellPosition(true);
        if(!this.checkCollisions) {
          return;
        }
        local1++;
      }
    }

    public function updateShellPosition(param1:Boolean = false) : Boolean {
      if(!this.checkCollisions) {
        return false;
      }
      ArtilleryShell.moveShell(BattleRunner.PHYSICS_STEP_IN_S,this.position,this.prevPosition,this.direction,this.prevDirection,this.velocity,this.gravity);
      this.rayCastDirection.diff(this.position,this.prevPosition);
      var local2:Number = this.rayCastDirection.length();
      this.rayCastDirection.normalize();
      var local3:CollisionDetector = battleService.getBattleRunner().getCollisionDetector();
      if(local3.raycastStatic(this.prevPosition,this.rayCastDirection,CollisionGroup.STATIC,local2,null,_rayHit)) {
        if(!param1) {
          this.checkCollisions = false;
          this.createSoundForShell(_rayHit.position);
        }
        return false;
      }
      return true;
    }

    private function createTrailEffect(param1:Mesh) : ArtilleryTrailEffect {
      var local2:ArtilleryTrailEffect = ArtilleryTrailEffect(battleService.getObjectPool().getObject(ArtilleryTrailEffect));
      local2.init(param1,this.sfxData);
      return local2;
    }

    public function updateTrail(param1:Number) : void {
      this.trailEffect.update(param1);
    }

    public function destroy() : void {
      this.trailEffect.close();
      this.trailEffect = null;
    }

    public function createExplosionEffect(param1:Vector3, param2:Vector3) : void {
      this.createExplosionGraphicEffect(param1,param2);
      this.createExplosionLightEffect(param1);
      this.createExplosionSoundEffect(param1);
      this.createExplosionMark(param1,param2);
    }

    private function createExplosionGraphicEffect(param1:Vector3, param2:Vector3) : void {
      this.explosionPosition.sum(param1,this.explosionDirection.copy(param2).scale(-155));
      var local3:ObjectPool = battleService.getObjectPool();
      var local4:StaticObject3DPositionProvider = StaticObject3DPositionProvider(local3.getObject(StaticObject3DPositionProvider));
      local4.init(this.explosionPosition,EXPLOSION_OFFSET_TO_CAMERA);
      var local5:AnimatedSpriteEffect = AnimatedSpriteEffect(local3.getObject(AnimatedSpriteEffect));
      local5.init(1500,1500,this.sfxData.explosion,0,local4,0.5,0.75);
      battleService.addGraphicEffect(local5);
    }

    private function createExplosionLightEffect(param1:Vector3) : void {
      var local2:AnimatedLightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
      var local3:StaticObject3DPositionProvider = StaticObject3DPositionProvider(battleService.getObjectPool().getObject(StaticObject3DPositionProvider));
      local3.init(param1,EXPLOSION_OFFSET_TO_CAMERA);
      local2.init(local3,this.sfxData.hitLightAnimation);
      battleService.addGraphicEffect(local2);
    }

    private function createExplosionSoundEffect(param1:Vector3) : void {
      var local2:Sound3D = Sound3D.create(this.sfxData.explosionSound,0.8);
      battleService.addSound3DEffect(Sound3DEffect.create(param1,local2));
    }

    private function createExplosionMark(param1:Vector3, param2:Vector3) : void {
      this.projectionOrigin.copy(param1).subtract(param2);
      battleService.getBattleScene3D().addDecal(param1,this.projectionOrigin,DECAL_RADIUS,this.sfxData.explosionMarkMaterial);
    }

    private function createSoundForShell(param1:Vector3) : void {
      if(this.shouldPlaySound(param1)) {
        this.createTrailSoundEffect(param1);
      }
    }

    public function createTrailSoundEffect(param1:Vector3) : void {
      var local2:Sound3D = Sound3D.create(this.sfxData.flyBySound,0.8);
      battleService.addSound3DEffect(Sound3DEffect.create(param1,local2));
    }

    private function shouldPlaySound(param1:Vector3) : Boolean {
      return Boolean(localTankService.isLocalTankLoaded()) && this.soundIsNearPlayer(param1);
    }

    private function soundIsNearPlayer(param1:Vector3) : Boolean {
      return Vector3.distanceBetween(param1,localTankService.getLocalTank().getBody().state.position) <= DISTANCE_FOR_TRAIL_SOUND;
    }
  }
}
