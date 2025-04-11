package alternativa.tanks.models.weapon.shotgun.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.WeaponPlatform;
  import alternativa.tanks.battle.scene3d.RotationState;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.engine3d.AnimatedSprite3D;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.RayCollisionFilter;
  import alternativa.tanks.models.weapon.shotgun.PelletDirectionCalculator;
  import alternativa.tanks.models.weapon.shotgun.ShotgunObject;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.physics.TanksCollisionDetector;
  import alternativa.tanks.sfx.AnimatedPlane;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;

  public class ShotgunShotEffect extends PooledObject implements GraphicEffect {
    [Inject]
    public static var battleService:BattleService;

    private static const DECAL_RADIUS:Number = 16;
    private static const FIRE_SIZE:Number = 270;
    private static const SMOKE_RESP_DISTANCE:Number = 100;
    private static const SMOKE_LIFE_TIME:Number = 1.3;
    private static const SMOKE_MOVE_DISTANCE:Number = 400;
    private static const SMOKE_LIFT_DISTANCE:Number = 150;
    private static const SMOKE_SCALE:Number = 2.5;
    private static const SMOKE_SIZE:Number = 200;
    private static const SMOKE_DELAY_TIME:Number = 0.08;
    private static const PELLET_LIFE_TIME:Number = 0.3;
    private static const SHIFT_RICOCHET_TIME:Number = 0.05;
    private static const MAX_DISTANCE:Number = 5000;
    private static const SPARKLE_MIN_SIZE:Number = 6;
    private static const SPARKLE_LIFE_TIME:Number = 0.2;
    private static const SPARKLE_SCALE:Number = 30;
    private static const rayHit:RayHit = new RayHit();
    private static const collisionFilter:RayCollisionFilter = new RayCollisionFilter();
    private static const originAlong:Vector3 = new Vector3();
    private static const pelletOrigin:Vector3 = new Vector3();
    private static const pelletRicochetOrigin:Vector3 = new Vector3();
    private static const pelletDirection:Vector3 = new Vector3();

    private var fireAlong:AnimatedPlane = new AnimatedPlane(FIRE_SIZE,FIRE_SIZE,0,FIRE_SIZE / 2,0);
    private var fireAcross:AnimatedPlane = new AnimatedPlane(FIRE_SIZE,FIRE_SIZE,0,0,0);
    private var smoke:AnimatedSprite3D = new AnimatedSprite3D(SMOKE_SIZE,SMOKE_SIZE);
    private var pellets:Vector.<PelletTrail> = new Vector.<PelletTrail>();
    private var ricochetPellets:Vector.<PelletTrail> = new Vector.<PelletTrail>();
    private var sparkles:Vector.<Sprite3D> = new Vector.<Sprite3D>();
    private var muzzlePosition:Vector3 = new Vector3();
    private var muzzleDirection:Vector3 = new Vector3();
    private var time:Number = 0;
    private var container:Scene3DContainer;
    private var shotgunSFX:ShotgunSFXData;
    private var maxSmokeDistance:Number;
    private var buffed:Boolean = false;

    public function ShotgunShotEffect(param1:Pool) {
      super(param1);
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.fireAlong);
      param1.addChild(this.fireAcross);
      param1.addChild(this.smoke);
      var local2:int = 0;
      while(local2 < this.pellets.length) {
        param1.addChild(this.pellets[local2]);
        local2++;
      }
      var local3:int = 0;
      while(local3 < this.sparkles.length) {
        param1.addChild(this.sparkles[local3]);
        local3++;
      }
      var local4:int = 0;
      while(local4 < this.ricochetPellets.length) {
        param1.addChild(this.ricochetPellets[local4]);
        local4++;
      }
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(this.allNotHaveParent()) {
        return false;
      }
      var local3:Number = param1 / 1000;
      this.playFire(param2);
      this.playPelletTrail(param2,this.pellets);
      this.playSmoke(local3);
      this.playSparkle();
      if(this.time >= SHIFT_RICOCHET_TIME) {
        this.playRicochetPelletTrail(param2,this.ricochetPellets);
      }
      this.time += local3;
      this.checkForRemoveChildren();
      return true;
    }

    private function allNotHaveParent() : Boolean {
      return this.fireAlong.parent == null && this.fireAcross.parent == null && this.smoke.parent == null && this.pellets[0].parent == null && this.sparkles[0].parent == null && this.ricochetPellets[0].parent == null;
    }

    private function playFire(param1:GameCamera) : void {
      var local3:Number = NaN;
      SFXUtils.calculateAlphaForObject(this.fireAlong,param1.position,this.muzzleDirection,false,8,0.9);
      SFXUtils.calculateAlphaForObject(this.fireAcross,param1.position,this.muzzleDirection,true,4,0.3);
      this.fireAlong.setTime(this.time);
      var local2:int = this.time * this.shotgunSFX.shotAlongAnimation.fps;
      if(local2 == 5) {
        local3 = FIRE_SIZE * 0.35;
        originAlong.copy(this.muzzlePosition).addScaled(local3,this.muzzleDirection);
      } else if(local2 >= 6) {
        local3 = FIRE_SIZE * 0.5;
        originAlong.copy(this.muzzlePosition).addScaled(local3,this.muzzleDirection);
      } else {
        originAlong.copy(this.muzzlePosition);
      }
      SFXUtils.alignObjectPlaneToView(this.fireAlong,originAlong,this.muzzleDirection,param1.position);
      this.fireAcross.setTime(this.time);
      local2 = this.time * this.shotgunSFX.shotAcrossAnimation.fps;
      local3 = 0.1 * FIRE_SIZE + local2 * 0.1 * FIRE_SIZE;
      this.fireAcross.x = this.muzzlePosition.x + this.muzzleDirection.x * local3;
      this.fireAcross.y = this.muzzlePosition.y + this.muzzleDirection.y * local3;
      this.fireAcross.z = this.muzzlePosition.z + this.muzzleDirection.z * local3;
    }

    private function playPelletTrail(param1:GameCamera, param2:Vector.<PelletTrail>) : void {
      var local4:PelletTrail = null;
      var local3:Number = this.time / PELLET_LIFE_TIME;
      for each(local4 in param2) {
        this.playPellet(local4,local3,param1);
      }
    }

    private function playPellet(param1:PelletTrail, param2:Number, param3:GameCamera) : Number {
      var local4:Number = param1.distance * param2;
      pelletOrigin.copy(param1.position).addScaled(local4,param1.direction);
      param1.alpha = 1 - 2 * Math.abs(0.5 - param2);
      SFXUtils.alignObjectPlaneToView(param1,pelletOrigin,param1.direction,param3.position);
      param1.visible = true;
      return local4;
    }

    private function playRicochetPelletTrail(param1:GameCamera, param2:Vector.<PelletTrail>) : void {
      var local4:PelletTrail = null;
      var local3:Number = (this.time - SHIFT_RICOCHET_TIME) / PELLET_LIFE_TIME;
      for each(local4 in param2) {
        if(!local4.isRicochet) {
          return;
        }
        this.playPellet(local4,local3,param1);
      }
    }

    private function playSmoke(param1:Number) : void {
      var local2:int = 0;
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      if(this.time > SMOKE_DELAY_TIME) {
        this.smoke.visible = true;
        local2 = this.time * this.smoke.getFps();
        this.smoke.setFrameIndex(local2);
        local3 = this.time - SMOKE_DELAY_TIME;
        local4 = Math.sqrt(local3 / SMOKE_LIFE_TIME);
        if(this.maxSmokeDistance > SMOKE_RESP_DISTANCE) {
          local7 = Math.min(this.maxSmokeDistance - SMOKE_RESP_DISTANCE,SMOKE_MOVE_DISTANCE);
          local5 = SMOKE_RESP_DISTANCE + local7 * local4;
        } else {
          local5 = 0;
          this.smoke.visible = false;
        }
        this.smoke.x = this.muzzlePosition.x + this.muzzleDirection.x * local5;
        this.smoke.y = this.muzzlePosition.y + this.muzzleDirection.y * local5;
        this.smoke.z = this.muzzlePosition.z + this.muzzleDirection.z * local5 + SMOKE_LIFT_DISTANCE * local4;
        local6 = 1 + (SMOKE_SCALE - 1) * local4;
        this.smoke.scaleX = local6;
        this.smoke.scaleY = local6;
        this.smoke.scaleZ = local6;
        this.smoke.alpha = Math.sin(local3 * Math.PI / SMOKE_LIFE_TIME) * (this.buffed ? 0.5 : 1);
        this.smoke.rotation -= 0.3 * param1;
      } else {
        this.smoke.visible = false;
      }
    }

    private function playSparkle() : void {
      var local3:Sprite3D = null;
      var local1:Number = (this.time - SHIFT_RICOCHET_TIME) / SPARKLE_LIFE_TIME;
      local1 *= local1;
      var local2:Number = 1 + (SPARKLE_SCALE - 1) * local1;
      for each(local3 in this.sparkles) {
        local3.scaleX = local2;
        local3.scaleY = local2;
        local3.scaleZ = local2;
        local3.alpha = 1 - local1;
      }
    }

    private function checkForRemoveChildren() : void {
      var local1:PelletTrail = null;
      var local2:PelletTrail = null;
      var local3:Sprite3D = null;
      if(this.time > PELLET_LIFE_TIME) {
        for each(local1 in this.pellets) {
          this.container.removeChild(local1);
        }
      }
      if(this.time > PELLET_LIFE_TIME + SHIFT_RICOCHET_TIME) {
        for each(local2 in this.ricochetPellets) {
          if(local2.parent != null) {
            this.container.removeChild(local2);
          }
        }
      }
      if(this.time > this.fireAlong.getOneLoopTime()) {
        this.container.removeChild(this.fireAlong);
      }
      if(this.time > this.fireAcross.getOneLoopTime()) {
        this.container.removeChild(this.fireAcross);
      }
      if(this.time > SMOKE_DELAY_TIME + SMOKE_LIFE_TIME) {
        this.container.removeChild(this.smoke);
      }
      if(this.time > SPARKLE_LIFE_TIME) {
        for each(local3 in this.sparkles) {
          this.container.removeChild(local3);
        }
      }
    }

    public function destroy() : void {
      var local1:int = 0;
      while(local1 < this.pellets.length) {
        this.pellets[local1].clear();
        local1++;
      }
      var local2:int = 0;
      while(local2 < this.ricochetPellets.length) {
        this.ricochetPellets[local2].clear();
        this.ricochetPellets[local2].visible = false;
        local2++;
      }
      var local3:int = 0;
      while(local3 < this.sparkles.length) {
        this.sparkles[local3].material = null;
        local3++;
      }
      this.fireAcross.clear();
      this.fireAlong.clear();
      this.smoke.clear();
      recycle();
    }

    public function kill() : void {
      var local1:int = 0;
      while(local1 < this.pellets.length) {
        this.container.removeChild(this.pellets[local1]);
        this.container.removeChild(this.ricochetPellets[local1]);
        this.container.removeChild(this.sparkles[local1]);
        local1++;
      }
      this.container.removeChild(this.fireAlong);
      this.container.removeChild(this.fireAcross);
      this.container.removeChild(this.smoke);
    }

    public function init(param1:ShotgunObject, param2:AllGlobalGunParams, param3:WeaponPlatform, param4:Vector3, param5:ShotgunSFXData, param6:Boolean) : void {
      this.shotgunSFX = param5;
      this.buffed = param6;
      this.muzzlePosition.copy(param2.muzzlePosition);
      this.muzzleDirection.copy(param2.direction);
      this.initShotFire();
      this.initSmoke();
      this.initPelletEffectsAndCorrectMaxSmokeDistance(param1,param2,param4,param3.getBody());
      this.time = 0;
    }

    private function initShotFire() : void {
      this.fireAlong.blendMode = BlendMode.ADD;
      var local1:TextureAnimation = this.shotgunSFX.shotAlongAnimation;
      this.fireAlong.init(local1,local1.fps);
      this.fireAlong.shadowMapAlphaThreshold = 2;
      this.fireAlong.useShadowMap = false;
      this.fireAlong.depthMapAlphaThreshold = 2;
      this.fireAlong.useLight = false;
      var local2:TextureAnimation = this.shotgunSFX.shotAcrossAnimation;
      this.fireAcross.init(local2,local2.fps);
      this.fireAcross.blendMode = BlendMode.ADD;
      this.fireAcross.rotationX = Math.atan2(this.muzzleDirection.z,Math.sqrt(this.muzzleDirection.x * this.muzzleDirection.x + this.muzzleDirection.y * this.muzzleDirection.y)) - Math.PI / 2;
      this.fireAcross.rotationY = 0;
      this.fireAcross.rotationZ = -Math.atan2(this.muzzleDirection.x,this.muzzleDirection.y);
      this.fireAcross.shadowMapAlphaThreshold = 2;
      this.fireAcross.useShadowMap = false;
      this.fireAcross.depthMapAlphaThreshold = 2;
      this.fireAcross.useLight = false;
    }

    private function initSmoke() : void {
      this.smoke.setAnimationData(this.shotgunSFX.smokeAnimation);
      this.smoke.setFrameIndex(0);
      this.smoke.rotation = Math.random() * Math.PI * 2;
      this.smoke.shadowMapAlphaThreshold = 2;
      this.smoke.useShadowMap = false;
      this.smoke.depthMapAlphaThreshold = 2;
      this.smoke.useLight = false;
      this.smoke.softAttenuation = 130;
      this.maxSmokeDistance = MAX_DISTANCE;
    }

    private function initPelletEffectsAndCorrectMaxSmokeDistance(param1:ShotgunObject, param2:AllGlobalGunParams, param3:Vector3, param4:Body) : void {
      var local10:Vector3 = null;
      var local5:Vector.<Vector3> = this.getPelletDirections(param1,param2,param3);
      var local6:TanksCollisionDetector = battleService.getBattleRunner().getCollisionDetector();
      collisionFilter.exclusion = param4;
      var local7:DistanceWeakening = param1.distanceWeakening();
      var local8:Number = local7.getDistance();
      while(this.pellets.length < local5.length) {
        this.addNewPelletAndSparkle();
      }
      var local9:int = 0;
      while(local9 < local5.length) {
        local10 = local5[local9];
        this.initPelletTrailAndSparkleEffectsAndCorrectMaxSmokeDistance(local9,local6,local10,param2.barrelOrigin,local8);
        local9++;
      }
    }

    private function getPelletDirections(param1:ShotgunObject, param2:AllGlobalGunParams, param3:Vector3) : Vector.<Vector3> {
      var local4:PelletDirectionCalculator = param1.pelletDirectionCalculator();
      local4.next();
      return local4.getDirectionsFor(param2.elevationAxis,param3);
    }

    private function addNewPelletAndSparkle() : void {
      this.pellets.push(this.createPelletTrail());
      this.ricochetPellets.push(this.createPelletTrail());
      var local1:Sprite3D = new Sprite3D(0,0);
      local1.blendMode = BlendMode.ADD;
      local1.shadowMapAlphaThreshold = 2;
      local1.useShadowMap = false;
      local1.depthMapAlphaThreshold = 2;
      local1.useLight = false;
      this.sparkles.push(local1);
    }

    private function createPelletTrail() : PelletTrail {
      var local1:PelletTrail = new PelletTrail();
      local1.blendMode = BlendMode.ADD;
      local1.shadowMapAlphaThreshold = 2;
      local1.useShadowMap = false;
      local1.depthMapAlphaThreshold = 2;
      local1.useLight = false;
      return local1;
    }

    private function initPelletTrailAndSparkleEffectsAndCorrectMaxSmokeDistance(param1:int, param2:TanksCollisionDetector, param3:Vector3, param4:Vector3, param5:Number) : void {
      var local9:Boolean = false;
      var local10:Sprite3D = null;
      var local6:Boolean = param2.raycast(param4,param3,CollisionGroup.WEAPON,param5,collisionFilter,rayHit);
      var local7:Number = MAX_DISTANCE;
      var local8:PelletTrail = this.pellets[param1];
      local8.position.copy(this.muzzlePosition);
      if(local6) {
        local9 = BattleUtils.isTankBody(rayHit.shape.body);
        local8.direction.diff(rayHit.position,this.muzzlePosition);
        local7 = this.getMaxPelletDistancesAndCorrectMaxSmokeDistance(param4,local7,local8,local9);
        local8.direction.normalize();
        local10 = this.sparkles[param1];
        this.initSparkle(local10,rayHit.position,param3);
        if(!local9) {
          this.initPelletTrailAndSparkleEffectsRicochet(param1,param3,local10,param2);
        }
      } else {
        local8.direction.copy(param3);
      }
      this.initPelletTrail(local8,local7);
    }

    private function initPelletTrailAndSparkleEffectsRicochet(param1:int, param2:Vector3, param3:Sprite3D, param4:TanksCollisionDetector) : void {
      var local8:Boolean = false;
      pelletRicochetOrigin.copy(rayHit.position);
      pelletDirection.copy(rayHit.normal);
      pelletDirection.scale(-2 * rayHit.normal.dot(param2)).add(param2);
      pelletRicochetOrigin.addScaled(0.1,pelletDirection);
      var local5:Number = MAX_DISTANCE;
      var local6:Boolean = param4.raycast(pelletRicochetOrigin,pelletDirection,CollisionGroup.WEAPON,local5,null,rayHit);
      var local7:PelletTrail = this.ricochetPellets[param1];
      local7.isRicochet = true;
      local7.position.copy(pelletRicochetOrigin);
      if(local6) {
        local7.direction.diff(rayHit.position,pelletRicochetOrigin);
        local8 = BattleUtils.isTankBody(rayHit.shape.body);
        local5 = this.getMaxPelletRicochetDistances(pelletRicochetOrigin,local7,local8);
        local7.direction.normalize();
        if(!local8) {
          this.showMark(pelletRicochetOrigin,rayHit.position);
        } else {
          this.initSparkle(param3,rayHit.position,pelletDirection);
        }
      } else {
        local7.direction.copy(pelletDirection);
      }
      this.initPelletTrail(local7,local5);
    }

    private function getMaxPelletDistancesAndCorrectMaxSmokeDistance(param1:Vector3, param2:Number, param3:PelletTrail, param4:Boolean) : Number {
      var local5:Number = param1.distanceTo(rayHit.position);
      var local6:Number = param1.distanceTo(this.muzzlePosition);
      if(local5 > local6) {
        param2 = param3.direction.length();
      } else {
        param2 = 0;
      }
      if(!param4) {
        this.maxSmokeDistance = Math.min(param2,this.maxSmokeDistance);
      }
      return param2;
    }

    private function getMaxPelletRicochetDistances(param1:Vector3, param2:PelletTrail, param3:Boolean) : Number {
      if(!param3) {
        return param2.direction.length();
      }
      return param1.distanceTo(rayHit.position);
    }

    private function initPelletTrail(param1:PelletTrail, param2:Number) : void {
      var local3:Number = 3 + Math.random() * 8;
      var local4:Number = 0.3 + Math.random() * 0.3;
      var local5:Number = Math.min(Math.random() * 200,param2);
      var local6:Number = Math.min(400 + Math.random() * 2100,param2);
      var local7:Number = 300 + Math.random() * 500;
      if(local7 + local6 > param2) {
        local7 = Math.max(0,param2 - local6);
      }
      param1.init(local3,local4,local5,local6,local7,this.shotgunSFX.pelletTrailMaterial);
    }

    private function initSparkle(param1:Sprite3D, param2:Vector3, param3:Vector3) : void {
      var local4:Number = SPARKLE_MIN_SIZE + Math.random() * SPARKLE_MIN_SIZE;
      var local5:Number = local4 / 2;
      param1.width = local4;
      param1.height = local4;
      param1.material = this.shotgunSFX.sparkleMaterial;
      param1.x = param2.x - local5 * param3.x;
      param1.y = param2.y - local5 * param3.y;
      param1.z = param2.z - local5 * param3.z;
      param1.rotation = Math.random() * Math.PI * 2;
      param1.visible = true;
    }

    private function showMark(param1:Vector3, param2:Vector3) : void {
      var local3:Vector.<TextureMaterial> = this.shotgunSFX.explosionMarkMaterials;
      var local4:int = Math.floor(Math.random() * local3.length);
      battleService.getBattleScene3D().addDecal(param2,param1,DECAL_RADIUS,local3[local4],RotationState.WITHOUT_ROTATION);
    }
  }
}
