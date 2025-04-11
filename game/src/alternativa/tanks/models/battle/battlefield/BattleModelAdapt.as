package alternativa.tanks.models.battle.battlefield {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleModelAdapt implements BattleModel {
    private var object:IGameObject;
    private var impl:BattleModel;

    public function BattleModelAdapt(param1:IGameObject, param2:BattleModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getBattleType() : BattleType {
      var result:BattleType = null;
      try {
        Model.object = this.object;
        result = this.impl.getBattleType();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
