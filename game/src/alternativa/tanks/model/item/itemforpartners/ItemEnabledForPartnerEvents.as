package alternativa.tanks.model.item.itemforpartners {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ItemEnabledForPartnerEvents implements ItemEnabledForPartner {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ItemEnabledForPartnerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isAvailable() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ItemEnabledForPartner = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ItemEnabledForPartner(this.impl[i]);
          result = Boolean(m.isAvailable());
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
