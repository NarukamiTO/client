package alternativa.tanks.model.item.fitting {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ItemFittingAdapt implements ItemFitting {
    private var object:IGameObject;
    private var impl:ItemFitting;

    public function ItemFittingAdapt(param1:IGameObject, param2:ItemFitting) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function fit() : void {
      try {
        Model.object = this.object;
        this.impl.fit();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
