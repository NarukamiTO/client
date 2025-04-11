package alternativa.tanks.models.weapon.streamweapon {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Matrix3;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.sfx.colortransform.ColorTransformEntry;
  import alternativa.tanks.models.weapon.shared.StreamWeaponParticle;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.geom.ColorTransform;
  import flash.utils.getTimer;

  public class StreamWeaponGraphicEffect extends PooledObject implements GraphicEffect {
    private static const thousand:EncryptedInt = new EncryptedIntImpl(1000);
    private static const MAX_PARTICLES_PER_DISTANCE_METER:Number = 1.1;
    private static const ABSOLUTE_MAX_PARTICLES:int = 50;
    private static const ADDITIONAL_PARTICLE_CHANCE:Number = 0.8;
    private static const ADDITIONAL_PARTICLE_MIN_FACTOR:Number = 0.6;
    private static const BUFFED_MODE_PARTICLE_SCALE:Number = 2;
    private static const PARTICLE_ROTATON_SPEED:Number = 3;
    private static const matrix:Matrix3 = new Matrix3();
    private static const turretMatrix:Matrix4 = new Matrix4();
    private static const barrelOrigin:Vector3 = new Vector3();
    private static const direction:Vector3 = new Vector3();
    private static const turretAxisX:Vector3 = new Vector3();
    private static const particlePosition:Vector3 = new Vector3();
    private static const globalMuzzlePosition:Vector3 = new Vector3();
    private static const intersection:RayHit = new RayHit();

    private var _range:Number;
    private var coneHalfAngleTan:Number;
    private var particleSpeedPerDistanceMeter:Number;
    private var particleSpeed:Number;
    private var localMuzzlePosition:Vector3 = new Vector3();
    private var turret:Object3D;
    private var sfxData:StreamWeaponSFXData;
    private var collisionDetector:CollisionDetector;
    private var _particles:Vector.<StreamWeaponParticle> = new Vector.<StreamWeaponParticle>(ABSOLUTE_MAX_PARTICLES);
    private var particleSizePerDistance:Number;
    private var particleEmissionPeriod:Number;
    private var time:int;
    private var nextEmissionTime:int;
    private var _numParticles:int;
    private var container:Scene3DContainer;
    private var dead:Boolean;
    private var muzzlePlane:StreamWeaponMuzzlePlane;
    private var shooterBody:Body;
    private var particleStartSize:Number;
    private var particleEndSize:Number;
    private var particleMuzzleOffset:Number;
    private var particleMuzzleRandomOffset:Number;
    private var attenuationStartDistance:Number;
    private var buffedMode:Boolean;
    private var maxParticles:int;

    public function StreamWeaponGraphicEffect(param1:Pool) {
      super(param1);
      this.muzzlePlane = new StreamWeaponMuzzlePlane();
    }

    public function init(param1:Body, param2:Number, param3:Number, param4:Number, param5:Vector3, param6:Object3D, param7:StreamWeaponSFXData, param8:CollisionDetector, param9:Number, param10:Number, param11:Number, param12:Number, param13:Number, param14:Number, param15:Boolean) : void {
      this.shooterBody = param1;
      this.coneHalfAngleTan = Math.tan(0.5 * param3);
      this.particleSpeedPerDistanceMeter = param4;
      this.localMuzzlePosition.copy(param5);
      this.turret = param6;
      this.sfxData = param7;
      this.collisionDetector = param8;
      this.particleStartSize = param11;
      this.particleEndSize = param12;
      this.particleMuzzleOffset = param13;
      this.particleMuzzleRandomOffset = param14;
      this.muzzlePlane.resize(param9,param10);
      this.updateRangeParams(param2);
      this._numParticles = 0;
      this.time = this.nextEmissionTime = getTimer();
      this.buffedMode = param15;
      this.initMuzzlePlane(param7);
      this.dead = false;
    }

    private function updateRangeParams(param1:Number) : void {
      this._range = param1;
      this.maxParticles = Math.floor(MAX_PARTICLES_PER_DISTANCE_METER * this._range * 0.01);
      if(this.maxParticles > ABSOLUTE_MAX_PARTICLES) {
        this.maxParticles = ABSOLUTE_MAX_PARTICLES;
      }
      this.particleSpeed = this.particleSpeedPerDistanceMeter * param1 * 0.01;
      this.attenuationStartDistance = param1 * 0.8;
      this.particleSizePerDistance = 2 * (this.particleEndSize - this.particleStartSize) / param1;
      this.particleEmissionPeriod = 1000 * param1 / (this.maxParticles * this.particleSpeed);
    }

    private function initMuzzlePlane(param1:StreamWeaponSFXData) : void {
      var local2:ColorTransformEntry = null;
      var local3:ColorTransform = null;
      this.muzzlePlane.init(param1.getMuzzlePlaneAnimation(this.buffedMode));
      if(param1.muzzlePlaneColorTransformPoints != null) {
        local2 = param1.muzzlePlaneColorTransformPoints[0];
        local3 = this.muzzlePlane.colorTransform == null ? new ColorTransform() : this.muzzlePlane.colorTransform;
        local3.alphaMultiplier = local2.alphaMultiplier;
        local3.alphaOffset = local2.alphaOffset;
        local3.redMultiplier = local2.redMultiplier;
        local3.redOffset = local2.redOffset;
        local3.greenMultiplier = local2.greenMultiplier;
        local3.greenOffset = local2.greenOffset;
        local3.blueMultiplier = local2.blueMultiplier;
        local3.blueOffset = local2.blueOffset;
        this.muzzlePlane.colorTransform = local3;
      } else {
        this.muzzlePlane.colorTransform = null;
      }
    }

    public function destroy() : void {
      while(this._numParticles > 0) {
        this.removeParticle(0);
      }
      this.container.removeChild(this.muzzlePlane);
      this.muzzlePlane.clear();
      this.container = null;
      this.shooterBody = null;
      this.turret = null;
      this.sfxData = null;
      this.collisionDetector = null;
      recycle();
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      var local3:Number = NaN;
      var local5:StreamWeaponParticle = null;
      var local6:Vector3 = null;
      var local7:Number = NaN;
      this.calculateParameters();
      local3 = param1 / thousand.getInt();
      if(this.collisionDetector.raycastStatic(barrelOrigin,direction,CollisionGroup.STATIC,this.localMuzzlePosition.y + this.muzzlePlane.length,null,intersection)) {
        this.muzzlePlane.visible = false;
      } else {
        this.muzzlePlane.visible = true;
        this.muzzlePlane.update(local3,this.sfxData.getMuzzlePlaneAnimation(this.buffedMode).fps);
        SFXUtils.alignObjectPlaneToView(this.muzzlePlane,globalMuzzlePosition,direction,param2.position);
      }
      if(!this.dead && this._numParticles < this.maxParticles && this.time >= this.nextEmissionTime) {
        this.nextEmissionTime += this.particleEmissionPeriod;
        this.addParticle();
      }
      var local4:int = 0;
      while(local4 < this._numParticles) {
        local5 = this._particles[local4];
        particlePosition.x = local5.x;
        particlePosition.y = local5.y;
        particlePosition.z = local5.z;
        if(local5.particleDistance > this._range || Boolean(this.collisionDetector.raycastStatic(particlePosition,local5.velocity,CollisionGroup.WEAPON,local3,null,intersection))) {
          this.removeParticle(local4--);
        } else {
          local6 = local5.velocity;
          local5.x += local6.x * local3;
          local5.y += local6.y * local3;
          local5.z += local6.z * local3;
          local5.particleDistance += this.particleSpeed * local3;
          local5.rotation += PARTICLE_ROTATON_SPEED * local3 * local5.rotationDirection;
          local5.setFrameIndex(local5.currFrame);
          local5.currFrame += this.sfxData.getParticleAnimation(this.buffedMode).fps * local3;
          local7 = this.particleStartSize + this.particleSizePerDistance * local5.particleDistance;
          if(local7 > this.particleEndSize) {
            local7 = this.particleEndSize;
          }
          local5.width = local7;
          local5.height = local7;
          if(local5.particleDistance > this.attenuationStartDistance) {
            local5.alpha = (this._range - local5.particleDistance) / (this._range - this.attenuationStartDistance);
          }
        }
        local4++;
      }
      this.time += param1;
      return !this.dead || this._numParticles > 0;
    }

    public function kill() : void {
      if(!this.dead) {
        this.dead = true;
        this.container.removeChild(this.muzzlePlane);
      }
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
      param1.addChild(this.muzzlePlane);
    }

    private function calculateParameters() : void {
      turretMatrix.setMatrix(this.turret.x,this.turret.y,this.turret.z,this.turret.rotationX,this.turret.rotationY,this.turret.rotationZ);
      turretAxisX.x = turretMatrix.m00;
      turretAxisX.y = turretMatrix.m10;
      turretAxisX.z = turretMatrix.m20;
      direction.x = turretMatrix.m01;
      direction.y = turretMatrix.m11;
      direction.z = turretMatrix.m21;
      turretMatrix.transformVector(this.localMuzzlePosition,globalMuzzlePosition);
      var local1:Number = this.localMuzzlePosition.y;
      barrelOrigin.x = globalMuzzlePosition.x - local1 * direction.x;
      barrelOrigin.y = globalMuzzlePosition.y - local1 * direction.y;
      barrelOrigin.z = globalMuzzlePosition.z - local1 * direction.z;
    }

    private function addParticle() : void {
      var local1:Number = NaN;
      var local3:StreamWeaponParticle = null;
      var local4:Number = NaN;
      local1 = this.particleMuzzleOffset + Math.random() * this.particleMuzzleRandomOffset;
      if(!this.muzzlePlane.visible && intersection.t < this.localMuzzlePosition.y + local1) {
        return;
      }
      var local2:Number = Math.random();
      this.getParticleFlightDirection(direction,local2);
      if(this.buffedMode && Math.random() < ADDITIONAL_PARTICLE_CHANCE && local2 > ADDITIONAL_PARTICLE_MIN_FACTOR) {
        local3 = StreamWeaponParticle.getParticle(false);
        local3.material = this.sfxData.getAdditionalElementTexture();
        local3.scaleX = 1;
        local3.scaleY = 1;
        local3.scaleZ = 1;
      } else {
        local3 = StreamWeaponParticle.getParticle(true);
        local3.setAnimationData(this.sfxData.getParticleAnimation(this.buffedMode));
        local4 = this.buffedMode ? BUFFED_MODE_PARTICLE_SCALE : 1;
        local3.scaleX = local4;
        local3.scaleY = local4;
        local3.scaleZ = local4;
      }
      local3.rotation = Math.random() * Math.PI * 2;
      local3.currFrame = Math.random() * local3.getNumFrames();
      local3.velocity.x = this.particleSpeed * direction.x;
      local3.velocity.y = this.particleSpeed * direction.y;
      local3.velocity.z = this.particleSpeed * direction.z;
      local3.velocity.add(this.shooterBody.state.velocity);
      local3.particleDistance = local1;
      local3.x = globalMuzzlePosition.x + local1 * direction.x;
      local3.y = globalMuzzlePosition.y + local1 * direction.y;
      local3.z = globalMuzzlePosition.z + local1 * direction.z;
      local3.rotationDirection = Math.random() < 0.5 ? 1 : -1;
      var local5:* = this._numParticles++;
      this._particles[local5] = local3;
      this.container.addChild(local3);
    }

    private function removeParticle(param1:int) : void {
      var local2:StreamWeaponParticle = this._particles[param1];
      this._particles[param1] = this._particles[--this._numParticles];
      this._particles[this._numParticles] = null;
      this.container.removeChild(local2);
      local2.dispose();
    }

    private function getParticleFlightDirection(param1:Vector3, param2:Number) : void {
      var local3:Number = 2 * Math.PI * Math.random();
      matrix.fromAxisAngle(param1,local3);
      turretAxisX.transform3(matrix);
      var local4:Number = this._range * this.coneHalfAngleTan * param2;
      param1.x = param1.x * this._range + turretAxisX.x * local4;
      param1.y = param1.y * this._range + turretAxisX.y * local4;
      param1.z = param1.z * this._range + turretAxisX.z * local4;
      param1.normalize();
    }

    public function get particles() : Vector.<StreamWeaponParticle> {
      return this._particles;
    }

    public function get numParticles() : int {
      return this._numParticles;
    }

    public function get range() : Number {
      return this._range;
    }

    public function updateRange(param1:Number) : void {
      this.updateRangeParams(param1);
    }

    public function setBuffedMode(param1:Boolean) : void {
      this.buffedMode = param1;
      this.muzzlePlane.init(this.sfxData.getMuzzlePlaneAnimation(this.buffedMode));
    }
  }
}
