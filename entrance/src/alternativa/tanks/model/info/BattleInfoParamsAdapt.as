package alternativa.tanks.model.info {
  import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleInfoParamsAdapt implements BattleInfoParams {
    private var object:IGameObject;
    private var impl:BattleInfoParams;

    public function BattleInfoParamsAdapt(param1:IGameObject, param2:BattleInfoParams) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getParams() : BattleInfoBaseParams {
      var result:BattleInfoBaseParams = null;
      try {
        Model.object = this.object;
        result = this.impl.getParams();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
