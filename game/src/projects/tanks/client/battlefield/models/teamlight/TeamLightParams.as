package projects.tanks.client.battlefield.models.teamlight {
  import projects.tanks.client.battleservice.BattleMode;

  public class TeamLightParams {
    private var _attenuationBegin:Number;
    private var _attenuationEnd:Number;
    private var _battleMode:BattleMode;
    private var _blueTeam:TeamLightColorParams;
    private var _neutralTeam:TeamLightColorParams;
    private var _redTeam:TeamLightColorParams;

    public function TeamLightParams(param1:Number = 0, param2:Number = 0, param3:BattleMode = null, param4:TeamLightColorParams = null, param5:TeamLightColorParams = null, param6:TeamLightColorParams = null) {
      super();
      this._attenuationBegin = param1;
      this._attenuationEnd = param2;
      this._battleMode = param3;
      this._blueTeam = param4;
      this._neutralTeam = param5;
      this._redTeam = param6;
    }

    public function get attenuationBegin() : Number {
      return this._attenuationBegin;
    }

    public function set attenuationBegin(param1:Number) : void {
      this._attenuationBegin = param1;
    }

    public function get attenuationEnd() : Number {
      return this._attenuationEnd;
    }

    public function set attenuationEnd(param1:Number) : void {
      this._attenuationEnd = param1;
    }

    public function get battleMode() : BattleMode {
      return this._battleMode;
    }

    public function set battleMode(param1:BattleMode) : void {
      this._battleMode = param1;
    }

    public function get blueTeam() : TeamLightColorParams {
      return this._blueTeam;
    }

    public function set blueTeam(param1:TeamLightColorParams) : void {
      this._blueTeam = param1;
    }

    public function get neutralTeam() : TeamLightColorParams {
      return this._neutralTeam;
    }

    public function set neutralTeam(param1:TeamLightColorParams) : void {
      this._neutralTeam = param1;
    }

    public function get redTeam() : TeamLightColorParams {
      return this._redTeam;
    }

    public function set redTeam(param1:TeamLightColorParams) : void {
      this._redTeam = param1;
    }

    public function toString() : String {
      var local1:String = "TeamLightParams [";
      local1 += "attenuationBegin = " + this.attenuationBegin + " ";
      local1 += "attenuationEnd = " + this.attenuationEnd + " ";
      local1 += "battleMode = " + this.battleMode + " ";
      local1 += "blueTeam = " + this.blueTeam + " ";
      local1 += "neutralTeam = " + this.neutralTeam + " ";
      local1 += "redTeam = " + this.redTeam + " ";
      return local1 + "]";
    }
  }
}
