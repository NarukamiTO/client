package alternativa.tanks.models.bonus.bonuslight {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IBonusLightEvents implements IBonusLight {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IBonusLightEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getBonusLight() : BonusLight {
      var result:BonusLight = null;
      var i:int = 0;
      var m:IBonusLight = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBonusLight(this.impl[i]);
          result = m.getBonusLight();
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
