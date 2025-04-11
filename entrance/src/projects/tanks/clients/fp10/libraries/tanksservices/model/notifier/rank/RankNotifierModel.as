package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.rank {
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.tanksservices.model.notifier.rank.IRankNotifierModelBase;
  import projects.tanks.client.tanksservices.model.notifier.rank.RankNotifierData;
  import projects.tanks.client.tanksservices.model.notifier.rank.RankNotifierModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  [ModelInfo]
  public class RankNotifierModel extends RankNotifierModelBase implements IRankNotifierModelBase, UserRefresh, ObjectLoadListener {
    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private var data:Dictionary = new Dictionary();

    public function RankNotifierModel() {
      super();
    }

    public function objectLoaded() : void {
      userPropertiesService.initRank(getInitParam().rank);
    }

    public function setRank(param1:Vector.<RankNotifierData>) : void {
      var local2:RankNotifierData = null;
      for each(local2 in param1) {
        this.setAndUpdateConsumer(local2);
      }
    }

    public function setAndUpdateConsumer(param1:RankNotifierData) : void {
      var local4:UserInfoConsumer = null;
      var local2:Long = param1.userId;
      this.data[local2] = param1.rank;
      var local3:UserNotifier = UserNotifier(object.adapt(UserNotifier));
      if(local3.hasDataConsumer(local2)) {
        local4 = local3.getDataConsumer(local2);
        local4.setRank(param1.rank);
      }
    }

    public function refresh(param1:Long, param2:UserInfoConsumer) : void {
      if(param1 in this.data) {
        param2.setRank(this.data[param1]);
      }
    }

    public function remove(param1:Long) : void {
      delete this.data[param1];
    }
  }
}
