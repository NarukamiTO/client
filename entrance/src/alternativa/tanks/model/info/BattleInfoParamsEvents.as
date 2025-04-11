package alternativa.tanks.model.info {
  import alternativa.tanks.view.battleinfo.BattleInfoBaseParams;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleInfoParamsEvents implements BattleInfoParams {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BattleInfoParamsEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getParams() : BattleInfoBaseParams {
      var result:BattleInfoBaseParams = null;
      var i:int = 0;
      var m:BattleInfoParams = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattleInfoParams(this.impl[i]);
          result = m.getParams();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
