package alternativa.tanks.model.emailreminder {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class EmailReminderServiceEvents implements EmailReminderService {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function EmailReminderServiceEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function showEmailReminder() : void {
      var i:int = 0;
      var m:EmailReminderService = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = EmailReminderService(this.impl[i]);
          m.showEmailReminder();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function showNeedEmailAlert() : void {
      var i:int = 0;
      var m:EmailReminderService = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = EmailReminderService(this.impl[i]);
          m.showNeedEmailAlert();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
