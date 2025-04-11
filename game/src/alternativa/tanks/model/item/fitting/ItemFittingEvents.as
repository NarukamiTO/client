package alternativa.tanks.model.item.fitting {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ItemFittingEvents implements ItemFitting {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ItemFittingEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function fit() : void {
      var i:int = 0;
      var m:ItemFitting = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ItemFitting(this.impl[i]);
          m.fit();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
