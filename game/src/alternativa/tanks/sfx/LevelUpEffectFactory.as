package alternativa.tanks.sfx {
  import alternativa.engine3d.core.MipMapping;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.math.Vector3;
  import alternativa.osgi.OSGi;
  import alternativa.physics.collision.CollisionDetector;
  import alternativa.physics.collision.types.RayHit;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
  import alternativa.tanks.physics.CollisionGroup;
  import alternativa.tanks.sfx.levelup.LightBeamEffect;
  import alternativa.tanks.sfx.levelup.LightWaveEffect;
  import alternativa.tanks.sfx.levelup.SparkEffect;
  import alternativa.types.Long;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BitmapData;
  import flash.display.BlendMode;
  import forms.ranks.BigRankIcon;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;

  public class LevelUpEffectFactory {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var userInfoService:IUserInfoService;

    [Inject]
    public static var materialRegistry:TextureMaterialRegistry;

    private static const BeamTexture:Class = LevelUpEffectFactory_BeamTexture;
    private static const beamBitmapData:BitmapData = new BeamTexture().bitmapData;
    private static const SparkTexture:Class = LevelUpEffectFactory_SparkTexture;
    private static const sparkBitmapData:BitmapData = new SparkTexture().bitmapData;
    private static const WaveTexture:Class = LevelUpEffectFactory_WaveTexture;
    private static const waveBitmapData:BitmapData = new WaveTexture().bitmapData;
    private static const origin:Vector3 = new Vector3();
    private static const upDirection:Vector3 = new Vector3(0,0,1);
    private static const rayHit:RayHit = new RayHit();

    public function LevelUpEffectFactory() {
      super();
    }

    private static function getAvailableHeight(param1:Number, param2:Number, param3:Number, param4:Number) : Number {
      origin.reset(param1,param2,param3);
      var local5:CollisionDetector = battleService.getBattleRunner().getCollisionDetector();
      if(local5.raycastStatic(origin,upDirection,CollisionGroup.STATIC,param4,null,rayHit)) {
        return rayHit.t;
      }
      return param4;
    }

    public function createEffect(param1:Tank, param2:int) : void {
      var local3:Object3D = param1.getSkin().getTurret3D();
      var local4:Number = this.getEffectHeight(local3.x,local3.y,local3.z);
      this.createLightBeams(local4,local3);
      this.createLabel(param1.getUser().id,local4,param2,local3);
      this.createSparks(local4,local3);
      this.createWave(local3);
    }

    private function getEffectHeight(param1:Number, param2:Number, param3:Number) : Number {
      var local4:Number = 500;
      var local5:Number = 2000;
      var local6:Number = getAvailableHeight(param1,param2,param3,local5);
      return Math.max(local4,local6);
    }

    private function createLightBeams(param1:Number, param2:Object3D) : void {
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:LightBeamEffect = null;
      var local3:int = 6;
      var local4:Number = 90;
      var local5:Number = 0;
      var local6:Number = Math.PI * 2 / local3;
      var local7:TextureMaterial = materialRegistry.getMaterial(beamBitmapData);
      var local8:int = 0;
      while(local8 < local3) {
        local9 = Math.sin(local5) * local4;
        local10 = Math.cos(local5) * local4;
        local11 = LightBeamEffect(battleService.getObjectPool().getObject(LightBeamEffect));
        local11.init(500,200,30,param1,0.8,0.5,local9,local10,-50,param2,local7);
        battleService.getBattleScene3D().addGraphicEffect(local11);
        local5 += local6;
        local8++;
      }
    }

    private function createLabel(param1:Long, param2:Number, param3:int, param4:Object3D) : void {
      var local5:BigRankIcon = new BigRankIcon();
      var local6:BattleUserInfoService = BattleUserInfoService(OSGi.getInstance().getService(BattleUserInfoService));
      var local7:Boolean = Boolean(local6.hasUserPremium(param1));
      local5.init(local7,param3);
      var local8:BitmapData = new BitmapData(local5.width,local5.height,true,0);
      local8.draw(local5);
      var local9:TextureMaterial = new TextureMaterial(local8,false,true,MipMapping.PER_PIXEL,1);
      var local10:SparkEffect = SparkEffect(battleService.getObjectPool().getObject(SparkEffect));
      local10.init(500,270,270,0,param2 * 0.8,param2 * 0.15,0.35,0,0,50,param4,local9,BlendMode.NORMAL);
      battleService.getBattleScene3D().addGraphicEffect(local10);
    }

    private function createSparks(param1:Number, param2:Object3D) : void {
      var local3:int = 0;
      var local4:Number = NaN;
      var local5:TextureMaterial = null;
      var local6:int = 0;
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local11:SparkEffect = null;
      if(GPUCapabilities.gpuEnabled) {
        local3 = 15;
        local4 = 100;
        local5 = materialRegistry.getMaterial(sparkBitmapData);
        local6 = 0;
        while(local6 < local3) {
          local7 = Math.PI * 2 * Math.random();
          local8 = Math.sin(local7) * local4;
          local9 = Math.cos(local7) * local4;
          local10 = -110 * local6 - 50;
          local11 = SparkEffect(battleService.getObjectPool().getObject(SparkEffect));
          local11.init(400,150,150,local7,param1 * 0.7,param1 * 0.15,0.7,local8,local9,local10,param2,local5,BlendMode.ADD);
          battleService.getBattleScene3D().addGraphicEffect(local11);
          local6++;
        }
      }
    }

    private function createWave(param1:Object3D) : void {
      var local2:TextureMaterial = materialRegistry.getMaterial(waveBitmapData);
      var local3:LightWaveEffect = LightWaveEffect(battleService.getObjectPool().getObject(LightWaveEffect));
      local3.init(900,220,3,true,param1,local2);
      battleService.getBattleScene3D().addGraphicEffect(local3);
    }
  }
}
