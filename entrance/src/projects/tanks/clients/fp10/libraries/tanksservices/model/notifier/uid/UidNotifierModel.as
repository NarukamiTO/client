package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.uid {
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import projects.tanks.client.tanksservices.model.notifier.uid.IUidNotifierModelBase;
  import projects.tanks.client.tanksservices.model.notifier.uid.UidNotifierData;
  import projects.tanks.client.tanksservices.model.notifier.uid.UidNotifierModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;

  [ModelInfo]
  public class UidNotifierModel extends UidNotifierModelBase implements IUidNotifierModelBase, UserRefresh {
    private var data:Dictionary = new Dictionary();

    public function UidNotifierModel() {
      super();
    }

    public function setUid(param1:Vector.<UidNotifierData>) : void {
      var local2:UidNotifierData = null;
      for each(local2 in param1) {
        this.setAndUpdateConsumer(local2);
      }
    }

    private function setAndUpdateConsumer(param1:UidNotifierData) : void {
      var local4:UserInfoConsumer = null;
      var local2:Long = param1.userId;
      this.data[local2] = param1.uid;
      var local3:UserNotifier = UserNotifier(object.adapt(UserNotifier));
      if(local3.hasDataConsumer(local2)) {
        local4 = local3.getDataConsumer(local2);
        local4.setUid(param1.uid);
      }
    }

    public function refresh(param1:Long, param2:UserInfoConsumer) : void {
      if(param1 in this.data) {
        param2.setUid(this.data[param1]);
      }
    }

    public function remove(param1:Long) : void {
      delete this.data[param1];
    }
  }
}
