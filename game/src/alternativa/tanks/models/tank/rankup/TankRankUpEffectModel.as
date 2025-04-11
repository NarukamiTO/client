package alternativa.tanks.models.tank.rankup {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.sfx.LevelUpEffectFactory;
  import alternativa.tanks.sfx.Sound3D;
  import alternativa.tanks.sfx.Sound3DEffect;
  import flash.media.Sound;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.tankparts.armor.rankup.ITankRankUpEffectModelBase;
  import projects.tanks.client.battlefield.models.tankparts.armor.rankup.TankRankUpEffectModelBase;

  [ModelInfo]
  public class TankRankUpEffectModel extends TankRankUpEffectModelBase implements ITankRankUpEffectModelBase, ObjectLoadListener, ObjectUnloadListener, ITankRankUpEffectModel {
    [Inject]
    public static var battleService:BattleService;

    private var listener:RankChangeListener;
    private var usersCount:int;

    public function TankRankUpEffectModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function objectLoaded() : void {
      if(this.listener == null) {
        this.listener = new RankChangeListener(object.space);
      }
      ++this.usersCount;
    }

    [Obfuscation(rename="false")]
    public function objectUnloaded() : void {
      --this.usersCount;
      if(this.usersCount == 0) {
        this.listener.close();
        this.listener = null;
      }
    }

    public function showRankUpEffect(param1:int) : void {
      var local2:ITankModel = ITankModel(object.adapt(ITankModel));
      var local3:Tank = local2.getTank();
      if(local3.state == ClientTankState.DEAD) {
        this.scheduleRankUpEffect(param1);
      } else {
        this.showEffect(local3,param1);
      }
    }

    private function scheduleRankUpEffect(param1:int) : void {
      var local2:ScheduledTankRankChangeEffect = new ScheduledTankRankChangeEffect(object,param1);
      putData(ScheduledTankRankChangeEffect,local2);
    }

    private function showEffect(param1:Tank, param2:int) : void {
      var local3:LevelUpEffectFactory = new LevelUpEffectFactory();
      local3.createEffect(param1,param2);
      this.createSoundEffect(param1);
    }

    private function createSoundEffect(param1:Tank) : void {
      var local3:Sound = null;
      var local4:Sound3D = null;
      var local5:Body = null;
      var local6:Vector3 = null;
      var local7:Sound3DEffect = null;
      var local2:SoundResource = getInitParam().rankUpSound;
      if(local2 != null) {
        local3 = local2.sound;
        local4 = Sound3D.create(local3);
        local5 = param1.getBody();
        local6 = local5.state.position.clone();
        local7 = Sound3DEffect.create(local6,local4,0,0);
        battleService.addSound3DEffect(local7);
      }
    }
  }
}
