package alternativa.tanks.models.effects.common {
  import alternativa.tanks.bonuses.Bonus;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IBonusCommonModelAdapt implements IBonusCommonModel {
    private var object:IGameObject;
    private var impl:IBonusCommonModel;

    public function IBonusCommonModelAdapt(param1:IGameObject, param2:IBonusCommonModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getBonus(param1:Long) : Bonus {
      var result:Bonus = null;
      var bonusInstanceId:Long = param1;
      try {
        Model.object = this.object;
        result = this.impl.getBonus(bonusInstanceId);
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
