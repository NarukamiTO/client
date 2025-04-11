package alternativa.tanks.model.emailreminder {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class EmailReminderServiceAdapt implements EmailReminderService {
    private var object:IGameObject;
    private var impl:EmailReminderService;

    public function EmailReminderServiceAdapt(param1:IGameObject, param2:EmailReminderService) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function showEmailReminder() : void {
      try {
        Model.object = this.object;
        this.impl.showEmailReminder();
      }
      finally {
        Model.popObject();
      }
    }

    public function showNeedEmailAlert() : void {
      try {
        Model.object = this.object;
        this.impl.showNeedEmailAlert();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
