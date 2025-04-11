package alternativa.tanks.models.clan.acceptednotificator {
  import alternativa.tanks.models.service.ClanNotificationEvent;
  import alternativa.tanks.models.service.ClanNotificationsManager;
  import alternativa.tanks.models.user.IClanUserModel;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.clans.clan.acceptednotificator.ClanAcceptedNotificatorModelBase;
  import projects.tanks.client.clans.clan.acceptednotificator.IClanAcceptedNotificatorModelBase;

  [ModelInfo]
  public class ClanAcceptedNotificatorModel extends ClanAcceptedNotificatorModelBase implements ObjectLoadListener, ObjectUnloadListener, IClanAcceptedNotificatorModelBase {
    public function ClanAcceptedNotificatorModel() {
      super();
    }

    public function onAdding(param1:Long) : void {
      if(!this.isServiceSpace()) {
        return;
      }
      ClanNotificationsManager.onAcceptedNotification(param1);
    }

    public function onRemoved(param1:Long) : void {
      if(!this.isServiceSpace()) {
        return;
      }
      ClanNotificationsManager.onRemoveAcceptedNotification(param1);
    }

    public function objectLoaded() : void {
      if(!this.isServiceSpace()) {
        return;
      }
      ClanNotificationsManager.initializeAcceptedNotifications(getInitParam().objects);
      ClanNotificationsManager.dispatcher.addEventListener(ClanNotificationEvent.REMOVE_ACCEPTED_NOTIFICATION,getFunctionWrapper(this.onServerRemove));
    }

    public function objectUnloaded() : void {
      if(!this.isServiceSpace()) {
        return;
      }
      ClanNotificationsManager.dispatcher.removeEventListener(ClanNotificationEvent.REMOVE_ACCEPTED_NOTIFICATION,getFunctionWrapper(this.onServerRemove));
    }

    private function onServerRemove(param1:ClanNotificationEvent) : void {
      server.remove(param1.id);
    }

    private function isServiceSpace() : Boolean {
      return IClanUserModel(object.adapt(IClanUserModel)).loadingInServiceSpace();
    }
  }
}
