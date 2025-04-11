package alternativa.tanks.models.panel {
  import alternativa.tanks.service.clan.ClanPanelNotificationService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.clans.panel.notification.ClanPanelNotificationModelBase;
  import projects.tanks.client.clans.panel.notification.IClanPanelNotificationModelBase;

  [ModelInfo]
  public class ClanPanelNotificationModel extends ClanPanelNotificationModelBase implements IClanPanelNotificationModelBase, ObjectLoadListener {
    [Inject]
    public static var clanPanelNotificationService:ClanPanelNotificationService;

    public function ClanPanelNotificationModel() {
      super();
    }

    public function objectLoaded() : void {
      clanPanelNotificationService.init(getInitParam().numberNotifications);
      clanPanelNotificationService.restrictionTimeJoinClanInSec = getInitParam().restrictionTimeJoinClanInSec;
    }

    public function added() : void {
      clanPanelNotificationService.add();
    }

    public function removed() : void {
      clanPanelNotificationService.remove();
    }

    public function updateRestrictionTimeJoinClan(param1:int) : void {
      clanPanelNotificationService.restrictionTimeJoinClanInSec = param1;
    }
  }
}
