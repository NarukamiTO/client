package alternativa.tanks.model.info.param {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoCC;

  public class BattleParamsAdapt implements BattleParams {
    private var object:IGameObject;
    private var impl:BattleParams;

    public function BattleParamsAdapt(param1:IGameObject, param2:BattleParams) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getConstructor() : BattleParamInfoCC {
      var result:BattleParamInfoCC = null;
      try {
        Model.object = this.object;
        result = this.impl.getConstructor();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
