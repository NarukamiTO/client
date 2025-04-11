package alternativa.tanks.service.socialnetwork.vk {
  public class SNFriendsServiceData {
    private var friends:String;

    public function SNFriendsServiceData(param1:String) {
      super();
      this.friends = param1;
    }

    public function areFriends(param1:String) : Boolean {
      return this.friends.indexOf(param1) > -1;
    }
  }
}
