package alternativa.tanks.models.statistics {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.model.statistics.UserReward;

  public class IStatisticRoundEvents implements IStatisticRound {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IStatisticRoundEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function roundStart() : void {
      var i:int = 0;
      var m:IStatisticRound = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStatisticRound(this.impl[i]);
          m.roundStart();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function roundFinish(param1:Boolean, param2:Boolean, param3:int, param4:Vector.<UserReward>) : void {
      var i:int = 0;
      var m:IStatisticRound = null;
      var matchBattle:Boolean = param1;
      var needShowScore:Boolean = param2;
      var timeToRestart:int = param3;
      var reward:Vector.<UserReward> = param4;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStatisticRound(this.impl[i]);
          m.roundFinish(matchBattle,needShowScore,timeToRestart,reward);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function roundStop() : void {
      var i:int = 0;
      var m:IStatisticRound = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IStatisticRound(this.impl[i]);
          m.roundStop();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
