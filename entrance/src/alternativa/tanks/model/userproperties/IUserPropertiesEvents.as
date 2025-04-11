package alternativa.tanks.model.userproperties {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IUserPropertiesEvents implements IUserProperties {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IUserPropertiesEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getId() : Long {
      var result:Long = null;
      var i:int = 0;
      var m:IUserProperties = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUserProperties(this.impl[i]);
          result = m.getId();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getName() : String {
      var result:String = null;
      var i:int = 0;
      var m:IUserProperties = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUserProperties(this.impl[i]);
          result = m.getName();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getScore() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IUserProperties = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUserProperties(this.impl[i]);
          result = int(m.getScore());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getRank() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IUserProperties = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUserProperties(this.impl[i]);
          result = int(m.getRank());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getNextScore() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IUserProperties = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUserProperties(this.impl[i]);
          result = int(m.getNextScore());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPlace() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IUserProperties = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUserProperties(this.impl[i]);
          result = int(m.getPlace());
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
