package alternativa.tanks.models.weapon.rocketlauncher.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.sfx.AnimatedLightEffect;
  import alternativa.tanks.sfx.ExternalObject3DPositionProvider;
  import alternativa.tanks.sfx.MobileSound3DEffect;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;
  import flash.display.BlendMode;
  import flash.media.Sound;
  import platform.client.fp10.core.type.AutoClosable;

  public class RocketFlightEffect extends PooledObject implements AutoClosable {
    [Inject]
    public static var battleService:BattleService;

    private static const FLAMES_COUNT:int = 8;
    private static const FLAME_LOOP:Number = 0.5;
    private static const SMOKE_INTERVAL:Number = 0.016;

    private const flames:Vector.<Sprite3D>;

    private var soundEffect:MobileSound3DEffect;
    private var flameTime:Number;
    private var smokeTime:Number;
    private var rocketMesh:Mesh;
    private var flightDirection:Vector3;
    private var smokeMaterial:TextureMaterial;
    private var lightEffect:AnimatedLightEffect;
    private var lightEffectPositionProvider:ExternalObject3DPositionProvider;

    public function RocketFlightEffect(param1:Pool) {
      var local2:int = 0;
      var local3:Sprite3D = null;
      this.flames = new Vector.<Sprite3D>();
      super(param1);
      local2 = 0;
      while(local2 < FLAMES_COUNT) {
        local3 = new Sprite3D(128,128);
        local3.blendMode = BlendMode.ADD;
        this.flames[local2] = local3;
        local2++;
      }
    }

    public function init(param1:Mesh, param2:Vector3, param3:Sound, param4:RocketLauncherSfxData) : void {
      var local6:Sprite3D = null;
      this.rocketMesh = param1;
      this.flightDirection = param2;
      this.smokeMaterial = param4.rocketSmoke;
      var local5:Sound3D = Sound3D.create(param3);
      this.soundEffect = MobileSound3DEffect(battleService.getObjectPool().getObject(MobileSound3DEffect));
      this.soundEffect.init(local5,param1,0,Sound3D.ETERNAL_LOOP);
      battleService.addSound3DEffect(this.soundEffect);
      for each(local6 in this.flames) {
        local6.material = param4.rocketFlame;
        local6.rotation = Math.random() * Math.PI * 2;
        battleService.getBattleScene3D().addObject(local6);
      }
      this.flameTime = 0;
      this.smokeTime = 0;
      this.lightEffect = AnimatedLightEffect(battleService.getObjectPool().getObject(AnimatedLightEffect));
      this.lightEffectPositionProvider = ExternalObject3DPositionProvider(battleService.getObjectPool().getObject(ExternalObject3DPositionProvider));
      this.lightEffect.init(this.lightEffectPositionProvider,param4.rocketLightingAnimation,AnimatedLightEffect.DEFAULT_MAX_DISTANCE,true);
      battleService.addGraphicEffect(this.lightEffect);
    }

    public function update(param1:Number) : void {
      var local3:RocketSmoke = null;
      this.flameTime += param1;
      this.smokeTime += param1;
      var local2:int = 0;
      while(local2 < FLAMES_COUNT) {
        this.updateFlame(this.flames[local2],this.flameTime + local2 * FLAME_LOOP / FLAMES_COUNT);
        local2++;
      }
      if(this.smokeTime >= SMOKE_INTERVAL) {
        local3 = RocketSmoke(battleService.getObjectPool().getObject(RocketSmoke));
        local3.init(this.rocketMesh,this.flightDirection,this.smokeMaterial);
        battleService.addGraphicEffect(local3);
        this.smokeTime = 0;
      }
      this.lightEffectPositionProvider.setPosition(BattleUtils.tmpVector.reset(this.rocketMesh.x,this.rocketMesh.y,this.rocketMesh.z));
    }

    private function updateFlame(param1:Sprite3D, param2:Number) : void {
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local3:Number = 5 / 60;
      var local4:Number = FLAME_LOOP;
      var local5:Number = 0.5;
      var local6:Number = 0.8;
      var local7:Number = 0.2;
      var local8:Number = 10;
      var local9:Number = 30;
      var local10:Number = 250;
      var local11:Number = 0.6;
      var local12:Number = 1;
      var local13:Number = 0;
      param2 %= local4;
      if(param2 <= local3) {
        local14 = param2 / local3;
        local15 = local5 + (local6 - local5) * local14;
        local16 = local8 + (local9 - local8) * local14;
        local17 = local11 + (local12 - local11) * local14;
      } else {
        local14 = (param2 - local3) / (local4 - local3);
        local15 = local6 + (local7 - local6) * local14;
        local16 = local9 + (local10 - local9) * local14;
        local17 = local12 + (local13 - local12) * local14;
      }
      param1.scaleX = local15;
      param1.scaleY = local15;
      param1.scaleZ = local15;
      param1.x = this.rocketMesh.x - this.flightDirection.x * local16;
      param1.y = this.rocketMesh.y - this.flightDirection.y * local16;
      param1.z = this.rocketMesh.z - this.flightDirection.z * local16;
      param1.alpha = local17;
    }

    public function close() : void {
      var local1:Sprite3D = null;
      this.soundEffect.kill();
      this.soundEffect = null;
      for each(local1 in this.flames) {
        battleService.getBattleScene3D().removeObject(local1);
        local1.material = null;
      }
      this.rocketMesh = null;
      this.flightDirection = null;
      this.smokeMaterial = null;
      this.lightEffect.kill();
      this.lightEffect = null;
      this.lightEffectPositionProvider = null;
      recycle();
    }
  }
}
