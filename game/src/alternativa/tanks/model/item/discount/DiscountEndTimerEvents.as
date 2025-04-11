package alternativa.tanks.model.item.discount {
  import controls.timer.CountDownTimer;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class DiscountEndTimerEvents implements DiscountEndTimer {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function DiscountEndTimerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEndDiscountTimer() : CountDownTimer {
      var result:CountDownTimer = null;
      var i:int = 0;
      var m:DiscountEndTimer = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = DiscountEndTimer(this.impl[i]);
          result = m.getEndDiscountTimer();
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
