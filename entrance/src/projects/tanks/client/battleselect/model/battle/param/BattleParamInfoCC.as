package projects.tanks.client.battleselect.model.battle.param {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleservice.BattleCreateParameters;

  public class BattleParamInfoCC {
    private var _map:IGameObject;
    private var _params:BattleCreateParameters;

    public function BattleParamInfoCC(param1:IGameObject = null, param2:BattleCreateParameters = null) {
      super();
      this._map = param1;
      this._params = param2;
    }

    public function get map() : IGameObject {
      return this._map;
    }

    public function set map(param1:IGameObject) : void {
      this._map = param1;
    }

    public function get params() : BattleCreateParameters {
      return this._params;
    }

    public function set params(param1:BattleCreateParameters) : void {
      this._params = param1;
    }

    public function toString() : String {
      var local1:String = "BattleParamInfoCC [";
      local1 += "map = " + this.map + " ";
      local1 += "params = " + this.params + " ";
      return local1 + "]";
    }
  }
}
