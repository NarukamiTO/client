package alternativa.tanks.model.item.present {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class UserPresentAdapt implements UserPresent {
    private var object:IGameObject;
    private var impl:UserPresent;

    public function UserPresentAdapt(param1:IGameObject, param2:UserPresent) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getText() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getText();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPresenterId() : Long {
      var result:Long = null;
      try {
        Model.object = this.object;
        result = this.impl.getPresenterId();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDate() : Date {
      var result:Date = null;
      try {
        Model.object = this.object;
        result = this.impl.getDate();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
