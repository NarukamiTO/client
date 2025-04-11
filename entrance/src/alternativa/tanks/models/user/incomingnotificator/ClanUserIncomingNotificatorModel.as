package alternativa.tanks.models.user.incomingnotificator {
  import alternativa.tanks.models.service.ClanNotificationEvent;
  import alternativa.tanks.models.service.ClanUserNotificationsManager;
  import alternativa.tanks.models.user.ClanUserService;
  import alternativa.tanks.models.user.IClanUserModel;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.clans.user.incomingnotificator.ClanUserIncomingNotificatorModelBase;
  import projects.tanks.client.clans.user.incomingnotificator.IClanUserIncomingNotificatorModelBase;

  [ModelInfo]
  public class ClanUserIncomingNotificatorModel extends ClanUserIncomingNotificatorModelBase implements ObjectLoadListener, ObjectUnloadListener, IClanUserIncomingNotificatorModelBase {
    [Inject]
    public static var clanUserService:ClanUserService;

    public function ClanUserIncomingNotificatorModel() {
      super();
    }

    public function onAdding(param1:Long) : void {
      if(!this.isServiceSpace()) {
        return;
      }
      ClanUserNotificationsManager.onIncomingNotification(param1);
    }

    public function onRemoved(param1:Long) : void {
      if(!this.isServiceSpace()) {
        return;
      }
      ClanUserNotificationsManager.onRemoveIncomingNotification(param1);
    }

    public function objectLoaded() : void {
      if(!this.isServiceSpace()) {
        return;
      }
      ClanUserNotificationsManager.initializeIncomingNotifications(getInitParam().objects);
      ClanUserNotificationsManager.dispatcher.addEventListener(ClanNotificationEvent.REMOVE_INCOMING_NOTIFICATION,getFunctionWrapper(this.onServerRemove));
    }

    public function objectUnloaded() : void {
      if(!this.isServiceSpace()) {
        return;
      }
      ClanUserNotificationsManager.dispatcher.removeEventListener(ClanNotificationEvent.REMOVE_INCOMING_NOTIFICATION,getFunctionWrapper(this.onServerRemove));
      ClanUserNotificationsManager.resetManager();
    }

    private function onServerRemove(param1:ClanNotificationEvent) : void {
      if(!this.isServiceSpace()) {
        return;
      }
      var local2:IGameObject = clanUserService.getObjectById(param1.id);
      server.removeNotification(local2);
    }

    private function isServiceSpace() : Boolean {
      return IClanUserModel(object.adapt(IClanUserModel)).loadingInServiceSpace();
    }
  }
}
