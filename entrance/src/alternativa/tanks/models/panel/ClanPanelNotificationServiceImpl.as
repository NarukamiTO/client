package alternativa.tanks.models.panel {
  import alternativa.tanks.service.clan.ClanPanelNotificationEvent;
  import alternativa.tanks.service.clan.ClanPanelNotificationService;
  import alternativa.tanks.service.panel.IPanelView;
  import flash.events.EventDispatcher;
  import flash.utils.setTimeout;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.RestrictionJoinClanEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class ClanPanelNotificationServiceImpl extends EventDispatcher implements ClanPanelNotificationService {
    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    [Inject]
    public static var panel:IPanelView;

    private var notifications:int = 0;
    private var _restrictionTimeJoinClanInSec:int;
    private var _clanButtonVisible:Boolean;

    public function ClanPanelNotificationServiceImpl() {
      super();
    }

    public function remove() : void {
      --this.notifications;
      if(this.notifications < 0) {
        this.notifications = 0;
      }
      this.dispatchUpdateEvent();
    }

    public function add() : void {
      ++this.notifications;
      this.dispatchUpdateEvent();
    }

    public function init(param1:int) : void {
      this.notifications = param1;
      this.dispatchUpdateEvent();
    }

    public function numberNotification() : int {
      return this.notifications;
    }

    private function dispatchUpdateEvent() : void {
      dispatchEvent(new ClanPanelNotificationEvent(ClanPanelNotificationEvent.UPDATE,this.notifications));
    }

    public function set restrictionTimeJoinClanInSec(param1:int) : void {
      this._restrictionTimeJoinClanInSec = param1;
      dispatchEvent(new RestrictionJoinClanEvent(RestrictionJoinClanEvent.UPDATE));
      if(param1 > 0) {
        setTimeout(this.sendUpdateTimeRestriction,param1 * 1000);
      }
    }

    private function sendUpdateTimeRestriction() : void {
      this._restrictionTimeJoinClanInSec = 0;
      dispatchEvent(new RestrictionJoinClanEvent(RestrictionJoinClanEvent.UPDATE));
    }

    public function get restrictionTimeJoinClanInSec() : int {
      return this._restrictionTimeJoinClanInSec;
    }

    public function get clanButtonVisible() : Boolean {
      return this._clanButtonVisible;
    }

    public function set clanButtonVisible(param1:Boolean) : void {
      this._clanButtonVisible = param1;
      if(panel.getPanel() != null) {
        if(this._clanButtonVisible) {
          panel.getPanel().buttonBar.showClanButton();
        } else {
          panel.getPanel().buttonBar.hideClanButton();
        }
      }
    }
  }
}
