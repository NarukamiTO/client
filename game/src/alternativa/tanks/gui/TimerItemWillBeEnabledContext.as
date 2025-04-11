package alternativa.tanks.gui {
  import alternativa.tanks.service.item.ItemService;
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerOnCompleteBefore;
  import platform.client.fp10.core.type.IGameObject;

  public class TimerItemWillBeEnabledContext implements CountDownTimerOnCompleteBefore {
    [Inject]
    public static var itemService:ItemService;

    private var item:IGameObject;
    private var garageWindow:IGarageWindow;
    private var timer:CountDownTimer;

    public function TimerItemWillBeEnabledContext(param1:IGameObject, param2:CountDownTimer, param3:IGarageWindow) {
      super();
      this.item = param1;
      this.garageWindow = param3;
      this.timer = param2;
      param2.addListener(CountDownTimerOnCompleteBefore,this);
    }

    public function onCompleteBefore(param1:CountDownTimer, param2:Boolean) : void {
      this.removeListener();
      if(itemService.canBuy(this.item)) {
        this.garageWindow.addItemToStore(this.item);
      }
    }

    public function removeListener() : void {
      this.timer.removeListener(CountDownTimerOnCompleteBefore,this);
    }
  }
}
