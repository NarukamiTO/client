package alternativa.tanks.model.info.param {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleselect.model.battle.param.BattleParamInfoCC;

  public class BattleParamsEvents implements BattleParams {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BattleParamsEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getConstructor() : BattleParamInfoCC {
      var result:BattleParamInfoCC = null;
      var i:int = 0;
      var m:BattleParams = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattleParams(this.impl[i]);
          result = m.getConstructor();
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
