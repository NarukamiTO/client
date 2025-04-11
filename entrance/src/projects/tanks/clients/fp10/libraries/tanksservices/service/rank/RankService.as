package projects.tanks.clients.fp10.libraries.tanksservices.service.rank {
  import projects.tanks.client.tanksservices.model.rankloader.RankInfo;

  public interface RankService {
    function getRankName(param1:int) : String;
    function getNormalizedRankIndex(param1:int) : int;
    function initRanks(param1:Vector.<RankInfo>) : void;
    function get rankNames() : Vector.<String>;
  }
}
