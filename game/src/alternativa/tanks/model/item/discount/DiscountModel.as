package alternativa.tanks.model.item.discount {
  import alternativa.tanks.service.garage.GarageService;
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerOnCompleteBefore;
  import controls.timer.CountDownTimerOnCompleteBeforeWithContext;
  import flash.utils.clearTimeout;
  import flash.utils.getTimer;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.garage.models.item.discount.DiscountCC;
  import projects.tanks.client.garage.models.item.discount.DiscountModelBase;
  import projects.tanks.client.garage.models.item.discount.IDiscountModelBase;

  [ModelInfo]
  public class DiscountModel extends DiscountModelBase implements IDiscountModelBase, ICollectDiscount, ObjectLoadPostListener, ObjectUnloadListener, CountDownTimerOnCompleteBefore, DiscountEndTimer {
    [Inject]
    public static var garageService:GarageService;

    private const SECONDS_IN_MONTH:uint = 2592000;
    private const SECOND_MS:int = 1000;

    public function DiscountModel() {
      super();
    }

    public function objectLoadedPost() : void {
      this.initDiscountInfo();
      this.scheduleEndDiscount();
      this.scheduleNextStartDiscount();
    }

    private function initDiscountInfo() : void {
      var local1:DiscountCC = getInitParam();
      if(local1 == null || local1.discount == 0 || local1.timeToStartInSeconds > this.SECONDS_IN_MONTH) {
        putData(DiscountInfo,DiscountInfo.NO_DISCOUNT);
        return;
      }
      var local2:uint = uint(getTimer());
      var local3:uint = 0;
      if(local1.timeToStartInSeconds > 0) {
        local3 = uint(local2 + local1.timeToStartInSeconds * this.SECOND_MS);
      }
      var local4:uint = uint.MAX_VALUE;
      if(local1.timeLeftInSeconds > 0 && local1.timeLeftInSeconds < this.SECONDS_IN_MONTH) {
        local4 = uint(local2 + local1.timeLeftInSeconds * this.SECOND_MS);
      }
      putData(DiscountInfo,new DiscountInfo(local1.discount,local3,local4));
    }

    private function scheduleEndDiscount() : void {
      var local4:DiscountInfo = null;
      var local5:CountDownTimer = null;
      this.destroyEndDiscountTimer();
      var local1:uint = uint.MAX_VALUE;
      var local2:int = getTimer();
      var local3:DiscountCollector = new DiscountCollector();
      ICollectDiscount(object.event(ICollectDiscount)).collectDiscountsInfo(local3);
      for each(local4 in local3.getDiscountInfoes()) {
        if(local4.isDiscountTime(local2)) {
          local1 = Math.min(local1,local4.getEndTime());
        }
      }
      if(local1 != uint.MAX_VALUE) {
        local5 = new CountDownTimer();
        local5.start(local1);
        local5.addListener(CountDownTimerOnCompleteBefore,new CountDownTimerOnCompleteBeforeWithContext(object,this));
        putData(CountDownTimer,local5);
      }
    }

    private function destroyEndDiscountTimer() : void {
      var local1:CountDownTimer = CountDownTimer(getData(CountDownTimer));
      if(local1 != null) {
        local1.destroy();
        clearData(CountDownTimer);
      }
    }

    public function onCompleteBefore(param1:CountDownTimer, param2:Boolean) : void {
      this.scheduleEndDiscount();
      this.updateDiscount();
    }

    private function scheduleNextStartDiscount() : void {
      var local4:DiscountInfo = null;
      var local5:uint = 0;
      var local1:uint = uint.MAX_VALUE;
      var local2:int = getTimer();
      var local3:DiscountCollector = new DiscountCollector();
      ICollectDiscount(object.event(ICollectDiscount)).collectDiscountsInfo(local3);
      for each(local4 in local3.getDiscountInfoes()) {
        if(local2 < local4.getBeginTime()) {
          local1 = Math.min(local1,local4.getBeginTime());
        }
      }
      if(local1 != uint.MAX_VALUE) {
        local5 = setTimeout(getFunctionWrapper(this.startDiscount),local1 - local2);
        putData(uint,local5);
      }
    }

    private function startDiscount() : void {
      clearData(uint);
      this.scheduleEndDiscount();
      this.updateDiscount();
      this.scheduleNextStartDiscount();
    }

    private function updateDiscount() : void {
      garageService.getView().updateDiscount(object);
    }

    public function objectUnloaded() : void {
      var local1:Object = getData(uint);
      if(local1 != null) {
        clearTimeout(uint(local1));
      }
    }

    public function collectDiscountsInfo(param1:IDiscountCollector) : void {
      param1.addDiscount(DiscountInfo(getData(DiscountInfo)));
    }

    public function getEndDiscountTimer() : CountDownTimer {
      return CountDownTimer(getData(CountDownTimer));
    }
  }
}
