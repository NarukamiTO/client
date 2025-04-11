package alternativa.tanks.model.item.resistance {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class MountedResistancesEvents implements MountedResistances {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function MountedResistancesEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function mount(param1:int, param2:IGameObject) : void {
      var i:int = 0;
      var m:MountedResistances = null;
      var index:int = param1;
      var item:IGameObject = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = MountedResistances(this.impl[i]);
          m.mount(index,item);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function unmount(param1:IGameObject) : void {
      var i:int = 0;
      var m:MountedResistances = null;
      var item:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = MountedResistances(this.impl[i]);
          m.unmount(item);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getMounted() : Vector.<IGameObject> {
      var result:Vector.<IGameObject> = null;
      var i:int = 0;
      var m:MountedResistances = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = MountedResistances(this.impl[i]);
          result = m.getMounted();
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
