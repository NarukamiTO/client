package projects.tanks.clients.fp10.libraries.tanksservices.service.rank {
  import projects.tanks.client.tanksservices.model.rankloader.RankInfo;

  public class RankServiceImpl implements RankService {
    private var _rankNames:Vector.<String>;

    public function RankServiceImpl() {
      super();
    }

    public function getRankName(param1:int) : String {
      if(param1 > this._rankNames.length) {
        return this._rankNames[this._rankNames.length - 1] + " " + (param1 + 1 - this._rankNames.length);
      }
      return this._rankNames[param1 - 1];
    }

    public function getNormalizedRankIndex(param1:int) : int {
      return Math.min(this._rankNames.length,param1);
    }

    public function initRanks(param1:Vector.<RankInfo>) : void {
      var local2:RankInfo = null;
      this._rankNames = new Vector.<String>(param1.length);
      for each(local2 in param1) {
        this._rankNames[local2.index - 1] = local2.name;
      }
    }

    public function get rankNames() : Vector.<String> {
      return this._rankNames;
    }
  }
}
