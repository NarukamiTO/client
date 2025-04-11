package alternativa.tanks.models.service {
  import alternativa.tanks.gui.IClanNotificationListener;
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import flash.utils.Dictionary;

  public class ClanNotificationsManager {
    private static var incomingIndicators:Vector.<IClanNotificationListener> = new Vector.<IClanNotificationListener>();
    private static var acceptedIndicators:Vector.<IClanNotificationListener> = new Vector.<IClanNotificationListener>();
    private static var incomingNotifications:Dictionary = new Dictionary();
    private static var acceptedNotifications:Dictionary = new Dictionary();
    private static var _incomingNotificationsCount:int = 0;
    private static var _acceptedNotificationsCount:int = 0;

    public static var dispatcher:EventDispatcher = new EventDispatcher();

    public function ClanNotificationsManager() {
      super();
    }

    public static function clearListeners() : void {
      incomingIndicators = new Vector.<IClanNotificationListener>();
      acceptedIndicators = new Vector.<IClanNotificationListener>();
    }

    public static function incomingNotificationsCount() : int {
      return _incomingNotificationsCount;
    }

    public static function acceptedNotificationsCount() : int {
      return _acceptedNotificationsCount;
    }

    public static function onIncomingNotification(param1:Long) : void {
      ++_incomingNotificationsCount;
      incomingNotifications[param1] = true;
      updateAllIndicators(incomingIndicators);
    }

    public static function onRemoveIncomingNotification(param1:Long) : void {
      if(param1 in incomingNotifications) {
        --_incomingNotificationsCount;
        delete incomingNotifications[param1];
        updateAllIndicators(incomingIndicators);
      }
    }

    public static function onAcceptedNotification(param1:Long) : void {
      ++_acceptedNotificationsCount;
      acceptedNotifications[param1] = true;
      updateAllIndicators(acceptedIndicators);
    }

    public static function onRemoveAcceptedNotification(param1:Long) : void {
      if(param1 in acceptedNotifications) {
        --_acceptedNotificationsCount;
        delete acceptedNotifications[param1];
        updateAllIndicators(acceptedIndicators);
      }
    }

    public static function userInIncomingNotifications(param1:Long) : Boolean {
      return param1 in incomingNotifications;
    }

    public static function userInAcceptedNotifications(param1:Long) : Boolean {
      return param1 in acceptedNotifications;
    }

    public static function removeAcceptedNotification(param1:Long) : void {
      if(userInAcceptedNotifications(param1)) {
        dispatcher.dispatchEvent(new ClanNotificationEvent(ClanNotificationEvent.REMOVE_ACCEPTED_NOTIFICATION,param1));
      }
    }

    public static function removeIncomingNotification(param1:Long) : void {
      if(userInIncomingNotifications(param1)) {
        dispatcher.dispatchEvent(new ClanNotificationEvent(ClanNotificationEvent.REMOVE_INCOMING_NOTIFICATION,param1));
      }
    }

    public static function addIncomingIndicatorListener(param1:IClanNotificationListener) : void {
      incomingIndicators.push(param1);
    }

    public static function addAcceptedIndicatorListener(param1:IClanNotificationListener) : void {
      acceptedIndicators.push(param1);
    }

    private static function updateAllIndicators(param1:Vector.<IClanNotificationListener>) : void {
      var local2:IClanNotificationListener = null;
      for each(local2 in param1) {
        local2.updateNotifications();
      }
    }

    public static function initializeIncomingNotifications(param1:Vector.<Long>) : void {
      var local2:Long = null;
      _incomingNotificationsCount = 0;
      for each(local2 in param1) {
        ++_incomingNotificationsCount;
        incomingNotifications[local2] = true;
      }
      updateAllIndicators(incomingIndicators);
    }

    public static function initializeAcceptedNotifications(param1:Vector.<Long>) : void {
      var local2:Long = null;
      _acceptedNotificationsCount = 0;
      for each(local2 in param1) {
        ++_acceptedNotificationsCount;
        acceptedNotifications[local2] = true;
      }
      updateAllIndicators(acceptedIndicators);
    }

    public static function acceptedAndIncomingCount() : int {
      return acceptedNotificationsCount() + incomingNotificationsCount();
    }
  }
}
