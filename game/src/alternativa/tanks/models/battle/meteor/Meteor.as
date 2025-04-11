package alternativa.tanks.models.battle.meteor {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Matrix3;
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleRunner;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.battle.meteor.nuclear.NuclearBangEffect;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.ExternalObject3DPositionProvider;
  import alternativa.tanks.sfx.PositionAndRotationProvider;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BitmapData;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class Meteor implements Renderer, LogicUnit, PositionAndRotationProvider {
    internal const timeDisappearing:* = 20;
    internal const SMOKE_INTERVAL:* = 24;
    internal const MAX_NUKE_EFFECT_TIME:* = 5000;
    internal const NUKE_BANG_VOLUME:* = 2;
    internal const ROTATION_SPEED:* = 0.006283185307179587;
    internal const DECAL_RADIUS:* = 1000;

    private var pool:ObjectPool;
    private var initialPosition:Vector3;
    private var groundPosition:Vector3;
    private var bangPosition:Vector3;
    private var timeToFlyMs:int;
    private var sfxData:MeteorSFXData;
    private var bitmapTexturesRegistry:TextureMaterialRegistry;
    private var rotationQ:Quaternion = new Quaternion();
    private var rotation:Matrix3 = new Matrix3();
    private var rotationV:Vector3 = new Vector3();
    private var baseRotation:Matrix3 = new Matrix3();
    private var vector3:Vector3 = new Vector3();

    internal var fallDirection:Vector3;
    internal var fallSpeed:Number;
    internal var fallSpeedVector:Vector3;
    internal var arrivingSoundPlayTime:int;

    private var flyTime:int;
    private var smokeTime:* = 0;
    private var meteorTime:int;
    private var arriving:Boolean = false;

    internal var state:MeteorState = MeteorState.INIT;
    internal var newPosition:Vector3 = new Vector3();

    private var meteorFlame:MeteorFlame;
    private var lightEffect:AnimatedLightEffect;
    private var meteorObject:Mesh;
    private var nuclearBangEffect:NuclearBangEffect;
    private var battleScene3D:BattleScene3D;
    private var battleRunner:BattleRunner;
    private var gameCamera:GameCamera;
    private var finishCallback:Function;
    private var lightPositionProvider:ExternalObject3DPositionProvider;

    public function Meteor(param1:ObjectPool, param2:TextureMaterialRegistry, param3:Vector3, param4:Vector3, param5:Vector3, param6:int, param7:MeteorSFXData) {
      super();
      this.pool = param1;
      this.initialPosition = param3;
      this.groundPosition = param4;
      this.bangPosition = param5;
      this.timeToFlyMs = param6;
      this.sfxData = param7;
      this.bitmapTexturesRegistry = param2;
      this.meteorFlame = new MeteorFlame(this.sfxData.tailFlame,this);
      this.lightPositionProvider = ExternalObject3DPositionProvider(param1.getObject(ExternalObject3DPositionProvider));
      this.lightEffect = AnimatedLightEffect(param1.getObject(AnimatedLightEffect));
      this.lightEffect.init(this.lightPositionProvider,this.sfxData.tailLight,AnimatedLightEffect.DEFAULT_MAX_DISTANCE,true);
      this.meteorObject = this.createMeteorObject(this.sfxData.meteorResource);
      this.flyTime = param6;
      this.fallDirection = param4.clone().subtract(param3);
      var local8:Number = this.fallDirection.length();
      this.fallSpeed = local8 / this.flyTime;
      this.fallDirection.normalize();
      this.fallSpeedVector = this.fallDirection.clone().scale(this.fallSpeed);
      this.arrivingSoundPlayTime = Math.max(this.flyTime - this.sfxData.impactSoundTimerLabel,0);
      this.meteorTime = 0;
      this.arriving = false;
    }

    public function setTime(param1:int) : void {
      this.meteorTime = param1;
    }

    private function createMeteorObject(param1:Tanks3DSResource) : Mesh {
      var local2:Mesh = param1.objects[0].clone() as Mesh;
      var local3:BitmapData = param1.getTextureForObject(0);
      if(local3 == null) {
        throw Error("Texture not found");
      }
      var local4:TextureMaterial = this.bitmapTexturesRegistry.getMaterial(local3);
      local2.setMaterialToAllFaces(local4);
      return local2;
    }

    internal function addToBattle(param1:BattleScene3D, param2:BattleRunner, param3:Function) : void {
      this.finishCallback = param3;
      this.newPosition.copy(this.initialPosition);
      Vector3.Z_AXIS.clone().scale(-1).rotationTo(this.fallDirection).toMatrix3(this.baseRotation);
      this.setObjectPosition(this.meteorObject,this.newPosition);
      this.setObjectOrientation(this.meteorObject,this.baseRotation);
      this.state = MeteorState.INIT;
      this.battleScene3D = param1;
      this.battleRunner = param2;
      this.gameCamera = param1.getCamera();
      param1.addGraphicEffect(this.meteorFlame);
      param1.addGraphicEffect(this.lightEffect);
      param1.addRenderer(this);
      param1.addObject(this.meteorObject);
      param2.addLogicUnit(this);
      this.nuclearBangEffect = new NuclearBangEffect(this.pool,this.sfxData.nuclearBangLight,this.sfxData.nuclearBangWave,this.sfxData.nuclearBangSmoke,this.sfxData.nuclearBangFlame);
    }

    public function removeFromBattle() : void {
      this.meteorFlame.kill();
      this.lightEffect.kill();
      this.mute();
      this.battleScene3D.removeObject(this.meteorObject);
      this.battleScene3D.removeRenderer(this);
      this.battleRunner.removeLogicUnit(this);
      this.battleScene3D = null;
      this.battleRunner = null;
    }

    public function mute() : void {
      this.sfxData.meteorDistantSound.stop();
      this.sfxData.nuclearBangSound.stop();
      this.sfxData.meteorArrivingSound.stop();
    }

    public function runLogic(param1:int, param2:int) : void {
      var local3:Vector3 = null;
      var local4:int = 0;
      this.meteorTime += param2;
      if(this.state == MeteorState.INIT) {
        this.state = MeteorState.FALLING;
      }
      if(this.state == MeteorState.FALLING) {
        this.lightPositionProvider.setPosition(this.newPosition);
        if(this.meteorTime < this.flyTime) {
          local3 = this.fallDirection.clone().scale(this.meteorTime * this.fallSpeed);
          this.newPosition.copy(this.initialPosition).add(local3);
          if(this.meteorTime >= this.arrivingSoundPlayTime) {
            if(!this.arriving) {
              this.arriving = true;
              this.sfxData.meteorDistantSound.stop();
              this.sfxData.meteorArrivingSound.play(0,1);
            }
            this.sfxData.meteorArrivingSound.checkVolume(this.gameCamera.position,this.newPosition,this.gameCamera.xAxis);
          } else {
            this.sfxData.meteorDistantSound.checkVolume(this.gameCamera.position,this.newPosition,this.gameCamera.xAxis);
          }
          this.smokeTime += param2;
          if(this.smokeTime > this.SMOKE_INTERVAL) {
            this.smokeTime = 0;
            this.addSmoke();
          }
        } else {
          this.newPosition.copy(this.groundPosition);
          this.sfxData.meteorArrivingSound.stop();
          this.state = MeteorState.DISAPPEARING;
          this.meteorFlame.fadeOut();
          this.explode();
        }
      } else if(this.state == MeteorState.DISAPPEARING) {
        local4 = this.meteorTime - this.flyTime;
        if(local4 < this.timeDisappearing) {
          this.meteorObject.alpha = (this.timeDisappearing.toDouble() - local4) / this.timeDisappearing;
        } else {
          this.meteorObject.visible = false;
          this.state = MeteorState.EXPLOSION;
          if(this.finishCallback != null) {
            this.finishCallback.call(this,this);
            this.finishCallback = null;
          }
        }
      } else if(this.state == MeteorState.EXPLOSION) {
        if(this.meteorTime > this.timeDisappearing + this.flyTime + this.MAX_NUKE_EFFECT_TIME) {
          this.removeFromBattle();
        }
      }
    }

    private function explode() : void {
      this.sfxData.nuclearBangSound.checkVolume(this.gameCamera.position,this.groundPosition,this.gameCamera.xAxis);
      this.sfxData.nuclearBangSound.volume = this.NUKE_BANG_VOLUME;
      this.sfxData.nuclearBangSound.play(0,1);
      this.nuclearBangEffect.play(this.bangPosition,this.battleScene3D);
      var local1:Vector3 = this.groundPosition.clone().add(Vector3.Z_AXIS.clone().scale(5));
      this.battleScene3D.addDecal(this.groundPosition,local1,this.DECAL_RADIUS,this.sfxData.craterDecal);
    }

    private function addSmoke() : void {
      var local1:MeteorSmoke = MeteorSmoke(this.pool.getObject(MeteorSmoke));
      local1.init(this.newPosition,this.fallDirection,this.sfxData.tailSmoke);
      this.battleScene3D.addGraphicEffect(local1);
    }

    public function render(param1:int, param2:int) : void {
      this.setObjectPosition(this.meteorObject,this.newPosition);
      this.rotationQ.setFromAxisAngle(Vector3.Z_AXIS,param1 * this.ROTATION_SPEED).toMatrix3(this.rotation);
      this.rotation.append(this.baseRotation).getEulerAngles(this.rotationV);
      this.setObjectOrientationV(this.meteorObject,this.rotationV);
    }

    private function setObjectOrientation(param1:Mesh, param2:Matrix3) : void {
      param2.getEulerAngles(this.vector3);
      this.setObjectOrientationV(param1,this.vector3);
    }

    private function setObjectOrientationV(param1:Mesh, param2:Vector3) : void {
      param1.rotationX = param2.x;
      param1.rotationY = param2.y;
      param1.rotationZ = param2.z;
    }

    private function setObjectPosition(param1:Mesh, param2:Vector3) : void {
      param1.x = param2.x;
      param1.y = param2.y;
      param1.z = param2.z;
    }

    public function readPositionAndRotation(param1:Vector3, param2:Vector3) : void {
      param1.copy(this.newPosition);
      param2.copy(this.fallDirection);
    }
  }
}
