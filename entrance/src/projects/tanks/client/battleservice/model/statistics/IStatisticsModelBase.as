package projects.tanks.client.battleservice.model.statistics {
  import alternativa.types.Long;

  public interface IStatisticsModelBase {
    function fundChange(param1:int) : void;
    function onRankChanged(param1:Long, param2:int, param3:Boolean) : void;
    function resetBattleName() : void;
    function roundFinish(param1:Boolean, param2:Vector.<UserReward>, param3:int) : void;
    function roundStart(param1:int, param2:Boolean) : void;
    function roundStop() : void;
    function setBattleName(param1:String) : void;
    function statusProbablyCheaterChanged(param1:Long, param2:Boolean) : void;
  }
}
