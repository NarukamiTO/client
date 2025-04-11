package alternativa.tanks.models.teamlight {
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public final class ModeLight {
    private var redTeam:TeamLightColor;
    private var blueTeam:TeamLightColor;
    private var neutralTeam:TeamLightColor;
    private var attenuationBegin:Number;
    private var attenuatrionEnd:Number;

    public function ModeLight(param1:TeamLightColor, param2:TeamLightColor, param3:TeamLightColor, param4:Number, param5:Number) {
      super();
      this.redTeam = param1;
      this.blueTeam = param2;
      this.neutralTeam = param3;
      this.attenuationBegin = param4;
      this.attenuatrionEnd = param5;
    }

    public function getLightForTeam(param1:BattleTeam) : TeamLightColor {
      switch(param1.value) {
        case BattleTeam.BLUE.value:
          return this.blueTeam;
        case BattleTeam.NONE.value:
          return this.neutralTeam;
        case BattleTeam.RED.value:
          return this.redTeam;
        default:
          return null;
      }
    }

    public function getAttenuationBegin() : Number {
      return this.attenuationBegin;
    }

    public function getAttenuationEnd() : Number {
      return this.attenuatrionEnd;
    }
  }
}
