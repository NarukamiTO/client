package alternativa.tanks.models.statistics {
  import projects.tanks.client.battleservice.model.statistics.UserReward;

  [ModelInterface]
  public interface IStatisticRound {
    function roundStart() : void;
    function roundFinish(param1:Boolean, param2:Boolean, param3:int, param4:Vector.<UserReward>) : void;
    function roundStop() : void;
  }
}
