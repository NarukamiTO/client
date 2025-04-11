package alternativa.tanks.model.item.skins {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class AvailableSkinsAdapt implements AvailableSkins {
    private var object:IGameObject;
    private var impl:AvailableSkins;

    public function AvailableSkinsAdapt(param1:IGameObject, param2:AvailableSkins) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSkins() : Vector.<IGameObject> {
      var result:Vector.<IGameObject> = null;
      try {
        Model.object = this.object;
        result = this.impl.getSkins();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
