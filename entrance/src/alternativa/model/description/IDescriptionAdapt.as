package alternativa.model.description {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IDescriptionAdapt implements IDescription {
    private var object:IGameObject;
    private var impl:IDescription;

    public function IDescriptionAdapt(param1:IGameObject, param2:IDescription) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getName() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getName();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDescription() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getDescription();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
