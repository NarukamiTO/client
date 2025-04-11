package alternativa.tanks.model.info.team {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleTeamInfoAdapt implements BattleTeamInfo {
    private var object:IGameObject;
    private var impl:BattleTeamInfo;

    public function BattleTeamInfoAdapt(param1:IGameObject, param2:BattleTeamInfo) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getUsersCountBlue() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getUsersCountBlue());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getUsersCountRed() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getUsersCountRed());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
