package alternativa.model.description {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IDescriptionEvents implements IDescription {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IDescriptionEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getName() : String {
      var result:String = null;
      var i:int = 0;
      var m:IDescription = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IDescription(this.impl[i]);
          result = m.getName();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDescription() : String {
      var result:String = null;
      var i:int = 0;
      var m:IDescription = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IDescription(this.impl[i]);
          result = m.getDescription();
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
