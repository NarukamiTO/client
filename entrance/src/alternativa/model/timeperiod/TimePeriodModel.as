package alternativa.model.timeperiod {
  import flash.utils.getTimer;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.models.commons.periodtime.ITimePeriodModelBase;
  import platform.client.models.commons.periodtime.TimePeriodModelBase;

  [ModelInfo]
  public class TimePeriodModel extends TimePeriodModelBase implements TimePeriod, ITimePeriodModelBase, ObjectLoadListener {
    public function TimePeriodModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:uint = uint(getTimer());
      putData(int,local1);
    }

    public function getTimeLeftInSeconds() : int {
      return getInitParam().timeLeftInSeconds;
    }

    public function getModelLoadingTimeInMillis() : int {
      return int(getData(int));
    }

    public function isEnabled() : Boolean {
      return getInitParam().isEnabled;
    }

    public function isTimeless() : Boolean {
      return getInitParam().isTimeless;
    }

    public function getTimeToStartInSeconds() : int {
      return getInitParam().timeToStartInSeconds;
    }
  }
}
