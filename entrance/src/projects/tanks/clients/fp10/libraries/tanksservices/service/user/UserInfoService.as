package projects.tanks.clients.fp10.libraries.tanksservices.service.user {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.listener.UserNotifier;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.UserInfoConsumer;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.TimeOutTruncateConsumers;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;

  public class UserInfoService extends EventDispatcher implements IUserInfoService {
    [Inject]
    public static var premiumService:PremiumService;

    private var consumers:Dictionary;
    private var unsubscribedConsumers:Dictionary;
    private var serviceObject:IGameObject;
    private var truncateConsumers:TimeOutTruncateConsumers;
    private var stateOffer:Boolean;

    public function UserInfoService() {
      super();
    }

    public function init(param1:IGameObject) : void {
      this.serviceObject = param1;
      this.truncateConsumers = new TimeOutTruncateConsumers();
      this.truncateConsumers.consumers = this.consumers;
      this.truncateConsumers.truncateFunction = this.unSubscribe;
      this.consumers = new Dictionary();
      this.unsubscribedConsumers = new Dictionary();
    }

    public function getOrCreateUpdater(param1:Long) : IUserInfoLabelUpdater {
      var local2:UserInfoLabelUpdater = null;
      if(this.hasConsumer(param1)) {
        local2 = this.consumers[param1];
      } else {
        local2 = new UserInfoLabelUpdater();
        if(param1 in this.unsubscribedConsumers) {
          this.subscribe(param1,local2);
        } else {
          this.refresh(param1,local2);
        }
      }
      local2.updateLastAccessTime();
      return local2;
    }

    public function forciblySubscribe(param1:Long) : void {
      var local2:UserInfoLabelUpdater = null;
      if(!this.hasConsumer(param1)) {
        local2 = new UserInfoLabelUpdater();
        this.subscribe(param1,local2);
        local2.updateLastAccessTime();
      }
    }

    private function subscribe(param1:Long, param2:UserInfoConsumer) : void {
      delete this.unsubscribedConsumers[param1];
      this.consumers[param1] = param2;
      UserNotifier(this.serviceObject.adapt(UserNotifier)).subcribe(param1,param2);
    }

    private function refresh(param1:Long, param2:UserInfoConsumer) : void {
      this.consumers[param1] = param2;
      UserNotifier(this.serviceObject.adapt(UserNotifier)).refresh(param1,param2);
    }

    private function unSubscribe(param1:Vector.<Long>) : void {
      var local2:Long = null;
      for each(local2 in param1) {
        this.unsubscribedConsumers[local2] = true;
        delete this.consumers[local2];
      }
      UserNotifier(this.serviceObject.adapt(UserNotifier)).unsubcribe(param1);
    }

    public function hasConsumer(param1:Long) : Boolean {
      return param1 in this.consumers;
    }

    public function getConsumer(param1:Long) : UserInfoConsumer {
      return this.consumers[param1];
    }

    public function unload() : void {
      this.truncateConsumers.stop();
      this.truncateConsumers = null;
      this.consumers = null;
      this.unsubscribedConsumers = null;
      this.serviceObject = null;
      this.stateOffer = false;
    }

    public function getCurrentUserId() : Long {
      return UserNotifier(this.serviceObject.adapt(UserNotifier)).getCurrentUserId();
    }

    public function isOffer() : Boolean {
      return this.stateOffer;
    }

    public function setOffer(param1:Boolean) : void {
      this.stateOffer = param1;
    }

    public function hasPremium(param1:Long) : Boolean {
      return this.getCurrentUserId() == param1 && Boolean(premiumService.hasPremium());
    }
  }
}
