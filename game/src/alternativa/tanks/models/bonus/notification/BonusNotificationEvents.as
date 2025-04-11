package alternativa.tanks.models.bonus.notification {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.type.IGameObject;

  public class BonusNotificationEvents implements BonusNotification {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BonusNotificationEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getMessage() : String {
      var result:String = null;
      var i:int = 0;
      var m:BonusNotification = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BonusNotification(this.impl[i]);
          result = m.getMessage();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMessageContainsUid() : String {
      var result:String = null;
      var i:int = 0;
      var m:BonusNotification = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BonusNotification(this.impl[i]);
          result = m.getMessageContainsUid();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSoundNotification() : SoundResource {
      var result:SoundResource = null;
      var i:int = 0;
      var m:BonusNotification = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BonusNotification(this.impl[i]);
          result = m.getSoundNotification();
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
