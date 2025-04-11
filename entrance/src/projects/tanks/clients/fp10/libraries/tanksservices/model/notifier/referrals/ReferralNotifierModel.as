package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.referrals {
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import projects.tanks.client.tanksservices.model.notifier.referrals.IReferralNotifierModelBase;
  import projects.tanks.client.tanksservices.model.notifier.referrals.ReferralNotifierData;
  import projects.tanks.client.tanksservices.model.notifier.referrals.ReferralNotifierModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.UserRefresh;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;

  [ModelInfo]
  public class ReferralNotifierModel extends ReferralNotifierModelBase implements IReferralNotifierModelBase, UserRefresh {
    private var data:Dictionary = new Dictionary();

    public function ReferralNotifierModel() {
      super();
    }

    public function setIsReferral(param1:Vector.<ReferralNotifierData>) : void {
      var local2:ReferralNotifierData = null;
      for each(local2 in param1) {
        this.setAndUpdateConsumer(local2);
      }
    }

    private function setAndUpdateConsumer(param1:ReferralNotifierData) : void {
      var local4:UserInfoConsumer = null;
      var local2:Long = param1.userId;
      this.data[local2] = param1.referral;
      var local3:UserNotifier = UserNotifier(object.adapt(UserNotifier));
      if(local3.hasDataConsumer(local2)) {
        local4 = local3.getDataConsumer(local2);
        local4.setIsReferral(param1.referral);
      }
    }

    public function refresh(param1:Long, param2:UserInfoConsumer) : void {
      if(param1 in this.data) {
        param2.setIsReferral(this.data[param1]);
      }
    }

    public function remove(param1:Long) : void {
      delete this.data[param1];
    }
  }
}
