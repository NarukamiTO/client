package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.socialnetworks {
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import projects.tanks.client.tanksservices.model.notifier.socialnetworks.ISNUidNotifierModelBase;
  import projects.tanks.client.tanksservices.model.notifier.socialnetworks.SNUidNotifierData;
  import projects.tanks.client.tanksservices.model.notifier.socialnetworks.SNUidNotifierModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;

  [ModelInfo]
  public class SNUidNotifierModel extends SNUidNotifierModelBase implements ISNUidNotifierModelBase, UserRefresh {
    private var data:Dictionary = new Dictionary();

    public function SNUidNotifierModel() {
      super();
    }

    public function setSNUid(param1:Vector.<SNUidNotifierData>) : void {
      var local2:SNUidNotifierData = null;
      for each(local2 in param1) {
        this.setAndUpdateConsumer(local2);
      }
    }

    private function setAndUpdateConsumer(param1:SNUidNotifierData) : void {
      var local4:UserInfoConsumer = null;
      var local2:Long = param1.userId;
      this.data[local2] = param1.snUid;
      var local3:UserNotifier = UserNotifier(object.adapt(UserNotifier));
      if(local3.hasDataConsumer(local2)) {
        local4 = local3.getDataConsumer(local2);
        local4.setSNUid(param1.snUid);
      }
    }

    public function refresh(param1:Long, param2:UserInfoConsumer) : void {
      if(param1 in this.data) {
        param2.setSNUid(this.data[param1]);
      }
    }

    public function remove(param1:Long) : void {
      delete this.data[param1];
    }
  }
}
