package alternativa.tanks.model.item.resistance {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class MountedResistancesAdapt implements MountedResistances {
    private var object:IGameObject;
    private var impl:MountedResistances;

    public function MountedResistancesAdapt(param1:IGameObject, param2:MountedResistances) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function mount(param1:int, param2:IGameObject) : void {
      var index:int = param1;
      var item:IGameObject = param2;
      try {
        Model.object = this.object;
        this.impl.mount(index,item);
      }
      finally {
        Model.popObject();
      }
    }

    public function unmount(param1:IGameObject) : void {
      var item:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.unmount(item);
      }
      finally {
        Model.popObject();
      }
    }

    public function getMounted() : Vector.<IGameObject> {
      var result:Vector.<IGameObject> = null;
      try {
        Model.object = this.object;
        result = this.impl.getMounted();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
