package projects.tanks.client.battlefield.models.battle.pointbased {
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class ClientTeamPoint {
    private var _flagBasePosition:Vector3d;
    private var _id:int;
    private var _teamType:BattleTeam;

    public function ClientTeamPoint(param1:Vector3d = null, param2:int = 0, param3:BattleTeam = null) {
      super();
      this._flagBasePosition = param1;
      this._id = param2;
      this._teamType = param3;
    }

    public function get flagBasePosition() : Vector3d {
      return this._flagBasePosition;
    }

    public function set flagBasePosition(param1:Vector3d) : void {
      this._flagBasePosition = param1;
    }

    public function get id() : int {
      return this._id;
    }

    public function set id(param1:int) : void {
      this._id = param1;
    }

    public function get teamType() : BattleTeam {
      return this._teamType;
    }

    public function set teamType(param1:BattleTeam) : void {
      this._teamType = param1;
    }

    public function toString() : String {
      var local1:String = "ClientTeamPoint [";
      local1 += "flagBasePosition = " + this.flagBasePosition + " ";
      local1 += "id = " + this.id + " ";
      local1 += "teamType = " + this.teamType + " ";
      return local1 + "]";
    }
  }
}
