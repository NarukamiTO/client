package alternativa.tanks.models.weapon.rocketlauncher {
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.loaders.Parser3DS;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapon.rocketlauncher.radio.RocketExplodeEvent;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketFlightEffect;
  import alternativa.tanks.models.weapon.rocketlauncher.sfx.RocketLauncherEffects;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.RocketTargetPoint;
  import alternativa.tanks.models.weapon.splash.Splash;
  import alternativa.tanks.models.weapons.shell.InelasticShell;
  import alternativa.tanks.models.weapons.shell.ShellWeaponCommunication;
  import alternativa.tanks.utils.objectpool.Pool;
  import projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.RocketLauncherCC;

  public class Rocket extends InelasticShell {
    private static var baseRocketMesh:Mesh;

    private static const COS_ALMOST_ZERO_ANGLE:Number = 0.999;
    private static const POSITION_ACCURACY:Number = 0.1;
    private static const rocket3dsClass:Class = Rocket_rocket3dsClass;
    private static const _cross:Vector3 = new Vector3();
    private static const _toTarget:Vector3 = new Vector3();

    private var time:Number;
    private var impactForce:Number;
    private var barrelIndex:int;
    private var shellWeaponCommunication:ShellWeaponCommunication;
    private var splash:Splash;
    private var targetTank:Tank;
    private var targetLocalPoint:Vector3;
    private var rocketMesh:Mesh;
    private var weaponObject:RocketLauncherObject;
    private var rocketLauncherParams:RocketLauncherCC;
    private var effects:RocketLauncherEffects;
    private var flightEffect:RocketFlightEffect;
    private var explodeEvent:String;

    public function Rocket(param1:Pool) {
      var local2:Parser3DS = null;
      this.targetLocalPoint = new Vector3();
      super(param1);
      if(baseRocketMesh == null) {
        local2 = new Parser3DS();
        local2.parse(new rocket3dsClass());
        baseRocketMesh = Mesh(local2.objects[0]);
        baseRocketMesh.optimizeForDynamicBSP();
        baseRocketMesh.sorting = Sorting.DYNAMIC_BSP;
        baseRocketMesh.weldVertices(0.1,0.01);
        baseRocketMesh.weldFaces(0.001,0.01,0.001);
        baseRocketMesh.calculateFacesNormals();
        baseRocketMesh.calculateVerticesNormalsBySmoothingGroups(0.1);
        baseRocketMesh.calculateBounds();
        baseRocketMesh.shadowMapAlphaThreshold = 2;
        baseRocketMesh.depthMapAlphaThreshold = 2;
      }
      this.rocketMesh = Mesh(baseRocketMesh.clone());
    }

    public function init(param1:RocketLauncherCC, param2:RocketLauncherObject, param3:RocketTargetPoint, param4:int, param5:RocketLauncherEffects, param6:String = "") : void {
      this.explodeEvent = param6;
      param2.addEventListener(param6,this.explode);
      this.rocketLauncherParams = param1;
      this.weaponObject = param2;
      this.effects = param5;
      var local7:WeaponCommonData = param2.commonData();
      this.impactForce = local7.getImpactForce();
      this.splash = param2.splash();
      this.shellWeaponCommunication = param2.shellCommunication();
      this.barrelIndex = param4;
      this.rocketMesh.setMaterialToAllFaces(param2.getSfxData().rocketTexture);
      if(param3.hasTarget()) {
        this.targetTank = param3.getTank();
        this.targetLocalPoint.copy(param3.getLocalPoint());
      } else {
        this.targetTank = null;
        this.targetLocalPoint.reset();
      }
    }

    override public function addToGame(param1:AllGlobalGunParams, param2:Vector3, param3:Body, param4:Boolean, param5:int) : void {
      super.addToGame(param1,param2,param3,param4,param5);
      this.time = 0;
      var local6:Matrix3 = BattleUtils.tmpMatrix3;
      local6.setDirectionVector(param2);
      this.setRocketRotation(local6);
      battleService.getBattleScene3D().addObject(this.rocketMesh);
      this.flightEffect = this.effects.createRocketFlightSoundEffect(this.rocketMesh,this.flightDirection);
    }

    override protected function handleFlightFinish() : void {
      this.processHitImpl(null,currPosition,flightDirection,totalDistance,BattleRunner.PHYSICS_STEP_IN_MS);
    }

    override protected function getMaxDistance() : Number {
      return this.rocketLauncherParams.shotRange;
    }

    public function explode(param1:RocketExplodeEvent) : void {
      var local2:Number = NaN;
      if(param1.type == RocketExplodeEvent.ALL || param1.rocketId == getShotId()) {
        _rayCastDirection.diff(currPosition,prevPosition);
        local2 = _rayCastDirection.length();
        _rayCastDirection.normalize();
        processHit(null,currPosition,_rayCastDirection,local2);
      }
    }

    override protected function updateTotalDistance(param1:Number) : void {
    }

    override protected function updatePosition(param1:Number) : void {
      var local3:Number = NaN;
      var local4:Number = NaN;
      var local5:Number = NaN;
      var local6:Number = NaN;
      var local7:Number = NaN;
      var local8:Number = NaN;
      prevPosition.copy(currPosition);
      var local2:Number = param1;
      if(this.hasTarget()) {
        _toTarget.copy(this.targetLocalPoint);
        BattleUtils.localToGlobal(this.targetTank.getBody(),_toTarget);
        _toTarget.subtract(prevPosition).normalize();
        local3 = flightDirection.dot(_toTarget);
        if(local3 < COS_ALMOST_ZERO_ANGLE && local3 > -COS_ALMOST_ZERO_ANGLE) {
          _cross.cross2(flightDirection,_toTarget).normalize();
          local4 = Math.min(Math.acos(local3),param1 * this.rocketLauncherParams.angularVelocity);
          local5 = local4 / this.rocketLauncherParams.angularVelocity;
          local2 -= local5;
          local6 = local4 / 2;
          _rotationMatrix.fromAxisAngle(_cross,local6);
          flightDirection.transform3(_rotationMatrix).normalize();
          local7 = this.getDistanceAndUpdateTotalDistance(local5);
          local8 = local7 * Math.sin(local6) / local6;
          currPosition.addScaled(local8,flightDirection);
          flightDirection.transform3(_rotationMatrix).normalize();
          this.rotateRocket(_rotationMatrix);
          initRadialPoints(prevPosition,flightDirection);
        }
      }
      if(local2 > 0) {
        currPosition.addScaled(this.getDistanceAndUpdateTotalDistance(local2),flightDirection);
      }
      this.savePrevPositionIfNeed();
    }

    private function savePrevPositionIfNeed() : void {
      if(isRemoteShot) {
        return;
      }
      if(!this.checkTrajectoryByAnticheat()) {
        shellStates.savePrevPosition();
      }
    }

    private function checkTrajectoryByAnticheat() : Boolean {
      var local7:Number = NaN;
      var local1:Vector3 = shellStates.getLastControlDirection();
      var local2:Vector3 = shellStates.getLastControlPosition();
      var local3:Number = this.toSeconds(shellStates.getLastControlTime());
      var local4:Number = this.toSeconds(shellStates.getTimeSinceLastControlState());
      var local5:Number = local1.dot(flightDirection);
      var local6:Number = local2.distanceTo(currPosition);
      if(local5 < COS_ALMOST_ZERO_ANGLE && local5 > -COS_ALMOST_ZERO_ANGLE) {
        local7 = Math.acos(local5) / 2;
        local6 = local6 * local7 / Math.sin(local7);
      }
      return local6 <= this.calculateDistanceByTime(local3,local4) + POSITION_ACCURACY;
    }

    private function toSeconds(param1:int) : Number {
      return param1 * 0.001;
    }

    private function getDistanceAndUpdateTotalDistance(param1:Number) : Number {
      var local2:Number = this.calculateDistanceByTime(this.time,param1);
      totalDistance += local2;
      this.time += param1;
      return local2;
    }

    private function calculateDistanceByTime(param1:Number, param2:Number) : Number {
      var local3:Number = this.rocketLauncherParams.boostPhaseDuration / 1000;
      if(param1 >= local3) {
        return this.uniformMotionDistance(param2);
      }
      var local4:Number = (this.rocketLauncherParams.maxSpeed - this.rocketLauncherParams.minSpeed) / local3;
      var local5:Number = this.rocketLauncherParams.minSpeed + local4 * param1;
      if(param1 + param2 <= local3) {
        return this.uniformAccelerationMotionDistance(local5,param2,local4);
      }
      var local6:Number = local3 - param1;
      return this.uniformAccelerationMotionDistance(local5,local6,local4) + this.uniformMotionDistance(param2 - local6);
    }

    private function uniformMotionDistance(param1:Number) : Number {
      return param1 * this.rocketLauncherParams.maxSpeed;
    }

    private function uniformAccelerationMotionDistance(param1:Number, param2:Number, param3:Number) : Number {
      return param1 * param2 + param3 * param2 * param2 / 2;
    }

    private function rotateRocket(param1:Matrix3) : void {
      var local2:Matrix3 = BattleUtils.tmpMatrix3;
      local2.setRotationMatrixForObject3D(this.rocketMesh);
      local2.append(param1).append(param1);
      this.setRocketRotation(local2);
    }

    private function setRocketRotation(param1:Matrix3) : void {
      var local2:Vector3 = null;
      local2 = BattleUtils.tmpVector;
      param1.getEulerAngles(local2);
      this.rocketMesh.rotationX = local2.x;
      this.rocketMesh.rotationY = local2.y;
      this.rocketMesh.rotationZ = local2.z;
    }

    private function hasTarget() : Boolean {
      return this.targetTank != null && this.targetTank.state == ClientTankState.ACTIVE && this.targetTank.getBody() != null;
    }

    override protected function getTimeMsToHit(param1:Number) : int {
      return BattleRunner.PHYSICS_STEP_IN_MS;
    }

    override protected function processHitImpl(param1:Body, param2:Vector3, param3:Vector3, param4:Number, param5:int) : void {
      var local6:Tank = null;
      super.processHitImpl(param1,param2,param3,param4,param5);
      if(!this.weaponObject.isAlive()) {
        this.destroy();
        return;
      }
      this.effects.playExplosionEffect(param2,param3,this.barrelIndex);
      this.splash.applySplashForce(param2,1,param1);
      if(BattleUtils.isTankBody(param1)) {
        local6 = param1.tank;
        local6.applyWeaponHit(param2,param3,this.impactForce);
        this.weaponObject.shellCommunication().tryToHit(getShotId(),shellStates,param1.tank);
      } else {
        this.weaponObject.shellCommunication().tryToHit(getShotId(),shellStates);
      }
      this.destroy();
    }

    override public function render(param1:int, param2:int) : void {
      var local3:Number = NaN;
      local3 = param2 / thousandth.getInt();
      this.rocketMesh.x = interpolatedPosition.x;
      this.rocketMesh.y = interpolatedPosition.y;
      this.rocketMesh.z = interpolatedPosition.z;
      this.flightEffect.update(local3);
    }

    override protected function destroy() : void {
      super.destroy();
      this.weaponObject.removeEventListener(this.explodeEvent,this.explode);
      this.flightEffect.close();
      battleService.getBattleScene3D().removeObject(this.rocketMesh);
      shooterBody = null;
      this.rocketMesh.setMaterialToAllFaces(null);
      this.shellWeaponCommunication = null;
      this.targetTank = null;
      this.targetLocalPoint.reset();
      this.flightEffect = null;
      this.effects = null;
    }

    override protected function getRadius() : Number {
      return this.rocketLauncherParams.shellRadius;
    }
  }
}
