package alternativa.tanks.models.battle.ctf {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.LogicUnit;
  import alternativa.tanks.models.battle.commonflag.CommonFlag;
  import alternativa.tanks.models.battle.commonflag.ICommonFlagModeModel;

  public class FlagPickupTimeoutTask implements LogicUnit {
    [Inject]
    public static var battleService:BattleService;

    private var callback:ICommonFlagModeModel;
    private var flag:CommonFlag;
    private var triggerTime:int;

    public function FlagPickupTimeoutTask(param1:ICommonFlagModeModel, param2:CommonFlag, param3:int) {
      super();
      this.callback = param1;
      this.flag = param2;
      this.triggerTime = param3;
    }

    public function runLogic(param1:int, param2:int) : void {
      if(param1 >= this.triggerTime) {
        battleService.getBattleRunner().removeLogicUnit(this);
        this.callback.onPickupTimeoutPassed(this.flag);
      }
    }
  }
}
