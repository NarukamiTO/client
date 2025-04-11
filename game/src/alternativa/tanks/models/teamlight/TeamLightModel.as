package alternativa.tanks.models.teamlight {
  import alternativa.tanks.services.lightingeffects.ILightingEffectsService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battlefield.models.teamlight.ITeamLightModelBase;
  import projects.tanks.client.battlefield.models.teamlight.TeamLightColorParams;
  import projects.tanks.client.battlefield.models.teamlight.TeamLightModelBase;
  import projects.tanks.client.battlefield.models.teamlight.TeamLightParams;

  [ModelInfo]
  public class TeamLightModel extends TeamLightModelBase implements ITeamLightModelBase, ObjectLoadListener {
    [Inject]
    public static var lightingEffectsService:ILightingEffectsService;

    public function TeamLightModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:TeamLightParams = null;
      for each(local1 in getInitParam().lightModes) {
        lightingEffectsService.setLightForMode(local1.battleMode,this.createTeamLight(local1));
      }
    }

    private function createTeamLight(param1:TeamLightParams) : ModeLight {
      return new ModeLight(this.createTeamLightColor(param1.redTeam),this.createTeamLightColor(param1.blueTeam),this.createTeamLightColor(param1.neutralTeam),param1.attenuationBegin,param1.attenuationEnd);
    }

    private function createTeamLightColor(param1:TeamLightColorParams) : TeamLightColor {
      return new TeamLightColor(uint(param1.color),param1.intensity);
    }
  }
}
