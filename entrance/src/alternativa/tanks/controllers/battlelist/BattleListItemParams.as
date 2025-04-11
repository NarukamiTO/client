package alternativa.tanks.controllers.battlelist {
  import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
  import alternativa.tanks.view.battleinfo.dm.BattleInfoDmParams;
  import alternativa.tanks.view.battleinfo.team.BattleInfoTeamParams;
  import alternativa.types.Long;
  import projects.tanks.client.battleservice.BattleCreateParameters;
  import projects.tanks.client.battleservice.Range;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.battle.IBattleInfoService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleFormatUtil;

  public class BattleListItemParams {
    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var battleInfoService:IBattleInfoService;

    [Inject]
    public static var battleFormatUtil:BattleFormatUtil;

    public var isDM:Boolean;
    public var params:BattleInfoBaseParams;
    public var dmParams:BattleInfoDmParams;
    public var teamParams:BattleInfoTeamParams;
    public var accessible:Boolean;
    public var currentBattle:Boolean;
    public var formatBattle:Boolean;
    public var formatName:String;

    public function BattleListItemParams(param1:BattleInfoBaseParams) {
      super();
      this.params = param1;
      this.dmParams = param1 as BattleInfoDmParams;
      this.teamParams = param1 as BattleInfoTeamParams;
      this.isDM = this.dmParams != null;
      var local2:Range = param1.createParams.rankRange;
      this.accessible = local2.min <= userPropertiesService.rank && userPropertiesService.rank <= local2.max;
      this.currentBattle = param1.battle.id == battleInfoService.currentBattleId;
      this.formatBattle = battleFormatUtil.isFormatBattle(this.createParams.equipmentConstraintsMode,this.createParams.parkourMode);
      this.formatName = battleFormatUtil.getShortFormatName(this.createParams.equipmentConstraintsMode,this.createParams.parkourMode);
    }

    public function get createParams() : BattleCreateParameters {
      return this.params.createParams;
    }

    public function get id() : Long {
      return this.params.battle.id;
    }

    public function get suspicionLevel() : int {
      return this.params.suspicionLevel.value;
    }

    public function get friends() : int {
      return this.params.friends;
    }
  }
}
