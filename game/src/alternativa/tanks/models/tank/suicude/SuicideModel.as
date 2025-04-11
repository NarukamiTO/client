package alternativa.tanks.models.tank.suicude {
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.death.TankSuicideEvent;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.event.LocalTankLoadListener;
  import alternativa.tanks.models.tank.event.LocalTankUnloadListener;
  import alternativa.tanks.models.tank.support.SuicideSupport;
  import projects.tanks.client.battlefield.models.user.suicide.ISuicideModelBase;
  import projects.tanks.client.battlefield.models.user.suicide.SuicideModelBase;

  [ModelInfo]
  public class SuicideModel extends SuicideModelBase implements ISuicideModelBase, LocalTankLoadListener, LocalTankUnloadListener {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    public function SuicideModel() {
      super();
    }

    public function localTankLoaded(param1:Boolean) : void {
      putData(SuicideSupport,new SuicideSupport(object,server,getInitParam().suicideDelayMS));
    }

    public function localTankUnloaded(param1:Boolean) : void {
      SuicideSupport(clearData(SuicideSupport)).close();
    }

    [Obfuscation(rename="false")]
    public function suicide(param1:int) : void {
      var local2:ITankModel = ITankModel(object.adapt(ITankModel));
      local2.die(param1);
      battleEventDispatcher.dispatchEvent(new TankSuicideEvent(object));
    }
  }
}
