package alternativa.tanks.gui {
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerOnCompleteBefore;
  import platform.client.fp10.core.type.IGameObject;

  public class TimerKitCouldBeBoughtContext implements CountDownTimerOnCompleteBefore {
    public var item:IGameObject;
    public var timer:CountDownTimer;

    private var garageWindow:IGarageWindow;

    public function TimerKitCouldBeBoughtContext(param1:IGameObject, param2:CountDownTimer, param3:IGarageWindow) {
      super();
      this.item = param1;
      this.timer = param2;
      this.garageWindow = param3;
      this.timer.addListener(CountDownTimerOnCompleteBefore,this);
    }

    public function onCompleteBefore(param1:CountDownTimer, param2:Boolean) : void {
      this.garageWindow.removeItemFromStore(this.item);
    }

    public function removeListener() : void {
      this.timer.removeListener(CountDownTimerOnCompleteBefore,this);
    }
  }
}
