package alternativa.tanks.battle.utils {
  import alternativa.tanks.battle.BattleRunnerProvider;
  import alternativa.tanks.battle.DeferredAction;
  import alternativa.tanks.battle.LogicUnit;

  public class LogicUnitDeferredAction extends BattleRunnerProvider implements DeferredAction {
    private var logicUnit:LogicUnit;
    private var add:Boolean;

    public function LogicUnitDeferredAction(param1:LogicUnit, param2:Boolean) {
      super();
      this.logicUnit = param1;
      this.add = param2;
    }

    public function execute() : void {
      if(this.add) {
        getBattleRunner().addLogicUnit(this.logicUnit);
      } else {
        getBattleRunner().removeLogicUnit(this.logicUnit);
      }
    }
  }
}
