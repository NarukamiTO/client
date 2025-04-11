package alternativa.tanks.models.tank.rankup {
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoListener;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
  import alternativa.types.Long;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;

  public class RankChangeListener implements BattleUserInfoListener, AutoClosable {
    [Inject]
    public static var battleUserInfoService:BattleUserInfoService;

    private var space:ISpace;

    public function RankChangeListener(param1:ISpace) {
      super();
      this.space = param1;
      battleUserInfoService.addBattleUserInfoListener(this);
    }

    public function userRankChanged(param1:Long, param2:int) : void {
      var local3:IGameObject = this.space.getObject(param1);
      var local4:ITankRankUpEffectModel = ITankRankUpEffectModel(local3.adapt(ITankRankUpEffectModel));
      local4.showRankUpEffect(param2);
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.space = null;
      battleUserInfoService.removeBattleUserInfoListener(this);
    }

    public function userInfoChanged(param1:Long, param2:String, param3:int, param4:Boolean) : void {
    }

    public function userSuspiciousnessChanged(param1:Long, param2:Boolean) : void {
    }
  }
}
