package alternativa.tanks.models.battle.battlefield {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleModelEvents implements BattleModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BattleModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getBattleType() : BattleType {
      var result:BattleType = null;
      var i:int = 0;
      var m:BattleModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattleModel(this.impl[i]);
          result = m.getBattleType();
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
