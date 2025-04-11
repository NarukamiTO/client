package alternativa.tanks.models.bonus.notification {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.type.IGameObject;

  public class BonusNotificationAdapt implements BonusNotification {
    private var object:IGameObject;
    private var impl:BonusNotification;

    public function BonusNotificationAdapt(param1:IGameObject, param2:BonusNotification) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getMessage() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getMessage();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMessageContainsUid() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getMessageContainsUid();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSoundNotification() : SoundResource {
      var result:SoundResource = null;
      try {
        Model.object = this.object;
        result = this.impl.getSoundNotification();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
