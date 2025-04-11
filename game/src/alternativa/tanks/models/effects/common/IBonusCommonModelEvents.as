package alternativa.tanks.models.effects.common {
  import alternativa.tanks.bonuses.Bonus;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IBonusCommonModelEvents implements IBonusCommonModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IBonusCommonModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getBonus(param1:Long) : Bonus {
      var result:Bonus = null;
      var i:int = 0;
      var m:IBonusCommonModel = null;
      var bonusInstanceId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBonusCommonModel(this.impl[i]);
          result = m.getBonus(bonusInstanceId);
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
