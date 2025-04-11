package alternativa.tanks.model.item.skins {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class AvailableSkinsEvents implements AvailableSkins {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function AvailableSkinsEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSkins() : Vector.<IGameObject> {
      var result:Vector.<IGameObject> = null;
      var i:int = 0;
      var m:AvailableSkins = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = AvailableSkins(this.impl[i]);
          result = m.getSkins();
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
