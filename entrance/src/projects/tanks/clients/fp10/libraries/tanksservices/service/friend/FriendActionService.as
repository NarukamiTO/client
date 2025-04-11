package projects.tanks.clients.fp10.libraries.tanksservices.service.friend {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.AlertServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;

  public class FriendActionService extends EventDispatcher implements IFriendActionService {
    [Inject]
    public static var alertService:IAlertService;

    [Inject]
    public static var localeService:ILocaleService;

    public function FriendActionService() {
      super();
    }

    public function add(param1:Long) : void {
      dispatchEvent(new FriendActionServiceEvent(FriendActionServiceEvent.ADD,param1));
    }

    public function accept(param1:Long) : void {
      dispatchEvent(new FriendActionServiceEvent(FriendActionServiceEvent.ACCEPT,param1));
    }

    public function breakItOff(param1:Long) : void {
      dispatchEvent(new FriendActionServiceEvent(FriendActionServiceEvent.BREAK_OFF,param1));
    }

    public function reject(param1:Long) : void {
      dispatchEvent(new FriendActionServiceEvent(FriendActionServiceEvent.REJECT,param1));
    }

    public function rejectAllIncoming() : void {
      dispatchEvent(new FriendActionServiceEvent(FriendActionServiceEvent.REJECT_ALL_INCOMING,null));
    }

    public function addByUid(param1:String) : void {
      dispatchEvent(new FriendActionServiceUidEvent(FriendActionServiceUidEvent.ADD,param1));
    }

    public function alreadyInIncomingFriends(param1:String, param2:Long) : void {
      var uid:String = param1;
      var userId:Long = param2;
      var alertMessage:String = localeService.getText(TanksLocale.TEXT_FRIENDS_ALREADY_HAVE_INCOMING).replace("%USERNAME%",uid);
      alertService.showAlert(alertMessage,Vector.<String>([localeService.getText(TanksLocale.TEXT_FRIENDS_YES),localeService.getText(TanksLocale.TEXT_FRIENDS_CANCEL_BUTTON_TEXT)]));
      alertService.addEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,function(param1:AlertServiceEvent):void {
        alertService.removeEventListener(AlertServiceEvent.ALERT_BUTTON_PRESSED,arguments.callee);
        if(param1.typeButton == localeService.getText(TanksLocale.TEXT_FRIENDS_YES)) {
          accept(userId);
        }
      });
    }

    public function alreadyInAcceptedFriends(param1:String) : void {
      var local2:String = localeService.getText(TanksLocale.TEXT_FRIENDS_PLAYER_ALREADY_IN_LIST_ALERT).replace("%USERNAME%",param1);
      alertService.showAlert(local2,Vector.<String>([localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK)]));
    }

    public function alreadyInOutgoingFriends(param1:String) : void {
      var local2:String = localeService.getText(TanksLocale.TEXT_FRIENDS_REQUEST_EXIST_ALERT).replace("%USERNAME%",param1);
      alertService.showAlert(local2,Vector.<String>([localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK)]));
    }

    public function incomingLimitExceeded() : void {
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_INCOMING_LIMIT_EXCEEDED_ALERT),Vector.<String>([localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK)]));
    }

    public function yourAcceptedLimitExceeded() : void {
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_YOUR_ACCEPTED_LIMIT_EXCEEDED_ALERT),Vector.<String>([localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK)]));
    }

    public function acceptedLimitExceeded(param1:String) : void {
      alertService.showAlert(localeService.getText(TanksLocale.TEXT_ACCEPTED_LIMIT_EXCEEDED_ALERT).replace("%USERNAME%",param1),Vector.<String>([localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK)]));
    }

    public function requestAccepted(param1:Long) : void {
      dispatchEvent(new FriendActionServiceUidEvent(FriendActionServiceUidEvent.REQUEST_ACCEPTED,null,param1));
    }
  }
}
