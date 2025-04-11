package alternativa.tanks.battle {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.tankchassis.SuspensionRay;
  import alternativa.tanks.battle.objects.tank.tankchassis.Track;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.*;
  import alternativa.tanks.utils.GraphicsUtils;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BlendMode;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;

  public class Dust {
    private static const CHANCE:Number = 0.2;
    private static const SCALE_JITTER:Number = 1;
    private static const bias:Vector3 = new Vector3(100,0,0);
    private static const particleVelocity:Vector3 = new Vector3();
    private static const particlePosition:Vector3 = new Vector3();

    private var battleService:BattleService;
    private var dustSize:Number = 0;
    private var animation:TextureAnimation;
    private var tanks:Dictionary = new Dictionary();
    private var camera:GameCamera;
    private var nearDistance:Number;
    private var farDistance:Number;

    public var enabled:Boolean = true;

    private var intensity:Number;
    private var density:Number;

    public function Dust(param1:BattleService) {
      super();
      this.battleService = param1;
      this.camera = param1.getBattleScene3D().getCamera();
    }

    private static function addJitter(param1:Vector3, param2:Number) : void {
      param1.x += (Math.random() - 0.5) * 2 * param2;
      param1.y += (Math.random() - 0.5) * 2 * param2;
      param1.z += (Math.random() - 0.5) * 2 * param2;
    }

    public function init(param1:MultiframeTextureResource, param2:TextureMaterialRegistry, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : void {
      this.animation = GraphicsUtils.getTextureAnimationFromResource(param2,param1);
      this.farDistance = param3;
      this.nearDistance = param4;
      this.dustSize = param5;
      this.intensity = param6;
      this.density = param7;
    }

    public function addTank(param1:Tank) : void {
      this.tanks[param1] = param1.getBoundSphereRadius() / 600;
    }

    public function removeTank(param1:Tank) : void {
      delete this.tanks[param1];
    }

    public function update() : void {
      var local1:* = undefined;
      var local2:Tank = null;
      if(this.enabled && Boolean(this.camera.softTransparency) && this.camera.softTransparencyStrength > 0) {
        for(local1 in this.tanks) {
          local2 = local1 as Tank;
          if(Boolean(local2) && local2.state == ClientTankState.ACTIVE) {
            this.addTankDust(local2,100,this.density);
          }
        }
      }
    }

    public function addTankDust(param1:Tank, param2:Number = 100, param3:Number = 0.2) : void {
      var local4:Number = Number(this.tanks[param1]);
      var local5:Track = param1.getLeftTrack();
      var local6:Track = param1.getRightTrack();
      if(local5.animationSpeed * local6.animationSpeed < 0) {
        param2 = 5;
      }
      var local7:Matrix3 = param1.getBody().baseMatrix;
      bias.x *= -1;
      local7.transformVector(bias,particleVelocity);
      this.addTrackDust(local5,local4,particleVelocity,param2,param3);
      bias.x *= -1;
      local7.transformVector(bias,particleVelocity);
      this.addTrackDust(local6,local4,particleVelocity,param2,param3);
    }

    private function addTrackDust(param1:Track, param2:Number, param3:Vector3, param4:Number, param5:Number) : void {
      var local7:SuspensionRay = null;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local6:int = 0;
      while(local6 < param1.numRays) {
        local7 = param1.rays[local6];
        local8 = local7.speed;
        if(local8 > param4 && Math.random() < param5) {
          local9 = local8 > 500 ? 1 : 0.3 + local8 / 712;
          particlePosition.copy(local7.getGlobalOrigin());
          addJitter(particlePosition,50);
          param3.z = 100;
          addJitter(param3,20);
          this.createDustParticle(param2,particlePosition,param3,local9);
        }
        local6++;
      }
    }

    private function createDustParticle(param1:Number, param2:Vector3, param3:Vector3, param4:Number) : void {
      var local5:ScalingObject3DPositionProvider = null;
      var local6:LimitedDistanceAnimatedSpriteEffect = null;
      var local7:Number = NaN;
      if(this.enabled && Boolean(this.camera.softTransparency) && this.camera.softTransparencyStrength > 0) {
        local5 = ScalingObject3DPositionProvider(this.battleService.getObjectPool().getObject(ScalingObject3DPositionProvider));
        local5.init(param2,param3,0.01);
        local6 = LimitedDistanceAnimatedSpriteEffect(this.battleService.getObjectPool().getObject(LimitedDistanceAnimatedSpriteEffect));
        local7 = this.dustSize * param1 * (1 + SCALE_JITTER * Math.random());
        local6.init(local7,local7,this.animation,Math.random() * 2 * Math.PI,local5,0.5,0.5,null,130,BlendMode.NORMAL,this.nearDistance,this.farDistance,this.intensity * param4 * this.camera.softTransparencyStrength,true);
        this.battleService.addGraphicEffect(local6);
      }
    }
  }
}
