package alternativa.tanks.models.tank {
  import alternativa.osgi.service.command.FormattedOutput;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
  import flash.utils.Dictionary;

  public class TanksList {
    private var tanksInBattle:Dictionary;
    private var userInfoService:BattleUserInfoService;

    public function TanksList(param1:Dictionary, param2:BattleUserInfoService) {
      super();
      this.tanksInBattle = param1;
      this.userInfoService = param2;
    }

    public function printTanksList(param1:FormattedOutput) : void {
    }
  }
}
