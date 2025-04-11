package alternativa.tanks.tracker {
  public interface ITrackerService {
    function trackPageView(param1:String) : void;
    function trackEvent(param1:String, param2:String, param3:String) : void;
    function trackEventAfter(param1:String, param2:String, param3:String) : void;
  }
}
