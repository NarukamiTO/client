package alternativa.tanks.models.tank.reloader {
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.death.TankReloadedEvent;
  import alternativa.tanks.battle.events.reload.ReloadScheduledEvent;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.event.LocalTankLoadListener;
  import alternativa.tanks.models.tank.support.TankReloaderSupport;
  import projects.tanks.client.battlefield.models.user.reloader.ITankReloaderModelBase;
  import projects.tanks.client.battlefield.models.user.reloader.TankReloaderModelBase;

  [ModelInfo]
  public class TankReloaderModel extends TankReloaderModelBase implements ITankReloaderModelBase, LocalTankLoadListener {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    public function TankReloaderModel() {
      super();
    }

    public function localTankLoaded(param1:Boolean) : void {
      if(!param1) {
        putData(TankReloaderSupport,new TankReloaderSupport(object));
      }
    }

    [Obfuscation(rename="false")]
    public function onDeathScheduled(param1:int) : void {
      battleEventDispatcher.dispatchEvent(new ReloadScheduledEvent(param1));
    }

    [Obfuscation(rename="false")]
    public function die(param1:int) : void {
      var local2:ITankModel = ITankModel(object.adapt(ITankModel));
      local2.die(param1);
    }

    [Obfuscation(rename="false")]
    public function onReload() : void {
      battleEventDispatcher.dispatchEvent(new TankReloadedEvent(object.id));
    }
  }
}
