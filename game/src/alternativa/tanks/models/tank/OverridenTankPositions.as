package alternativa.tanks.models.tank {
  import alternativa.osgi.OSGi;
  import alternativa.tanks.models.battle.battlefield.BattleUserInfoService;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class OverridenTankPositions {
    private const positions:Object = {};

    private var tanksInBattle:Dictionary;

    public function OverridenTankPositions(param1:Dictionary) {
      super();
      this.tanksInBattle = param1;
    }

    public function getPosition(param1:IGameObject, param2:Vector3d) : Vector3d {
      var local3:BattleUserInfoService = BattleUserInfoService(OSGi.getInstance().getService(BattleUserInfoService));
      return this.positions[local3.getUserName(param1.id)] || param2;
    }
  }
}
