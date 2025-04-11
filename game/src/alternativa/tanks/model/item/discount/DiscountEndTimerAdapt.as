package alternativa.tanks.model.item.discount {
  import controls.timer.CountDownTimer;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class DiscountEndTimerAdapt implements DiscountEndTimer {
    private var object:IGameObject;
    private var impl:DiscountEndTimer;

    public function DiscountEndTimerAdapt(param1:IGameObject, param2:DiscountEndTimer) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEndDiscountTimer() : CountDownTimer {
      var result:CountDownTimer = null;
      try {
        Model.object = this.object;
        result = this.impl.getEndDiscountTimer();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
