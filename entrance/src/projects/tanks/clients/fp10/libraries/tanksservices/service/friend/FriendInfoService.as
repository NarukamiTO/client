package projects.tanks.clients.fp10.libraries.tanksservices.service.friend {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
  import platform.client.fp10.core.network.handler.OnConnectionClosedServiceListener;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendInfoConsumer;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.friends.FriendState;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.TimeOutTruncateConsumers;

  public class FriendInfoService extends EventDispatcher implements IFriendInfoService, OnConnectionClosedServiceListener {
    private var consumers:Dictionary = new Dictionary();
    private var friends:Dictionary = new Dictionary();
    private var newAcceptedFriends:Dictionary = new Dictionary();
    private var newIncomingFriends:Dictionary = new Dictionary();
    private var truncateConsumers:TimeOutTruncateConsumers;

    public function FriendInfoService() {
      super();
      this.truncateConsumers = new TimeOutTruncateConsumers();
      this.truncateConsumers.consumers = this.consumers;
      this.truncateConsumers.truncateFunction = this.unSubscribe;
    }

    private static function getDictionaryLengthByValue(param1:Dictionary, param2:Object = null) : int {
      var local4:Object = null;
      var local3:int = 0;
      for each(local4 in param1) {
        if(param2 != null) {
          if(local4 == param2) {
            local3++;
          }
        } else {
          local3++;
        }
      }
      return local3;
    }

    public function onConnectionClosed(param1:ConnectionCloseStatus) : void {
      this.consumers = new Dictionary();
      this.friends = new Dictionary();
      this.newAcceptedFriends = new Dictionary();
      this.newIncomingFriends = new Dictionary();
    }

    private function subscribe(param1:Long, param2:FriendInfoConsumer) : void {
      this.consumers[param1] = param2;
      if(param1 in this.friends) {
        this.notifyConsumer(param1,this.friends[param1]);
      }
    }

    private function unSubscribe(param1:Vector.<Long>) : void {
      var local2:Long = null;
      for each(local2 in param1) {
        delete this.consumers[local2];
      }
    }

    public function setFriendState(param1:Long, param2:FriendState) : void {
      var local3:FriendState = this.getFriendState(param1);
      this.friends[param1] = param2;
      this.notifyConsumer(param1,param2);
      dispatchEvent(new FriendStateChangeEvent(FriendStateChangeEvent.CHANGE,param1,param2,local3));
    }

    public function getFriendsIdByState(param1:FriendState) : Vector.<Long> {
      var local3:* = undefined;
      var local2:Vector.<Long> = new Vector.<Long>();
      for(local3 in this.friends) {
        if(this.friends[local3] == param1) {
          local2.push(local3);
        }
      }
      return local2;
    }

    public function deleteFriend(param1:Long, param2:FriendState) : void {
      var local3:FriendState = null;
      if(this.isFriendsInState(param1,param2)) {
        local3 = this.getFriendState(param1);
        delete this.friends[param1];
        this.notifyConsumer(param1,FriendState.UNKNOWN);
        dispatchEvent(new FriendStateChangeEvent(FriendStateChangeEvent.CHANGE,param1,FriendState.UNKNOWN,local3));
      }
    }

    public function getConsumer(param1:Long) : FriendInfoConsumer {
      return this.consumers[param1];
    }

    private function notifyConsumer(param1:Long, param2:FriendState) : void {
      if(param1 in this.consumers) {
        this.getConsumer(param1).setFriendState(param2);
      }
    }

    public function getOrCreateUpdater(param1:Long) : IFriendsInfoLabelUpdater {
      var local2:FriendsInfoLabelUpdater = null;
      this.truncateConsumers.updateLastAccessTime(param1);
      if(param1 in this.consumers) {
        local2 = this.consumers[param1];
      } else {
        local2 = new FriendsInfoLabelUpdater();
        this.consumers[param1] = local2;
        this.subscribe(param1,local2);
      }
      local2.updateLastAccessTime();
      return local2;
    }

    public function isFriendsInState(param1:Long, param2:FriendState) : Boolean {
      return this.friends[param1] == param2;
    }

    public function getFriendState(param1:Long) : FriendState {
      if(param1 in this.friends) {
        return this.friends[param1];
      }
      return FriendState.UNKNOWN;
    }

    public function get acceptedFriendsLength() : int {
      return getDictionaryLengthByValue(this.friends,FriendState.ACCEPTED);
    }

    public function get incomingFriendsLength() : int {
      return getDictionaryLengthByValue(this.friends,FriendState.INCOMING);
    }

    public function onAddNewAcceptedFriend(param1:Long) : void {
      this.newAcceptedFriends[param1] = true;
      this.dispatchChangeNewAcceptedFriend(param1);
    }

    public function onRemoveNewAcceptedFriend(param1:Long) : void {
      delete this.newAcceptedFriends[param1];
      this.dispatchChangeNewAcceptedFriend(param1);
    }

    public function removeNewAcceptedFriend(param1:Long) : void {
      dispatchEvent(new NewFriendRemoveEvent(NewFriendRemoveEvent.ACCEPTED,param1));
    }

    public function isNewAcceptedFriend(param1:Long) : Boolean {
      return param1 in this.newAcceptedFriends;
    }

    public function get newAcceptedFriendsLength() : int {
      return getDictionaryLengthByValue(this.newAcceptedFriends);
    }

    private function dispatchChangeNewAcceptedFriend(param1:Long) : void {
      dispatchEvent(new NewFriendEvent(NewFriendEvent.ACCEPTED_CHANGE,param1));
    }

    public function onAddNewIncomingFriend(param1:Long) : void {
      this.newIncomingFriends[param1] = true;
      this.dispatchChangeNewIncommingFriend(param1);
    }

    public function onRemoveNewIncomingFriend(param1:Long) : void {
      delete this.newIncomingFriends[param1];
      this.dispatchChangeNewIncommingFriend(param1);
    }

    public function removeNewIncomingFriend(param1:Long) : void {
      dispatchEvent(new NewFriendRemoveEvent(NewFriendRemoveEvent.INCOMING,param1));
    }

    public function isNewIncomingFriend(param1:Long) : Boolean {
      return param1 in this.newIncomingFriends;
    }

    public function get newIncomingFriendsLength() : int {
      return getDictionaryLengthByValue(this.newIncomingFriends);
    }

    private function dispatchChangeNewIncommingFriend(param1:Long) : void {
      dispatchEvent(new NewFriendEvent(NewFriendEvent.INCOMING_CHANGE,param1));
    }

    public function isNewFriend(param1:Long) : Boolean {
      return this.isNewAcceptedFriend(param1) || this.isNewIncomingFriend(param1);
    }
  }
}
