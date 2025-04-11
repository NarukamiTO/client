package controls.timer {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class CountDownTimerOnCompleteBeforeWithContext implements CountDownTimerOnCompleteBefore {
    private var contextObject:IGameObject;
    private var listener:CountDownTimerOnCompleteBefore;

    public function CountDownTimerOnCompleteBeforeWithContext(param1:IGameObject, param2:CountDownTimerOnCompleteBefore) {
      super();
      this.contextObject = param1;
      this.listener = param2;
    }

    public function onCompleteBefore(param1:CountDownTimer, param2:Boolean) : void {
      Model.object = this.contextObject;
      this.listener.onCompleteBefore(param1,param2);
      Model.popObject();
    }
  }
}
