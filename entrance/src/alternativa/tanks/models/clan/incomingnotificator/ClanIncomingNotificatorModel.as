package alternativa.tanks.models.clan.incomingnotificator {
  import alternativa.tanks.models.service.ClanNotificationEvent;
  import alternativa.tanks.models.service.ClanNotificationsManager;
  import alternativa.tanks.models.user.IClanUserModel;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.clans.clan.incomingnotificator.ClanIncomingNotificatorModelBase;
  import projects.tanks.client.clans.clan.incomingnotificator.IClanIncomingNotificatorModelBase;

  [ModelInfo]
  public class ClanIncomingNotificatorModel extends ClanIncomingNotificatorModelBase implements ObjectLoadListener, ObjectUnloadListener, IClanIncomingNotificatorModelBase {
    public function ClanIncomingNotificatorModel() {
      super();
    }

    public function onAdding(param1:Long) : void {
      if(!this.isServiceSpace()) {
        return;
      }
      ClanNotificationsManager.onIncomingNotification(param1);
    }

    public function onRemoved(param1:Long) : void {
      if(!this.isServiceSpace()) {
        return;
      }
      ClanNotificationsManager.onRemoveIncomingNotification(param1);
    }

    public function objectLoaded() : void {
      if(!this.isServiceSpace()) {
        return;
      }
      ClanNotificationsManager.initializeIncomingNotifications(getInitParam().objects);
      ClanNotificationsManager.dispatcher.addEventListener(ClanNotificationEvent.REMOVE_INCOMING_NOTIFICATION,getFunctionWrapper(this.onServerRemove));
    }

    private function onServerRemove(param1:ClanNotificationEvent) : void {
      server.remove(param1.id);
    }

    public function objectUnloaded() : void {
      if(!this.isServiceSpace()) {
        return;
      }
      ClanNotificationsManager.dispatcher.removeEventListener(ClanNotificationEvent.REMOVE_INCOMING_NOTIFICATION,getFunctionWrapper(this.onServerRemove));
    }

    private function isServiceSpace() : Boolean {
      return IClanUserModel(object.adapt(IClanUserModel)).loadingInServiceSpace();
    }
  }
}
