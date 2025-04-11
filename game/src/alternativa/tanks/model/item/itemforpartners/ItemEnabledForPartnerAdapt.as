package alternativa.tanks.model.item.itemforpartners {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ItemEnabledForPartnerAdapt implements ItemEnabledForPartner {
    private var object:IGameObject;
    private var impl:ItemEnabledForPartner;

    public function ItemEnabledForPartnerAdapt(param1:IGameObject, param2:ItemEnabledForPartner) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isAvailable() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isAvailable());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
