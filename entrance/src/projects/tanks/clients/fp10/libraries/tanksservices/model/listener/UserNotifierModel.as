package projects.tanks.clients.fp10.libraries.tanksservices.model.listener {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.tanksservices.model.listener.IUserNotifierModelBase;
  import projects.tanks.client.tanksservices.model.listener.UserNotifierModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;

  [ModelInfo]
  public class UserNotifierModel extends UserNotifierModelBase implements IUserNotifierModelBase, UserNotifier, ObjectLoadListener, ObjectUnloadListener {
    [Inject]
    public static var userInfoService:IUserInfoService;

    public function UserNotifierModel() {
      super();
    }

    public function subcribe(param1:Long, param2:UserInfoConsumer) : void {
      this.refresh(param1,param2);
      server.subscribe(param1);
    }

    public function refresh(param1:Long, param2:UserInfoConsumer) : void {
      UserRefresh(object.event(UserRefresh)).refresh(param1,param2);
    }

    public function unsubcribe(param1:Vector.<Long>) : void {
      var local2:Long = null;
      for each(local2 in param1) {
        UserRefresh(object.event(UserRefresh)).remove(local2);
      }
      server.unsubscribe(param1);
    }

    public function hasDataConsumer(param1:Long) : Boolean {
      return userInfoService.hasConsumer(param1);
    }

    public function getDataConsumer(param1:Long) : UserInfoConsumer {
      return userInfoService.getConsumer(param1);
    }

    public function objectLoaded() : void {
      userInfoService.init(object);
    }

    public function objectUnloaded() : void {
      userInfoService.unload();
    }

    public function getCurrentUserId() : Long {
      return getInitParam().currentUserId;
    }
  }
}
