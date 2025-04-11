package alternativa.tanks.models.statistics {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.statistics.UserReward;

  public class IStatisticRoundAdapt implements IStatisticRound {
    private var object:IGameObject;
    private var impl:IStatisticRound;

    public function IStatisticRoundAdapt(param1:IGameObject, param2:IStatisticRound) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function roundStart() : void {
      try {
        Model.object = this.object;
        this.impl.roundStart();
      }
      finally {
        Model.popObject();
      }
    }

    public function roundFinish(param1:Boolean, param2:Boolean, param3:int, param4:Vector.<UserReward>) : void {
      var matchBattle:Boolean = param1;
      var needShowScore:Boolean = param2;
      var timeToRestart:int = param3;
      var reward:Vector.<UserReward> = param4;
      try {
        Model.object = this.object;
        this.impl.roundFinish(matchBattle,needShowScore,timeToRestart,reward);
      }
      finally {
        Model.popObject();
      }
    }

    public function roundStop() : void {
      try {
        Model.object = this.object;
        this.impl.roundStop();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
