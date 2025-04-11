package alternativa.tanks.models.weapon.healing {
  import alternativa.engine3d.core.Object3D;
  import alternativa.math.Matrix4;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.engine3d.AnimatedSprite3D;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.SFXUtils;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.healing.IsisState;

  public class HealingGunGraphicEffect extends PooledObject implements GraphicEffect {
    private static const turretMatrix:Matrix4 = new Matrix4();
    private static const targetMatrix:Matrix4 = new Matrix4();
    private static const endPosition:Vector3 = new Vector3();
    private static const startPosition:Vector3 = new Vector3();
    private static const direction:Vector3 = new Vector3();
    private static const cameraPosition:Vector3 = new Vector3();
    private static const smoothStep:Number = 0.1;
    private static const smoothThresholdSqr:Number = 100;

    private var container:Scene3DContainer;
    private var shaftPlane:HealingGunShaft;
    private var buffedBeam:HealingGunBuffedBeam;
    private var muzzleSpark:AnimatedSprite3D;
    private var shaftEnd:AnimatedSprite3D;
    private var turret:Object3D;
    private var localSourcePosition:Vector3 = new Vector3();
    private var targetObject:Object3D;
    private var visibility:Number = 0;
    private var show:Boolean;
    private var dead:Boolean;
    private var time:int;
    private var mode:IsisState;
    private var sfxData:HealingGunSFXData;
    private var hitPoint:Vector3 = new Vector3();
    private var oldTargetPoint:Vector3 = new Vector3();
    private var targetPoint:Vector3 = new Vector3();
    private var smoothPos:Number;
    private var smoothActivated:Boolean;
    private var isLocal:Boolean;
    private var buffedMode:Boolean;

    public function HealingGunGraphicEffect(param1:Pool) {
      super(param1);
      this.shaftPlane = new HealingGunShaft();
      this.shaftPlane.init(HealingGunEffectsParams.SHAFT_WIDTH,100);
      this.buffedBeam = new HealingGunBuffedBeam();
      this.muzzleSpark = new AnimatedSprite3D(HealingGunEffectsParams.MUZZLE_SPARK_SIZE,HealingGunEffectsParams.MUZZLE_SPARK_SIZE);
      this.shaftEnd = new AnimatedSprite3D(HealingGunEffectsParams.END_SPARK_SIZE,HealingGunEffectsParams.END_SPARK_SIZE);
      this.shaftEnd.originY = 0.5;
      this.buffedMode = false;
    }

    public function initLocal(param1:HealingGunSFXData, param2:Object3D, param3:Vector3) : void {
      this.isLocal = true;
      this.init(param1,param2,param3);
    }

    public function initRemote(param1:HealingGunSFXData, param2:Object3D, param3:Vector3) : void {
      this.isLocal = false;
      this.init(param1,param2,param3);
    }

    public function setMode(param1:IsisState, param2:Object3D = null, param3:Vector3 = null) : void {
      var local4:Number = NaN;
      this.smoothActivated = false;
      if(param2 != null) {
        if(this.targetObject == param2) {
          if(this.isLocal && this.targetPoint != null) {
            this.oldTargetPoint.copy(this.targetPoint);
          } else {
            this.oldTargetPoint.copy(this.hitPoint);
          }
          local4 = this.oldTargetPoint.distanceToSquared(param3);
          if(local4 > smoothThresholdSqr) {
            this.smoothActivated = true;
            this.smoothPos = 0;
          }
        }
        this.hitPoint.copy(param3);
      }
      if(this.mode != param1 || this.targetObject != param2) {
        this.targetObject = param2;
        this.mode = param1;
        switch(param1) {
          case IsisState.IDLE:
            this.setupIdleMode();
            break;
          case IsisState.HEALING:
            this.setupHealMode();
            break;
          case IsisState.DAMAGING:
            this.setupDamageMode();
        }
        this.visibility = 0;
      }
    }

    public function play(param1:int, param2:GameCamera) : Boolean {
      if(this.show) {
        this.visibility += HealingGunEffectsParams.VISUALIZATION_SPEED * param1 / 1000;
        if(this.visibility > 1) {
          this.visibility = 1;
        }
      } else {
        this.visibility -= HealingGunEffectsParams.VISUALIZATION_SPEED * param1 / 1000;
        if(this.visibility <= 0) {
          if(this.dead) {
            return false;
          }
        }
      }
      this.updateVisibility();
      this.time += param1;
      var local3:int = this.updateMuzzleSpark();
      if(this.mode == IsisState.DAMAGING || this.mode == IsisState.HEALING) {
        this.updateTargetPoint();
        this.updateShaft(param2,param1,local3);
      }
      return true;
    }

    private function init(param1:HealingGunSFXData, param2:Object3D, param3:Vector3) : void {
      this.sfxData = param1;
      this.turret = param2;
      this.localSourcePosition.copy(param3);
      this.mode = IsisState.OFF;
      this.visibility = 0;
      this.show = true;
      this.dead = false;
      this.time = 0;
      this.updateVisibility();
    }

    private function updateTargetPoint() : void {
      if(this.targetPoint == null) {
        this.targetPoint = new Vector3();
      }
      if(this.smoothActivated) {
        this.smoothHitPoint();
      } else {
        this.targetPoint.copy(this.hitPoint);
      }
    }

    private function updateMuzzleSpark() : int {
      turretMatrix.setMatrix(this.turret.x,this.turret.y,this.turret.z,this.turret.rotationX,this.turret.rotationY,this.turret.rotationZ);
      turretMatrix.transformVector(this.localSourcePosition,startPosition);
      this.muzzleSpark.x = startPosition.x;
      this.muzzleSpark.y = startPosition.y;
      this.muzzleSpark.z = startPosition.z;
      var local1:int = this.muzzleSpark.getFps() * this.time / 1000;
      this.muzzleSpark.setFrameIndex(local1);
      return local1;
    }

    private function smoothHitPoint() : void {
      this.smoothPos += smoothStep;
      if(this.smoothPos >= 1) {
        this.smoothPos = 1;
        this.smoothActivated = false;
      }
      Vector3.interpolate(this.smoothPos,this.oldTargetPoint,this.hitPoint,this.targetPoint);
    }

    public function addedToScene(param1:Scene3DContainer) : void {
      this.container = param1;
    }

    public function destroy() : void {
      this.container.removeChild(this.shaftPlane);
      this.shaftPlane.setMaterialToAllFaces(null);
      this.container.removeChild(this.buffedBeam);
      this.buffedBeam.setMaterial(null,1);
      this.container.removeChild(this.shaftEnd);
      this.shaftEnd.clear();
      this.container.removeChild(this.muzzleSpark);
      this.muzzleSpark.clear();
      this.container = null;
      this.sfxData = null;
      this.turret = null;
      this.targetObject = null;
      this.targetPoint = null;
      recycle();
    }

    public function stop() : void {
      this.dead = true;
      this.show = false;
    }

    public function kill() : void {
      this.dead = true;
      this.show = false;
      this.visibility = 0;
    }

    private function updateShaft(param1:GameCamera, param2:int, param3:int) : void {
      var local4:Number = NaN;
      this.shaftEnd.setFrameIndex(param3);
      targetMatrix.setMatrix(this.targetObject.x,this.targetObject.y,this.targetObject.z,this.targetObject.rotationX,this.targetObject.rotationY,this.targetObject.rotationZ);
      targetMatrix.transformVector(this.targetPoint,endPosition);
      direction.diff(endPosition,startPosition);
      local4 = direction.length() - HealingGunEffectsParams.END_POSITION_OFFSET;
      if(local4 < 0) {
        local4 = 10;
      }
      direction.normalize();
      endPosition.x = startPosition.x + local4 * direction.x;
      endPosition.y = startPosition.y + local4 * direction.y;
      endPosition.z = startPosition.z + local4 * direction.z;
      this.shaftEnd.x = endPosition.x;
      this.shaftEnd.y = endPosition.y;
      this.shaftEnd.z = endPosition.z;
      cameraPosition.x = param1.x;
      cameraPosition.y = param1.y;
      cameraPosition.z = param1.z;
      if(this.buffedMode) {
        this.buffedBeam.update(param2,local4);
        SFXUtils.alignObjectPlaneToView(this.buffedBeam,startPosition,direction,cameraPosition);
      } else {
        this.shaftPlane.update(param2,local4);
        SFXUtils.alignObjectPlaneToView(this.shaftPlane,startPosition,direction,cameraPosition);
      }
    }

    private function updateVisibility() : void {
      this.shaftPlane.alpha = this.visibility;
      this.buffedBeam.alpha = this.visibility;
      this.muzzleSpark.alpha = this.visibility;
      this.shaftEnd.alpha = this.visibility;
      var local1:Number = HealingGunEffectsParams.MIN_SCALE + (1 - HealingGunEffectsParams.MIN_SCALE) * this.visibility;
      this.shaftPlane.scaleX = local1;
      this.buffedBeam.scaleX = local1;
      this.muzzleSpark.scaleX = local1;
      this.muzzleSpark.scaleY = local1;
      this.muzzleSpark.scaleZ = local1;
      this.shaftEnd.scaleX = local1;
      this.shaftEnd.scaleY = local1;
      this.shaftEnd.scaleZ = local1;
    }

    private function hide() : void {
      this.show = false;
    }

    private function setupIdleMode() : void {
      if(this.container != null) {
        this.container.removeChild(this.shaftPlane);
        this.container.removeChild(this.buffedBeam);
        this.container.removeChild(this.shaftEnd);
        this.container.addChild(this.muzzleSpark);
        this.muzzleSpark.setAnimationData(this.sfxData.idleMuzzle);
        this.muzzleSpark.setFrameIndex(0);
      }
    }

    private function setupHealMode() : void {
      if(this.container != null) {
        this.container.addChild(this.muzzleSpark);
        this.setupHealShaft();
        this.container.addChild(this.shaftEnd);
        this.muzzleSpark.setAnimationData(this.sfxData.healMuzzle);
        this.muzzleSpark.setFrameIndex(0);
        this.shaftEnd.setAnimationData(this.sfxData.healTarget);
        this.shaftEnd.setFrameIndex(0);
      }
    }

    private function setupDamageMode() : void {
      if(this.container != null) {
        this.container.addChild(this.muzzleSpark);
        this.setupDamageShaft();
        this.container.addChild(this.shaftEnd);
        this.muzzleSpark.setAnimationData(this.sfxData.damageMuzzle);
        this.muzzleSpark.setFrameIndex(0);
        this.shaftEnd.setAnimationData(this.sfxData.damageTarget);
        this.shaftEnd.setFrameIndex(0);
      }
    }

    private function setupDamageShaft() : void {
      if(this.buffedMode) {
        this.container.removeChild(this.shaftPlane);
        this.container.addChild(this.buffedBeam);
        this.buffedBeam.setMaterial(this.sfxData.getDamageShaft(),-1);
      } else {
        this.container.addChild(this.shaftPlane);
        this.container.removeChild(this.buffedBeam);
        this.shaftPlane.setMaterial(this.sfxData.getDamageShaft(),-1);
      }
    }

    private function setupHealShaft() : void {
      if(this.buffedMode) {
        this.container.removeChild(this.shaftPlane);
        this.container.addChild(this.buffedBeam);
        this.buffedBeam.setMaterial(this.sfxData.getHealShaft(),1);
      } else {
        this.container.addChild(this.shaftPlane);
        this.container.removeChild(this.buffedBeam);
        this.shaftPlane.setMaterial(this.sfxData.getHealShaft(),1);
      }
    }

    public function setBuffedMode(param1:Boolean) : void {
      if(param1 != this.buffedMode) {
        this.buffedMode = param1;
        switch(this.mode) {
          case IsisState.HEALING:
            this.setupHealShaft();
            break;
          case IsisState.DAMAGING:
            this.setupDamageShaft();
        }
      }
    }
  }
}
