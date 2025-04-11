package alternativa.tanks.models.tank.support {
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.BattleFinishEvent;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.models.tank.ITankModel;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;

  public class StateCorrectionSupport implements AutoClosable {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    private var localUser:IGameObject;
    private var battleEventSupport:BattleEventSupport;

    public function StateCorrectionSupport(param1:IGameObject) {
      super();
      this.localUser = param1;
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
      this.battleEventSupport.addEventHandler(StateCorrectionEvent,this.onStateCorrectionRequest);
      this.battleEventSupport.addEventHandler(BattleFinishEvent,this.onBattleFinish);
      this.battleEventSupport.activateHandlers();
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      var local2:ITankModel = null;
      if(param1.tank.getUser() == this.localUser) {
        local2 = ITankModel(this.localUser.adapt(ITankModel));
        local2.enableStateCorrection();
      }
    }

    private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void {
      var local2:ITankModel = null;
      if(param1.tank.getUser() == this.localUser) {
        local2 = ITankModel(this.localUser.adapt(ITankModel));
        local2.disableStateCorrection();
      }
    }

    private function onStateCorrectionRequest(param1:StateCorrectionEvent) : void {
      var local2:ITankModel = ITankModel(this.localUser.adapt(ITankModel));
      local2.sendStateCorrection(param1.mandatory);
    }

    private function onBattleFinish(param1:Object) : void {
      var local2:ITankModel = ITankModel(this.localUser.adapt(ITankModel));
      local2.disableStateCorrection();
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.battleEventSupport.deactivateHandlers();
      this.battleEventSupport = null;
      this.localUser = null;
    }
  }
}
