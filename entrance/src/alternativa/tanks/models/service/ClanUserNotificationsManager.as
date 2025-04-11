package alternativa.tanks.models.service {
  import alternativa.tanks.gui.IClanNotificationListener;
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import flash.utils.Dictionary;

  public class ClanUserNotificationsManager {
    private static var count:int;
    private static var incomingIndicators:Vector.<IClanNotificationListener> = new Vector.<IClanNotificationListener>();
    private static var incomingNotifications:Dictionary = new Dictionary();

    public static var dispatcher:EventDispatcher = new EventDispatcher();

    public function ClanUserNotificationsManager() {
      super();
    }

    public static function resetManager() : void {
      incomingIndicators = new Vector.<IClanNotificationListener>();
      incomingNotifications = new Dictionary();
      count = 0;
    }

    public static function addIncomingIndicatorListener(param1:IClanNotificationListener) : void {
      incomingIndicators.push(param1);
      param1.updateNotifications();
    }

    public static function removeIncomingIndicatorListener(param1:IClanNotificationListener) : void {
      var local2:Number = Number(incomingIndicators.indexOf(param1));
      if(local2 > 0) {
        incomingIndicators.splice(local2,1);
      }
    }

    public static function removeIncomingNotification(param1:Long) : void {
      if(clanInIncomingNotifications(param1)) {
        dispatcher.dispatchEvent(new ClanNotificationEvent(ClanNotificationEvent.REMOVE_INCOMING_NOTIFICATION,param1));
      }
    }

    public static function clanInIncomingNotifications(param1:Long) : Boolean {
      return param1 in incomingNotifications;
    }

    public static function initializeIncomingNotifications(param1:Vector.<Long>) : void {
      var local2:Long = null;
      count = 0;
      for each(local2 in param1) {
        ++count;
        incomingNotifications[local2] = true;
      }
      updateAllIndicators(incomingIndicators);
    }

    public static function onIncomingNotification(param1:Long) : void {
      if(!(param1 in incomingNotifications)) {
        ++count;
        incomingNotifications[param1] = true;
        updateAllIndicators(incomingIndicators);
      }
    }

    public static function onRemoveIncomingNotification(param1:Long) : void {
      if(param1 in incomingNotifications) {
        --count;
        delete incomingNotifications[param1];
        updateAllIndicators(incomingIndicators);
      }
    }

    public static function getIncomingNotificationsCount() : int {
      return count;
    }

    private static function updateAllIndicators(param1:Vector.<IClanNotificationListener>) : void {
      var local2:IClanNotificationListener = null;
      for each(local2 in param1) {
        local2.updateNotifications();
      }
    }
  }
}
