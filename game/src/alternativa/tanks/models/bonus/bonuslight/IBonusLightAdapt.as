package alternativa.tanks.models.bonus.bonuslight {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IBonusLightAdapt implements IBonusLight {
    private var object:IGameObject;
    private var impl:IBonusLight;

    public function IBonusLightAdapt(param1:IGameObject, param2:IBonusLight) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getBonusLight() : BonusLight {
      var result:BonusLight = null;
      try {
        Model.object = this.object;
        result = this.impl.getBonusLight();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
