package projects.tanks.client.battlefield.models.battle.pointbased {
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlag;

  public class PointBasedBattleCC {
    private var _flags:Vector.<ClientFlag>;
    private var _teamPoints:Vector.<ClientTeamPoint>;

    public function PointBasedBattleCC(param1:Vector.<ClientFlag> = null, param2:Vector.<ClientTeamPoint> = null) {
      super();
      this._flags = param1;
      this._teamPoints = param2;
    }

    public function get flags() : Vector.<ClientFlag> {
      return this._flags;
    }

    public function set flags(param1:Vector.<ClientFlag>) : void {
      this._flags = param1;
    }

    public function get teamPoints() : Vector.<ClientTeamPoint> {
      return this._teamPoints;
    }

    public function set teamPoints(param1:Vector.<ClientTeamPoint>) : void {
      this._teamPoints = param1;
    }

    public function toString() : String {
      var local1:String = "PointBasedBattleCC [";
      local1 += "flags = " + this.flags + " ";
      local1 += "teamPoints = " + this.teamPoints + " ";
      return local1 + "]";
    }
  }
}
