package alternativa.tanks.model.item.present {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class UserPresentEvents implements UserPresent {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function UserPresentEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getText() : String {
      var result:String = null;
      var i:int = 0;
      var m:UserPresent = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UserPresent(this.impl[i]);
          result = m.getText();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPresenterId() : Long {
      var result:Long = null;
      var i:int = 0;
      var m:UserPresent = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UserPresent(this.impl[i]);
          result = m.getPresenterId();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDate() : Date {
      var result:Date = null;
      var i:int = 0;
      var m:UserPresent = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UserPresent(this.impl[i]);
          result = m.getDate();
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
