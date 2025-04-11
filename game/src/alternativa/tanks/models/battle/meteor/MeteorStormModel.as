package alternativa.tanks.models.battle.meteor {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.engine3d.EffectsMaterialRegistry;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battlefield.models.battle.battlefield.meteors.IMeteorStormModelBase;
  import projects.tanks.client.battlefield.models.battle.battlefield.meteors.MeteorDescriptor;
  import projects.tanks.client.battlefield.models.battle.battlefield.meteors.MeteorStormModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;

  [ModelInfo]
  public class MeteorStormModel extends MeteorStormModelBase implements IMeteorStormModelBase, ObjectUnloadListener, ObjectLoadPostListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var effectsMaterialRegistry:EffectsMaterialRegistry;

    private static const NUM_LOOPS:int = 100000;

    internal var meteorSFXDataPool:Vector.<MeteorSFXData> = new Vector.<MeteorSFXData>();
    internal var meteors:Dictionary = new Dictionary();

    public function MeteorStormModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function meteorNotification() : void {
      var local1:MeteorSFXData = this.createSFXData();
      this.meteorSFXDataPool.push(local1);
      local1.meteorDistantSound.play(0,NUM_LOOPS);
    }

    private function createSFXData() : MeteorSFXData {
      return new MeteorSFXData(getInitParam(),effectsMaterialRegistry);
    }

    [Obfuscation(rename="false")]
    public function spawnMeteor(param1:Vector3d, param2:Vector3d, param3:int) : void {
      this.spawnMeteorImpl(param1,param2,param3,0);
    }

    public function objectUnloaded() : void {
      var local1:MeteorSFXData = null;
      for each(local1 in this.meteorSFXDataPool) {
        local1.meteorDistantSound.stop();
        local1.nuclearBangSound.stop();
        local1.meteorArrivingSound.stop();
      }
      this.meteorSFXDataPool.length = 0;
      this.meteors = new Dictionary();
    }

    public function objectLoadedPost() : void {
      var local1:MeteorDescriptor = null;
      for each(local1 in getInitParam().currentMeteors) {
        this.spawnMeteorImpl(local1.upperPosition,local1.groundPosition,local1.timeToFlyMs,local1.lifeTimeMs);
      }
    }

    private function spawnMeteorImpl(param1:Vector3d, param2:Vector3d, param3:int, param4:int) : void {
      var local5:MeteorSFXData = this.createOrPopSFXData();
      var local6:Meteor = new Meteor(battleService.getObjectPool(),effectsMaterialRegistry,BattleUtils.getVector3(param1),BattleUtils.getVector3(param2),BattleUtils.getVector3(param2),param3,local5);
      local6.setTime(param4);
      local6.addToBattle(battleService.getBattleScene3D(),battleService.getBattleRunner(),this.onMeteorFinished);
      this.meteors[local6] = null;
    }

    private function onMeteorFinished(param1:Meteor) : void {
      delete this.meteors[param1];
    }

    private function createOrPopSFXData() : MeteorSFXData {
      if(this.meteorSFXDataPool.length == 0) {
        return this.createSFXData();
      }
      return this.meteorSFXDataPool.pop();
    }
  }
}
