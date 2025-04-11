package alternativa.tanks.models.sfx.smoke {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.tankchassis.Track;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.LimitedDistanceAnimatedSpriteEffect;
  import alternativa.tanks.sfx.ScalingObject3DPositionProvider;
  import alternativa.tanks.utils.GraphicsUtils;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BlendMode;
  import flash.utils.getTimer;
  import projects.tanks.client.battlefield.models.tankparts.sfx.smoke.HullSmokeCC;

  public class HullSmokeRenderer implements Renderer {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var materialRegistry:TextureMaterialRegistry;

    private static const bias:Vector3 = new Vector3(50,-1000,0);
    private static const particleVelocity:Vector3 = new Vector3();
    private static const particlePosition:Vector3 = new Vector3();

    private var enabled:Boolean;
    private var started:Boolean;
    private var camera:GameCamera;
    private var animation:TextureAnimation;
    private var smokeSize:Number;
    private var nearDistance:Number;
    private var farDistance:Number;
    private var intensity:Number;
    private var density:Number;
    private var tank:Tank;
    private var scale:Number;
    private var startTime:Number;
    private var fadeTime:Number;

    public function HullSmokeRenderer(param1:Tank, param2:HullSmokeCC) {
      super();
      this.camera = battleService.getBattleScene3D().getCamera();
      this.tank = param1;
      this.scale = param1.getBoundSphereRadius() / 600;
      this.animation = GraphicsUtils.getTextureAnimationFromResource(materialRegistry,param2.particle);
      this.farDistance = param2.farDistance;
      this.nearDistance = param2.nearDistance;
      this.smokeSize = param2.size;
      this.intensity = param2.alpha;
      this.density = param2.density;
      this.fadeTime = param2.fadeTime;
      this.enabled = param2.enabled;
    }

    private static function addJitter(param1:Vector3, param2:Number) : void {
      param1.x += getJitter(param2);
      param1.y += getJitter(param2);
      param1.z += getJitter(param2);
    }

    private static function getJitter(param1:Number) : Number {
      return (Math.random() - 0.5) * 2 * param1;
    }

    public function start() : void {
      this.started = true;
      this.startTime = getTimer();
    }

    public function stop() : void {
      this.started = false;
    }

    public function changeDirection() : void {
      if(this.started) {
        this.startTime = getTimer() - this.fadeTime * 0.75;
      }
    }

    public function render(param1:int, param2:int) : void {
      if(this.enabled && this.started && this.camera.softTransparency && this.camera.softTransparencyStrength > 0 && this.tank && this.tank.state == ClientTankState.ACTIVE && param1 - this.startTime < this.fadeTime && Math.random() < this.density) {
        this.addTankDust(param1 - this.startTime);
      }
    }

    private function addTankDust(param1:Number) : void {
      var local5:Vector3 = null;
      var local7:Matrix3 = null;
      var local2:Track = this.tank.getLeftTrack();
      var local3:Track = this.tank.getRightTrack();
      var local4:Vector3 = local2.rays[local2.rays.length - 1].getGlobalOrigin();
      local5 = local3.rays[local3.rays.length - 1].getGlobalOrigin();
      var local6:Vector3 = new Vector3();
      local6.x = (local4.x + local5.x) / 2;
      local6.y = (local4.y + local5.y) / 2;
      local6.z = (local4.z + local5.z) / 2;
      local7 = this.tank.getBody().baseMatrix;
      bias.x *= -1;
      local7.transformVector(bias,particleVelocity);
      particlePosition.copy(local6);
      addJitter(local6,50);
      particleVelocity.z = 500;
      addJitter(particleVelocity,20);
      this.createSmokeParticle(this.scale,particlePosition,particleVelocity,1 - param1 / this.fadeTime);
    }

    private function createSmokeParticle(param1:Number, param2:Vector3, param3:Vector3, param4:Number) : void {
      var local5:ScalingObject3DPositionProvider = ScalingObject3DPositionProvider(battleService.getObjectPool().getObject(ScalingObject3DPositionProvider));
      local5.init(param2,param3,0.01);
      var local6:LimitedDistanceAnimatedSpriteEffect = LimitedDistanceAnimatedSpriteEffect(battleService.getObjectPool().getObject(LimitedDistanceAnimatedSpriteEffect));
      var local7:Number = this.smokeSize * param1 * (1 + Math.random());
      local6.init(local7,local7,this.animation,Math.random() * 2 * Math.PI,local5,0.5,0.5,null,130,BlendMode.NORMAL,this.nearDistance,this.farDistance,this.intensity * param4 * this.camera.softTransparencyStrength,true);
      battleService.addGraphicEffect(local6);
    }
  }
}
